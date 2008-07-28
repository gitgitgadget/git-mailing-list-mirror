From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 15:26:33 -0700 (PDT)
Message-ID: <m3r69dtzm9.fsf@localhost.localdomain>
References: <20080728162003.GA4584@artemis.madism.org>
	<320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	<20080728205545.GB10409@artemis.madism.org>
	<20080728205923.GC10409@artemis.madism.org>
	<32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
	<20080728220308.GF10409@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbBp-0002Lb-To
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbYG1W0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbYG1W0h
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:26:37 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:14232 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYG1W0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:26:36 -0400
Received: by ik-out-1112.google.com with SMTP id c28so4369696ika.5
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=q5IcbWN/U23BSVJkRRvBZOt09CfZsdug/woNYdrVYQA=;
        b=Pg54LPXBa9DOsB4kIvXHFaqA1gNtC8/RHrDjqYh3ld0c+LHQvb6VsY7zlkpk22feW/
         GkvePkXX78rCeRKi68EZ7lSCK8kl4IpDfP4pv9EsB6E+iBY5cWG60Lo6MGdZJmCmyNcY
         ViX9UMKoWZmK0hcSZePRaqVWorhRFC6ulaUMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HctbGlBGn4SZOlWpw04WlJ3gH02e+oehVLRKvbbFqYDIqYwuNVAWYFxnGzdSun/Wjq
         oMtpxydBZj6Ii0vmZwhojT6VDz8m/ey3bjo4TBsVAdQ7yF2rZxYkdEsM+Lt4YcsOWs7F
         ZH3ZaRyQcXpbQYJvuNnGvA+BK8sci5RawUdwA=
Received: by 10.210.30.1 with SMTP id d1mr6623848ebd.41.1217283994914;
        Mon, 28 Jul 2008 15:26:34 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.7])
        by mx.google.com with ESMTPS id k9sm27514428nfh.23.2008.07.28.15.26.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 15:26:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6SMQ74N005490;
	Tue, 29 Jul 2008 00:26:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6SMPphf005483;
	Tue, 29 Jul 2008 00:25:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080728220308.GF10409@artemis.madism.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90513>

Pierre Habouzit <madcoder@debian.org> writes:
> On Mon, Jul 28, 2008 at 09:40:22PM +0000, Avery Pennarun wrote:

> > Further, if you don't have a separate .git directory for each
> > submodule, you can't *switch* branches on the submodule independently
> > of the supermodule in any obvious way.
> 
> Yes you can, in what I propose you have a dummy .git in each submodule,
> with probably an index, a HEAD and a config file (maybe some other
> things along) to allow that especially.

What you are (re)inventing here is something called gitlink (.git which
is a file, or .gitlink file); not to be confused with 'sumbodule'/'commit'
entry in a tree which is sometimes called gitlink.  Alternate idea was
'unionfs' like "shadowing" .git, with 'core.gitdir' in .git/config
(which would contain .git/HEAD and .git/index, and all missing files
and config would be taken from `core.gitdir').

There was even some preliminary implementation IIRC, but AFAIR it
was abandoned because of no "real usage".

See
  http://permalink.gmane.org/gmane.comp.version-control.msysgit/1868
  http://permalink.gmane.org/gmane.comp.version-control.git/72449
  http://permalink.gmane.org/gmane.comp.version-control.git/72457
  http://permalink.gmane.org/gmane.comp.version-control.git/72296
-- 
Jakub Narebski
Poland
ShadeHawk on #git
