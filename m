From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 20:17:11 +0400
Message-ID: <20111013201711.3d55c693@ashu.dyn.rarus.ru>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org>
	<4E96D819.20905@op5.se>
	<loom.20111013T152144-60@post.gmane.org>
	<1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	<loom.20111013T171530-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 18:17:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RENyI-0000YO-82
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 18:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab1JMQRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 12:17:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34671 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab1JMQRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 12:17:17 -0400
Received: by wwf22 with SMTP id 22so2035030wwf.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=o0DQ11w7rqyz9SVwRFr8UOSkW7kHZjgvIXiG8IQdr6k=;
        b=dd2ZxEoeuAXznh2LCbA34LDLjsVHvMjW07F1u/3MuyVepFRJb3kzW0miKqmAXOGdvU
         TrvIQN/d6/FhHUZ1FlmPHAy4MEgbCudqtUp/Zpi12+zG/4y5WpE6BCHre/mJhWLkfQ35
         7EQo4R/m3YNFPHFgZng4opHYyvQtTmg5MioAk=
Received: by 10.227.150.207 with SMTP id z15mr1544004wbv.66.1318522635811;
        Thu, 13 Oct 2011 09:17:15 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id l9sm6941839wba.5.2011.10.13.09.17.14
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 09:17:15 -0700 (PDT)
In-Reply-To: <loom.20111013T171530-970@post.gmane.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183494>

> Lucky you. :P  The most likely reason for me is, I'm working on
> something and I get interrupted and have to switch. Since the code
> may well not even compile at this point, the last thing I want to do
> is commit it. 
"git stash" helps here
With Git you can/have_to/must change your SVN-based habits.
DO NOT BE AFRAID OF FREQUENT COMMITS!
There are local until you push them.

>git's ability for that commit to be local is half the
> reason I'm trying to switch to it.
You always have a chance to modify/reedit you commits
see "git commit --amend" and "git rebase [-i]"

I'm telling you it as an ex-SVN user.
>(I'm not particularly keen on
> having to commit broken code to even a local repo, but that's still a
> hell of a lot better than having it pushed upstream as well).

Again, do not be afraid to commit your changes. Be afraid of losing
your changes. Git makes everything (as other discussion participants
already described) to keep your changes within workflow when you
switch between branches often.

Read some books which are describe Git's usual (and effective) workflow,
ProGit - http://progit.org/book/
Version Contol by Example (there is a chapter about Git) -
http://git-scm.com/course/svn.html

Hope, you'll feel the power of Git ))
