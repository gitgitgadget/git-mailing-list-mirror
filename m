From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 21:58:57 +0200
Message-ID: <m24oi5j81q.fsf@igel.home>
References: <1274202486.4228.22.camel@localhost>
	<1274203013-1349-1-git-send-email-yann@droneaud.fr>
	<alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <yann@droneaud.fr>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 18 21:59:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESwb-0006CV-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab0ERT7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:59:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33880 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab0ERT7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:59:03 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 6D8F71C00311;
	Tue, 18 May 2010 21:58:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 2984990219;
	Tue, 18 May 2010 21:58:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id bgi2m4T-M6G4; Tue, 18 May 2010 21:58:58 +0200 (CEST)
Received: from igel.home (ppp-88-217-120-67.dynamic.mnet-online.de [88.217.120.67])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 18 May 2010 21:58:57 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 90233CA297; Tue, 18 May 2010 21:58:57 +0200 (CEST)
X-Yow: YOW!!!  I am having fun!!!
In-Reply-To: <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 18 May 2010 10:45:26 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147304>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Wouldn't it be easier to just make it ignore case, and do
>
> 	grep -qi '^en_US\.utf-?8$'

You'll need ERE's for the ? operator.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
