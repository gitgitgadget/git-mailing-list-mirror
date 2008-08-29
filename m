From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix a warning (on cygwin) to allow -Werror
Date: Fri, 29 Aug 2008 08:23:05 +0200
Message-ID: <48B795C9.6010009@viscovery.net>
References: <48B4426D.3090801@ramsay1.demon.co.uk> <48B508F0.70402@viscovery.net> <48B6CD9F.6020302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 29 08:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYxP9-0000nh-A1
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 08:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbYH2GXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 02:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYH2GXJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 02:23:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28805 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbYH2GXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 02:23:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYxNx-0000uq-Ju; Fri, 29 Aug 2008 08:23:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 33C226EF; Fri, 29 Aug 2008 08:23:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48B6CD9F.6020302@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones schrieb:
> (I've just noticed that you are not #include-ing inttypes.h, so you are
> relying on the PRIu32 defined in git-compat-util.h)

We have to: MinGW include files are not C99.

-- Hannes
