From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Re: Minor grammar fix in the 'Not a git repository' message
Date: Tue, 17 Feb 2009 01:29:27 -0800 (PST)
Message-ID: <m31vtxtntf.fsf@localhost.localdomain>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de>
	<20090217001747.GA23278@vidovic>
	<7vk57pevig.fsf@gitster.siamese.dyndns.org>
	<200902162116.55484.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 10:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZMI6-0005iZ-Lk
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZBQJ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZBQJ3b
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:29:31 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54113 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZBQJ3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:29:30 -0500
Received: by fxm13 with SMTP id 13so6563515fxm.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xpdoTWGEuT9DgwRvylvAvTgvxqHCaelSBv28cRDRdtk=;
        b=nyMJIc/dFNMgxc3IQFb+UJp44IKWmzhYmU2Bm+0/oO99nymwyI5y6W5v1SU9CrA5rU
         Is8INJlxaITKocbUNEGlwLlfkl7NyVt+K7tAD/15YyPsXFJAB+oke23XPCrBdg9r3C2o
         jUgfmK+TwfScVqA4OkZA/PcpK15idyphlCtSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WFacEMLMX238PMCQa3DWQJX0JqKmhvREEMqPtMkeeNOHoYwE0cEhGorbZCN2ULWvMB
         5+QKd+qd6//XgZ/nLJ6geyqfL9crrflbZbOD3qMDU9wEJbmsYX3FwLEX7ERtij4YmUbJ
         O70gprsjZUfRfpUB/j9HnCwZdfVvxsFxOfVGM=
Received: by 10.103.249.19 with SMTP id b19mr720472mus.86.1234862968385;
        Tue, 17 Feb 2009 01:29:28 -0800 (PST)
Received: from localhost.localdomain (abwe74.neoplus.adsl.tpnet.pl [83.8.228.74])
        by mx.google.com with ESMTPS id 12sm1378803muq.5.2009.02.17.01.29.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 01:29:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1H9ShKs009986;
	Tue, 17 Feb 2009 10:28:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1H9SCWF009981;
	Tue, 17 Feb 2009 10:28:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200902162116.55484.bss@iguanasuicide.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110345>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> On Monday 16 February 2009 18:51:03 Junio C Hamano wrote:
> > Nicolas Sebrecht <nicolas.s-dev@laposte.net> writes:

> > > The message
> > > 	"Not inside a git repository"
> > > of Wincent looks like the clearest and the fairest one.
> >
> > I tend to agree.  I was only trying to see if we can salvage a more
> > precise diagnosis f66bc5f (Always show which directory is not a git
> > repository, 2008-12-22) tried to give users.
> 
> "Not in a git repository or work tree: %s", DEFAULT_GIT_DIR_ENVIRONMENT
> ?

"Not in a git repository or in a work tree: %s" perhaps...
cwd or DEFAULT_GIT_DIR_ENVIRONMENT?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
