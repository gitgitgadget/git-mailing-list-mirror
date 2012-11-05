From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Like commit -a, but...
Date: Mon, 05 Nov 2012 23:36:23 +0100
Message-ID: <m2fw4nd6e0.fsf@igel.home>
References: <20121105202948.GA17505@inner.h.apk.li>
	<20121105205628.GG21244@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:36:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVVHc-0006Lp-PE
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364Ab2KEWg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 17:36:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:40150 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348Ab2KEWg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 17:36:27 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XwTJS1kQGz3hhbX;
	Mon,  5 Nov 2012 23:36:24 +0100 (CET)
X-Auth-Info: tJv1OTb9f750CfQQ2JjpzkPNkZvO1tAAMbhDt+cSmC8=
Received: from igel.home (ppp-88-217-121-179.dynamic.mnet-online.de [88.217.121.179])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XwTJS1P9jzbbfL;
	Mon,  5 Nov 2012 23:36:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id DE7DFCA2A4; Mon,  5 Nov 2012 23:36:23 +0100 (CET)
X-Yow: You should all JUMP UP AND DOWN for TWO HOURS while I decide
 on a NEW CAREER!!
In-Reply-To: <20121105205628.GG21244@inner.h.apk.li> (Andreas Krey's message
	of "Mon, 5 Nov 2012 21:56:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209088>

Andreas Krey <a.krey@gmx.de> writes:

> But is there a direct way to convert the current working tree into a
> tree object?

You can create a temporary index by setting the GIT_INDEX_FILE env var.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
