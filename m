From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: The msysGit Herald, issue 2
Date: Mon, 24 Sep 2007 18:15:33 +0200
Message-ID: <46F7E2A5.6030202@eudaptics.com>
References: <Pine.LNX.4.64.0709232153230.28395@racer.site> <alpine.LFD.0.999.0709240840310.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:16:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZqb6-0000cB-Lc
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbXIXQPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757504AbXIXQPl
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:15:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5373 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411AbXIXQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:15:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IZqau-0008Vu-TA; Mon, 24 Sep 2007 18:15:37 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 159644E4; Mon, 24 Sep 2007 18:15:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.0.999.0709240840310.3579@woody.linux-foundation.org>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.397, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59057>

Linus Torvalds schrieb:
> 
> On Sun, 23 Sep 2007, Johannes Schindelin wrote:
>>> 6) What was the most frustrating moment when working with Git?
>> Just the other day, I wanted to fetch a set of changes from a public
>> repo into my test repo in order to cherry-pick from them - and it
>> automatically fetched all the tags. But, the heck, I don't want them tags
>> here, just the commits. I just can't figure out how to avoid the automatic
>> fetching of tags.
> 
> The way this was *supposed* to work is that if you are not fetching a 
> "tracking branch", it should not fetch any tags.
> 
> Maybe this got broken lately?
> 
> Or maybe you did fetch a tracking branch?

I don't think I fetched a tracking branch. If I do:

    $ mkdir foo && cd foo && git init
    $ git fetch ../git master:refs/heads/master

(where ../git is a clone of git.git with a few local changes), I get all the 
tags. Good or bad?

-- Hannes
