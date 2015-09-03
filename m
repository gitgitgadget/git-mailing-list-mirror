From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: glibc mutex deadlock in signal handler
Date: Thu, 03 Sep 2015 22:55:52 +0200
Message-ID: <87y4gn5ijr.fsf@igel.home>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
	<xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
	<s5h7fo7wb3e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:56:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXbYE-0006Pb-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbbICU4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 16:56:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44554 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335AbbICUz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:55:58 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3n6ZDB4s03z3hhp3;
	Thu,  3 Sep 2015 22:55:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3n6ZDB1qS5zvhL7;
	Thu,  3 Sep 2015 22:55:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id M6MrGrSEj8ep; Thu,  3 Sep 2015 22:55:52 +0200 (CEST)
X-Auth-Info: 453sJxAbU1oFna9nuDFvEkZ+hyAfTjNZDaQUNQQk8O4T03tA0ZHMQw9m0d2SUEPj
Received: from igel.home (ppp-93-104-184-128.dynamic.mnet-online.de [93.104.184.128])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu,  3 Sep 2015 22:55:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 607032C3D8D; Thu,  3 Sep 2015 22:55:52 +0200 (CEST)
X-Yow: ..  My pants just went on a wild rampage through
 a Long Island Bowling Alley!!
In-Reply-To: <s5h7fo7wb3e.wl-tiwai@suse.de> (Takashi Iwai's message of "Thu,
	03 Sep 2015 21:34:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277258>

See
<http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04_03>
for the complete list of functions you may safely call from a signal
handler.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
