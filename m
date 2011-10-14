From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Fri, 14 Oct 2011 10:51:16 +0400
Message-ID: <20111014105116.1e5afa5d@ashu.dyn.rarus.ru>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org>
	<4E96D819.20905@op5.se>
	<loom.20111013T152144-60@post.gmane.org>
	<1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	<loom.20111013T171530-970@post.gmane.org>
	<20111013201711.3d55c693@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 08:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REbcJ-0000mR-Os
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 08:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab1JNGvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 02:51:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43504 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1JNGvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 02:51:22 -0400
Received: by wyg34 with SMTP id 34so2653429wyg.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=8wns3Ml7Lwt/LzaIdUZ9zZdm6HvPfOT+rPQjZ6oSi0Y=;
        b=Q993Z2P1wMoFrrtDU17fhd5Waf3fy2MzF7JrUPQmGTekNlwjLyLPSpWLNF3l8zDXfj
         Q0lJpyIcgZAxVM3WrwcJGanHUcNcuWsTe5bCI7P8aVFE2RNMv27wNWWh4RZnfrUWFswF
         M05jjMMxSseasBkgVEBpRVh01TriaKpyB6oqc=
Received: by 10.216.159.129 with SMTP id s1mr1198243wek.3.1318575080601;
        Thu, 13 Oct 2011 23:51:20 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id h39sm12440524wbo.0.2011.10.13.23.51.18
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 23:51:19 -0700 (PDT)
In-Reply-To: <20111013201711.3d55c693@ashu.dyn.rarus.ru>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183542>

> > Lucky you. :P  The most likely reason for me is, I'm working on
> > something and I get interrupted and have to switch. Since the code
> > may well not even compile at this point, the last thing I want to do
> > is commit it. 
> "git stash" helps here
> With Git you can/have_to/must change your SVN-based habits.
> DO NOT BE AFRAID OF FREQUENT COMMITS!
> There are local until you push them.
> 
> >git's ability for that commit to be local is half the
> > reason I'm trying to switch to it.
> You always have a chance to modify/reedit you commits
> see "git commit --amend" and "git rebase [-i]"
> 
> I'm telling you it as an ex-SVN user.
> >(I'm not particularly keen on
> > having to commit broken code to even a local repo, but that's still
> > a hell of a lot better than having it pushed upstream as well).
> 
> Again, do not be afraid to commit your changes. Be afraid of losing
> your changes. Git makes everything (as other discussion participants
> already described) to keep your changes within workflow when you
> switch between branches often.
> 
> Read some books which are describe Git's usual (and effective)
> workflow, ProGit - http://progit.org/book/
> Version Contol by Example (there is a chapter about Git) -
> http://git-scm.com/course/svn.html
oops,
wrong url

fixed link
Version Contol by Example (there is a chapter about Git) -
http://www.ericsink.com/vcbe/
