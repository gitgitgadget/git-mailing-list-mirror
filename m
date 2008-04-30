From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 03:39:34 -0700 (PDT)
Message-ID: <m3hcdjocdc.fsf@localhost.localdomain>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
	<cac9e4380804300122v4f23251cqbc36640a07379c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Richard Quirk" <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:40:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9jh-0003Ut-62
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004AbYD3Kjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756909AbYD3Kjj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:39:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:32587 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbYD3Kjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:39:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so107098fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=7hnawHScow4pgvZ81mSKM4CXklDw/+QDiSCfhC3ijC8=;
        b=oco2sIDAWk/VYZWZKQWXRVuPf+fnpLwDl/n0HjAAiSuXS22qwdMNYcgCo3DN7chIpDTNvhcLrkvDwWfvREqGH8zs7cV2SJoVU+b6l1KaTz4Najc69kjvLfdW78z9dwjXkp3J5803OHDo53EaGn8tkvt8h4RBCsfX/mS7t0zLfeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=xPFTTdMPyxpKEMFQGMR7Oy7tPh2/5/n4EoHzZDDazFM+iHFMOMLbgiD7evMaDjiykIpVN0klIKNah3aiD017yxDaIEwNEx3gWuNMPyhNFCuh++vJh6hQjvkO1SLtZdvuAZGN6oroqtld0m4dgq1OgKjZmDk9LrnKQztlqML1zlg=
Received: by 10.86.61.11 with SMTP id j11mr509421fga.69.1209551975409;
        Wed, 30 Apr 2008 03:39:35 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.201.205])
        by mx.google.com with ESMTPS id e11sm585890fga.1.2008.04.30.03.39.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 03:39:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3UAdU4n001638;
	Wed, 30 Apr 2008 12:39:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3UAdSAK001635;
	Wed, 30 Apr 2008 12:39:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cac9e4380804300122v4f23251cqbc36640a07379c8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80826>

"Richard Quirk" <richard.quirk@gmail.com> writes:

> On Tue, Apr 29, 2008 at 7:37 PM, Daniel Quinlan <danq@brtt.com> wrote:
> 
>> 3) Similarly, I can't use the little context diffs I can see in
>> git-gui -- I need to see side by side comparisons; I've become
>> accustomed to tkdiff.  It seems like git mergetool knows how to do
>> that in some restricted circumstances, but I want to do it outside
>> the context of a merge.
> 
> If you use Vim, I'd recommend the vcscommand plugin - see
> http://code.google.com/p/vcscommand/ - which has fairly recently added
> git support. Once installed :VCSVimDiff shows the diff side by side
> between working copy and HEAD (by default, or whatever revision you
> tell it) like a regular vimdiff between files.

Could you add infomration about this to Git Wiki
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
somewhere in "Editors and IDE integration" subsection?

TIA
-- 
Jakub Narebski
GNU Emacs user
