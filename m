From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 15:14:31 +0200
Message-ID: <m2d3049hvs.fsf@igel.home>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
	<CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
	<CAB9Jk9COSZOske5xzgnE=1oHe7qiwwOzHYE6pJkuZ0sZyZYhng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 15:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS6Dv-0003pB-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 15:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab2J0NOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 09:14:34 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44407 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2J0NOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 09:14:34 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XpjGJ26Qnz4KK2C;
	Sat, 27 Oct 2012 15:14:32 +0200 (CEST)
X-Auth-Info: SlTZgSZpJAiy+e1+nWHFaZ6w32ifCrKfXzShx4T5FFo=
Received: from igel.home (ppp-93-104-148-157.dynamic.mnet-online.de [93.104.148.157])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XpjGJ1mMWzbbcg;
	Sat, 27 Oct 2012 15:14:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BFA08CA2A1; Sat, 27 Oct 2012 15:14:31 +0200 (CEST)
X-Yow: I just had a MAJOR CONTRACT DISPUTE with SUZANNE SOMERS!!
In-Reply-To: <CAB9Jk9COSZOske5xzgnE=1oHe7qiwwOzHYE6pJkuZ0sZyZYhng@mail.gmail.com>
	(Angelo Borsotti's message of "Sat, 27 Oct 2012 12:36:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208507>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Besides that, it is common practice in *nix OSs to
> consider a return != 0 as an error.

Is grep not finding a match an error?  Is cmp finding a difference an
error?  It all depends on the context.

> How can otherwise the user tell a corrupted configuration file from a
> missing key?

You cannot, as long as your configuration file is well-formed, because a
missing key is an expected condition in many cases.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
