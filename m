From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/8] config.c: Escape backslashes in section names	properly
Date: Wed, 09 Apr 2008 16:25:25 +0200
Message-ID: <47FCD1D5.4020007@viscovery.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <47FC62B0.3060802@viscovery.net> <20080409141334.GA24402@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbFi-0003Qz-33
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbYDIOZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYDIOZe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:25:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8031 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYDIOZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:25:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjbEs-0001Ex-7m; Wed, 09 Apr 2008 16:25:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E31CB546; Wed,  9 Apr 2008 16:25:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080409141334.GA24402@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79106>

Bryan Donlan schrieb:
> On Wed, Apr 09, 2008 at 08:31:12AM +0200, Johannes Sixt wrote:
>> Bryan Donlan schrieb:
>>> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
>> What is your definition of "properly"? Please give an example of what went
>> wrong.
> 
> The included patch to the test suite is an example - specifically if an
> element of the configuration key name other than the first or last
> contains a backslash, it would not be escaped on output, but would be
> treated as an escape sequence on input. Thus the backslash would be
> lost.

Could you then please add this to the commit message, most importantly,
the last sentence?

-- Hannes
