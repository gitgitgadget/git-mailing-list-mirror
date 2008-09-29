From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git can't find none
Date: Mon, 29 Sep 2008 13:34:16 +0200
Message-ID: <48E0BD38.6070602@viscovery.net>
References: <48E0B8FE.6060203@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
X-From: git-owner@vger.kernel.org Mon Sep 29 13:35:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkH2I-0007xg-EX
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 13:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYI2LeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 07:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYI2LeU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 07:34:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3730 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbYI2LeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 07:34:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkH16-0007Z1-Ur; Mon, 29 Sep 2008 13:34:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AA5FEAFCC; Mon, 29 Sep 2008 13:34:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48E0B8FE.6060203@cetrtapot.si>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97004>

Hinko Kocevar schrieb:
> Hi,
> 
> I've recently discovered that some git command stopped working. I'm not sure if this is related to my git tree or not, it happens on other trees too:
> $ git blame Makefile 
> sh: none: command not found
> 
> 'none' ?

Try

   $ git --no-pager blame Makefile

and if that works, correct your setting of PAGER or GIT_PAGER, e.g.

   $ export GIT_PAGER=cat

-- Hannes
