From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 21:34:15 +0200
Message-ID: <87tx4vnl8o.fsf@igel.home>
References: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch>
	<xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
	<xmqqppfj5d8f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:34:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRwG-0005Ws-C6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 21:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbaH2TeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 15:34:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39306 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbaH2TeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 15:34:19 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hl9wm1tzkz3hhs9;
	Fri, 29 Aug 2014 21:34:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hl9wm1JhCz7S6Qt;
	Fri, 29 Aug 2014 21:34:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id AwfqJEPi38X4; Fri, 29 Aug 2014 21:34:15 +0200 (CEST)
X-Auth-Info: MBO6jSkttEjNHTW2JybQPFosEe+vIGH8i2cRVGnLbSY=
Received: from igel.home (ppp-188-174-159-129.dynamic.mnet-online.de [188.174.159.129])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 29 Aug 2014 21:34:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 2E1072C349A; Fri, 29 Aug 2014 21:34:15 +0200 (CEST)
X-Yow: -- I can do ANYTHING ... I can even ... SHOPLIFT!!
In-Reply-To: <xmqqppfj5d8f.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Aug 2014 12:04:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256184>

Junio C Hamano <gitster@pobox.com> writes:

> I've queued with this fix squashed in.
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 17d30d0..f9e6481 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2580,6 +2580,9 @@ parse_done:
>  	case DATE_RFC2822:
>  		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
>  		break;
> +	case DATE_ISO8601_STRICT:
> +		blame_date_width = sizeof("2006-10-19T16:00:04-0700");

ITYM ...-07:00

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
