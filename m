From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Windows: git-shell can be compiled again
Date: Mon, 08 Sep 2008 14:22:13 +0200
Message-ID: <48C518F5.5090201@viscovery.net>
References: <117629.48595.qm@web95011.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kevin Yu <yujie052@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 14:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcfmB-0002ZE-0U
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 14:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYIHMWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 08:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYIHMWL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 08:22:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38554 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIHMWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 08:22:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kcfkq-0006pS-Vs; Mon, 08 Sep 2008 14:22:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CF4786B7; Mon,  8 Sep 2008 14:22:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <117629.48595.qm@web95011.mail.in2.yahoo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95244>

dhruva schrieb:
>> From: Johannes Sixt <j.sixt@viscovery.net>
>> - Find a way to build perl scripts that is acceptable for upstream git.git
>> and that also works on MSYS/MinGW. Currently we still modify the build
>> procedure, and the results do not work during 'make test'.
> 
> Could you please elaborate on the above. Do you mean, rewrite some perl scripts or something else?

No. I mean to have a better solution to the build procedure than commit
bd2f73a6ba6da in mingw.git. Look at that commit and at the 'use ...' line
that the build procedure inserts at the top of the perl scripts, and you
should understand the problem (hint: it's the colon in "C:/somwhere").

-- Hannes
