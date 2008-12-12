From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: help needed: Splitting a git repository after subversion migration
Date: Fri, 12 Dec 2008 15:22:15 +0100
Organization: Intra2net AG
Message-ID: <200812121522.38791.thomas.jarosch@intra2net.com>
References: <493C0AAD.1040208@intra2net.com> <200812101733.36221.thomas.jarosch@intra2net.com> <20081211081009.GA14639@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 15:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB8wK-0008Ar-R7
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 15:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758890AbYLLOWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 09:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758170AbYLLOWt
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 09:22:49 -0500
Received: from re01.intra2net.com ([82.165.28.202]:49319 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797AbYLLOWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 09:22:47 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 41D344E6E;
	Fri, 12 Dec 2008 15:22:46 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id D7A9B2AC4B;
	Fri, 12 Dec 2008 15:22:45 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id DB92A2AC4A;
	Fri, 12 Dec 2008 15:22:44 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <20081211081009.GA14639@atjola.homenet>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-12_07)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102898>

On Thursday, 11. December 2008 09:10:09 you wrote:
> > Now I'll manually check the history of the tags/ and branches/ folder
> > for more funny tags and write down the revision. If I understood
> > the git-svn man page correctly, I should be able to specifiy
> > revision ranges it's going to import. I'll try to skip the broken tags.
>
> As long as the breakage only involves branches/tags that are completely
> useless, it's probably a lot easier to just delete them afterwards.
>
> And if you accidently added changes to a tag, after it was created, it's
> also easier to manually tag to right version in git, and just forgetting
> about the additional commit.
>
> And for a bunch of other cases, rebase -i/filter-branch are probably
> also better options ;-)
>
> Skipping revisions in a git-svn import sounds rather annoying and
> error-prone.

Sounds very reasonable. When I'm done filtering with filter-branch,
the original commits are still stored in "refs/originals" and the reflogs.
What's the best way to get rid of those to free up the space?

A nice way to find the corresponding commit for a file can be found here: 
http://stackoverflow.com/questions/223678/git-which-commit-has-this-blob

Thanks for your help so far!

Thomas

PS: Yes, I have a backup copy of the repository ;-)
