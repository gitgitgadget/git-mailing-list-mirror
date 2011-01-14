From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-p4: Fixed handling of file names with spaces
Date: Fri, 14 Jan 2011 23:01:57 +0100
Message-ID: <m28vyncffu.fsf@igel.home>
References: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com>
	<1294944715-5647-1-git-send-email-jerzy.kozera@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, msclrhd@googlemail.com
To: Jerzy Kozera <jerzy.kozera@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 23:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdrit-0008Mk-FC
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 23:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab1ANWCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 17:02:04 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47117 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab1ANWCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 17:02:02 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 6EC10188B596;
	Fri, 14 Jan 2011 23:01:58 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id C216E1C00124;
	Fri, 14 Jan 2011 23:01:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id WcOEq2X9kYBL; Fri, 14 Jan 2011 23:01:57 +0100 (CET)
Received: from igel.home (ppp-88-217-115-226.dynamic.mnet-online.de [88.217.115.226])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 14 Jan 2011 23:01:57 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id A1C65CA2A0; Fri, 14 Jan 2011 23:01:57 +0100 (CET)
X-Yow: How do you explain Wayne Newton's POWER over millions?
 It's th' MOUSTACHE...  Have you ever noticed th' way it radiates
 SINCERITY, HONESTY & WARMTH?  It's a MOUSTACHE you want to take
 HOME and introduce to NANCY SINATRA!
In-Reply-To: <1294944715-5647-1-git-send-email-jerzy.kozera@gmail.com> (Jerzy
	Kozera's message of "Thu, 13 Jan 2011 18:51:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165126>

Jerzy Kozera <jerzy.kozera@gmail.com> writes:

> I've noticed the same issue in reopen and rm calls - not saying these three are all occurences of this problem, but I guess fixing them is a good start.

Can those file names also include a double quote or a backquote or a
dollar sign?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
