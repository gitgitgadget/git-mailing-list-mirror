From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: Git checkout: difference in behavior and what is in the documentation
Date: Fri, 2 Jul 2010 08:29:28 +0000 (UTC)
Message-ID: <Xns9DA96096F7CEChrisCheneytesconet@80.91.229.10>
References: <AANLkTil4LcA0F5FEeoKOnR7Ko_gEpMHD_HCi3FPTG55D@mail.gmail.com> <201007020809.17551.markus.heidelberg@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 10:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUbd4-0004lV-4t
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 10:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab0GBI3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 04:29:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:36622 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab0GBI3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 04:29:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OUbcu-0004gr-Fu
	for git@vger.kernel.org; Fri, 02 Jul 2010 10:29:36 +0200
Received: from 82.2.79.10 ([82.2.79.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 10:29:36 +0200
Received: from chris.cheney.nospam by 82.2.79.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 10:29:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 82.2.79.10
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150117>

Markus Heidelberg <markus.heidelberg@web.de> wrote in 
news:201007020809.17551.markus.heidelberg@web.de:

> Sabyasachi Ruj, 2010-07-02 07:30:
>> I've asked the question in detail in Stack Overflow:
>> 
>> http://stackoverflow.com/questions/3163325/confusion-about-git-checkout
> 
> You should rather post the question and not only the link. Here is the
> relevant part:
> 
>> I am confused about a behavior of git checkout. The documentation of git
>> checkout says:
>> 
>> --merge 
>> When switching branches, if you have local modifications to one or
>> more files that are different between the current branch and the
>> branch to which you are switching, the command refuses to switch
>> branches in order to preserve your modifications in context. However,
>> with this option, a three-way merge between the current branch, your
>> working tree contents, and the new branch is done, and you will be on
>> the new branch.
>> 
>> But, I have done a small test which is not behaving as said in the bold
>> part. That is:
>> 1. I create a git repo
>> 2. create a directory and a file with some conent and commit it in
>>    master branch.
>> 3. Create another branch "testbranch"
>> 4. change the content of the file in master. But did not commit.
>> 5. switched to "testbranch". 
>> 6. Now the changed and uncommitted changes from master branch come to
>>    testbranch!
>> 
>> Wasn't it supposed to fail, if I have some local changes and wanted to
>> switch to a branch?
> 
> 'master' and 'testbranch' are the same, 

Rather, 'master' and 'testbranch' are the names of different branches, but 
they identify the same commit at that time.
