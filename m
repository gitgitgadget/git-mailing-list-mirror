From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/8] git-send-email.perl: Handle shell metacharacters
 in $EDITOR properly
Date: Wed, 09 Apr 2008 08:31:18 +0200
Message-ID: <47FC62B6.9020304@viscovery.net>
References: <> <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjTqp-0005cw-Ci
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbYDIGbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbYDIGbV
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:31:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6920 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbYDIGbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:31:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjTq2-0004s5-IH; Wed, 09 Apr 2008 08:31:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6B63F546; Wed,  9 Apr 2008 08:31:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79073>

Bryan Donlan schrieb:
> Also, update t/t9001-send-email.sh to test for this bug.
> 
> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>

Your defintion of "properly"? I didn't immediately see what is wrong with
the status quo and, hence, why your fix would solve a problem.

-- Hannes
