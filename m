From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Mon, 28 Oct 2013 22:59:59 +0100
Message-ID: <87y55dys2o.fsf@igel.home>
References: <1382909208-7716-1-git-send-email-bdwalton@gmail.com>
	<877gcx1eho.fsf@igel.home>
	<CAP30j15+E4cz_kwJwaSH7-3agwC5J3jGNfaixSUg2=8xAzZoQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 23:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaur8-0008NB-2t
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 23:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806Ab3J1WAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 18:00:07 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46044 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab3J1WAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 18:00:05 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3d7qbh6RNjz4KK68;
	Mon, 28 Oct 2013 23:00:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3d7qbh6Hsgzbbld;
	Mon, 28 Oct 2013 23:00:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Cpdbo1eCKw6X; Mon, 28 Oct 2013 22:59:59 +0100 (CET)
X-Auth-Info: Exbv2gbG20DA9WyFIRZ4Fv0QCM7udrpVjsNSzC1+p2I=
Received: from igel.home (ppp-88-217-114-129.dynamic.mnet-online.de [88.217.114.129])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 28 Oct 2013 22:59:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id BA2D42C1E6D; Mon, 28 Oct 2013 22:59:59 +0100 (CET)
X-Yow: Uh-oh!!  I'm having TOO MUCH FUN!!
In-Reply-To: <CAP30j15+E4cz_kwJwaSH7-3agwC5J3jGNfaixSUg2=8xAzZoQg@mail.gmail.com>
	(Ben Walton's message of "Mon, 28 Oct 2013 21:10:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236870>

Ben Walton <bdwalton@gmail.com> writes:

> It's an escape. Without it, sed throws:

The shell removes it before sed can see it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
