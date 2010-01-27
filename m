From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git status showing phantom modifications
Date: Wed, 27 Jan 2010 08:20:05 +0100
Message-ID: <4B5FE925.4000300@viscovery.net>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>	 <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>	 <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>	 <59B5C4C4-6E95-4BAA-9351-B88B6309E022@xing.com> <be6fef0d1001262114r137ba8ddi60a3a3468950c5ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Ludwig <michael.ludwig@xing.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na2CH-0005eb-TN
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 08:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0A0HUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 02:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554Ab0A0HUL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 02:20:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40768 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab0A0HUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 02:20:10 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Na2C6-0008Fm-Bc; Wed, 27 Jan 2010 08:20:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 155121660F;
	Wed, 27 Jan 2010 08:20:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <be6fef0d1001262114r137ba8ddi60a3a3468950c5ce@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138110>

Please do not top-post, particularly not when you place the meat of the
message after a "-- " marker; There's *no way* to force Thunderbird to
include the text below it in the reply.

Tay Ray Chuan schrieb:
> do you happen to have any clue on this?


Sorry, no. One more thing to try is:

  core.ignorecygwinfstricks = false

This turns off some stat() optimizations on Cygwin.

-- Hannes
