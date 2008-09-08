From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Windows: git-shell can be compiled again
Date: Mon, 08 Sep 2008 13:53:40 +0200
Message-ID: <48C51244.6060807@viscovery.net>
References: <321897.23044.qm@web95004.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kevin Yu <yujie052@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 13:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcfKV-0001i1-7I
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 13:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYIHLxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 07:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYIHLxk
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 07:53:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29247 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbYIHLxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 07:53:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KcfJI-0006sw-Gd; Mon, 08 Sep 2008 13:53:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 549CB6B7; Mon,  8 Sep 2008 13:53:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <321897.23044.qm@web95004.mail.in2.yahoo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95241>

dhruva schrieb:
>  Are there any M$ specific issues still out there that needs some attention? I could help on stuff that does not require git internal knowledge. Are there some M$ specific performance issues that I could try to help? Let me know, I will try my best to help. I need to have git on both GNU/linux and M$ platforms for day job.

In order of increasing difficulty:

- Run the tests on different platforms and servicepack levels.

- Get proficient in building the installer for a release.

- Find a way to build perl scripts that is acceptable for upstream git.git
and that also works on MSYS/MinGW. Currently we still modify the build
procedure, and the results do not work during 'make test'.

- Give some love to git-svn.perl. It will be removed from msysgit's
1.6.0.x release because it raises expectations that cannot be fulfilled.
Please dig the list archive: http://groups.google.com/group/msysgit

I don't think a lot can be done performance-wise unless you want to help
port scripts to C.

-- Hannes
