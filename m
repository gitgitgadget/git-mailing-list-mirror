From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Git checkout: difference in behavior and what is in the documentation
Date: Fri, 2 Jul 2010 08:09:17 +0200
Message-ID: <201007020809.17551.markus.heidelberg@web.de>
References: <AANLkTil4LcA0F5FEeoKOnR7Ko_gEpMHD_HCi3FPTG55D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sabyasachi Ruj <ruj.sabya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 08:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUZRG-0004ck-5D
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 08:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0GBGJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 02:09:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41343 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0GBGJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 02:09:20 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id C6EA1159C6260;
	Fri,  2 Jul 2010 08:09:18 +0200 (CEST)
Received: from [91.19.12.53] (helo=pluto.localnet)
	by smtp04.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1OUZR8-00013v-00; Fri, 02 Jul 2010 08:09:18 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <AANLkTil4LcA0F5FEeoKOnR7Ko_gEpMHD_HCi3FPTG55D@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+ckthc4C/BeWpU88Jf2wWbZHdXsv6qp8eG7ikN
	kxYh6Oo10a1CVxYOmkWT2PrkVEqixD/HPyMNAGWQZ0t/eIKMup
	1HRrpwyuYv6hw4juqLYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150110>

Sabyasachi Ruj, 2010-07-02 07:30:
> I've asked the question in detail in Stack Overflow:
> 
> http://stackoverflow.com/questions/3163325/confusion-about-git-checkout

You should rather post the question and not only the link. Here is the
relevant part:

> I am confused about a behavior of git checkout. The documentation of git
> checkout says:
> 
> --merge 
> When switching branches, if you have local modifications to one or
> more files that are different between the current branch and the
> branch to which you are switching, the command refuses to switch
> branches in order to preserve your modifications in context. However,
> with this option, a three-way merge between the current branch, your
> working tree contents, and the new branch is done, and you will be on
> the new branch.
> 
> But, I have done a small test which is not behaving as said in the bold
> part. That is:
> 1. I create a git repo
> 2. create a directory and a file with some conent and commit it in
>    master branch.
> 3. Create another branch "testbranch"
> 4. change the content of the file in master. But did not commit.
> 5. switched to "testbranch". 
> 6. Now the changed and uncommitted changes from master branch come to
>    testbranch!
> 
> Wasn't it supposed to fail, if I have some local changes and wanted to
> switch to a branch?

'master' and 'testbranch' are the same, so there are no "files that are
different between the current branch and the branch to which you are
switching", so git doesn't have to fail.

> Even if there is no bug in the git behavior, I think the documentation
> should be more clear.

I think it's quite clear.

Markus
