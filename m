From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 21:16:03 +0200
Message-ID: <87wqcw1o5o.fsf@igel.home>
References: <538ED6DF.5020505@web.de>
	<xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
	<20140604184604.GC14457@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGfW-0004PP-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaFDTQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 15:16:09 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47654 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaFDTQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:16:08 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gkKbT1YB7z3hhcr;
	Wed,  4 Jun 2014 21:16:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gkKbT15hMzbbhY;
	Wed,  4 Jun 2014 21:16:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 4omU4kG8a26w; Wed,  4 Jun 2014 21:16:04 +0200 (CEST)
X-Auth-Info: 1tfhsX6Z9XfjD+3VZEDgSbcT5J+VEGopzDvclLm7XM8=
Received: from igel.home (host-188-174-215-65.customer.m-online.net [188.174.215.65])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed,  4 Jun 2014 21:16:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B5F302C3686; Wed,  4 Jun 2014 21:16:03 +0200 (CEST)
X-Yow: -- I can do ANYTHING ... I can even ... SHOPLIFT!!
In-Reply-To: <20140604184604.GC14457@serenity.lan> (John Keeping's message of
	"Wed, 4 Jun 2014 19:46:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250774>

John Keeping <john@keeping.me.uk> writes:

> So the portable way to do it is:
>
> 	sed "s/^From:/$header: extra@address.com\
> From:/" cover-to-edit.patch >"$cover" &&

That wouldn't work as \<newline> is removed in double quotes.  You
either need to double the backslash or put it in single quotes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
