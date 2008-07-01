From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 05:44:05 -0700 (PDT)
Message-ID: <m3ej6dhito.fsf@localhost.localdomain>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfEJ-0004kT-01
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbYGAMoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 08:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbYGAMoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:44:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32314 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbYGAMoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 08:44:07 -0400
Received: by ug-out-1314.google.com with SMTP id h2so391255ugf.16
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=VzbT1SHh/VECB3hhh9A9UY3vSG4F17/wvLLFbeZYkNo=;
        b=OGldRc0HF63x3fI4dBn4WsGPHNlDNlSNVbI8jUsc28DFB4SJylt4ny7A8aJp9vZwHC
         e5AlVJ18ILKEnFG8t9gj6wGBvt+6/OaZ2saXhTsNVcgbUrwhsQ6JZJKuCdB4lr9HWekp
         7KjN2ZJm7tZPJwsMpAiRRI9NtSph8QQpJyeAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qdsbu/8rvEqiHx1T/IR5VcqOWuzjPTf15Ft6oMX12bwGo9ynTdKHjSwzxsJpjjZW3/
         EIrb3sfLkwxLaxEEOmte8K7ZsxsOCJ1pbd75alyE6Uh9cqgbPv9/XFOw+Jaxa1YmUEjx
         n42GI6pME4Fa4Vt+OtUP2XgJctVno0LVJgHf8=
Received: by 10.210.141.4 with SMTP id o4mr5292747ebd.59.1214916246245;
        Tue, 01 Jul 2008 05:44:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.248.226])
        by mx.google.com with ESMTPS id h7sm6002649nfh.34.2008.07.01.05.44.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 05:44:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m61ClnMI029809;
	Tue, 1 Jul 2008 14:47:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m61CllIE029806;
	Tue, 1 Jul 2008 14:47:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <80iqvq2bw0.fsf@tiny.isode.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87030>

Bruce Stephens <bruce.stephens@isode.com> writes:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
> >
> >   Switched to branch "master"
> >   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
> >
> > it's a very useful detail! It's especially useful when two branches 
> > diverge in a non-trivial way.
> 
> I agree, it's a really nice little feature.  Indeed, I occasionally do
> "git checkout master" just to get the message (to see where I am).
> 
> It feels logical for "git status" to offer the same information (when
> the information is appropriate).

I agree that having this information in git-status would be useful,
especially that it would make having this reminder in buffer/editor
when editing commit message.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
