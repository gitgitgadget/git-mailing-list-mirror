From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: using merge subtree and move it..
Date: Tue, 09 Sep 2008 08:56:31 +0200
Message-ID: <48C61E1F.6000907@viscovery.net>
References: <ga4fho$5ib$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: SungHyun Nam <namsh@posdata.co.kr>
X-From: git-owner@vger.kernel.org Tue Sep 09 08:57:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcxAQ-0006Qy-P5
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 08:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbYIIG4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 02:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbYIIG4f
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 02:56:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28280 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbYIIG4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 02:56:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kcx9L-0007Ck-Pd; Tue, 09 Sep 2008 08:56:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8AE5969F; Tue,  9 Sep 2008 08:56:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ga4fho$5ib$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95342>

SungHyun Nam schrieb:
> I used the subtree merge strategy. And then I moved the directory.
> Now, can I use subtree merge for that new directory?

Sure. It should work just fine.

> $ git pull -s subtree klib master
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 3 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From ssh://192.168.10.10/git/libs/klib
>  * branch            master     -> FETCH_HEAD
> error: Entry 'klib/klib.c' not uptodate. Cannot merge.

Your problem is not related to subtree merge. Make sure you have no
changes to commit before you merge.

> fatal: merging of trees 31dd1721641a25bfb0225138a34c43483d870377 and
> bccba7da98b042817fdbd92c62b706919216b571 failed
> Merge with strategy subtree failed.

-- Hannes
