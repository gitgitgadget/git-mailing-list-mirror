From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 10/10] Rename the test trash directory to contain spaces.
Date: Mon, 05 May 2008 10:25:38 +0200
Message-ID: <481EC482.8060509@viscovery.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-2-git-send-email-bdonlan@fushizen.net> <1209879480-16910-3-git-send-email-bdonlan@fushizen.net> <1209879480-16910-4-git-send-email-bdonlan@fushizen.net> <1209879480-16910-5-git-send-email-bdonlan@fushizen.net> <1209879480-16910-6-git-send-email-bdonlan@fushizen.net> <1209879480-16910-7-git-send-email-bdonlan@fushizen.net> <1209879480-16910-8-git-send-email-bdonlan@fushizen.net> <1209879480-16910-9-git-send-email-bdonlan@fushizen.net> <1209879480-16910-10-git-send-email-bdonlan@fushizen.net> <1209879480-16910-11-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon May 05 10:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsw1n-0008UD-UU
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYEEIZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbYEEIZo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:25:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41465 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbYEEIZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:25:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsw0x-00026x-HF; Mon, 05 May 2008 10:25:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C52CE6D9; Mon,  5 May 2008 10:25:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1209879480-16910-11-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81244>

Bryan Donlan schrieb:
> In order to help prevent regressions in the future, rename the trash directory
> for all tests to contain spaces. This patch also corrects two failures that
> were caused or exposed by this change.

One more note: IMO, this patch should not contain fixes that the new
directory name uncovers - those should be in 09/10. Here we really should
only rename the trash directory (plus the assorted $test changes).

-- Hannes
