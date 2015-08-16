From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Sun, 16 Aug 2015 14:04:49 +0200
Message-ID: <87lhdbl9r2.fsf@igel.home>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZS1gQuKYqYGjXx3M_XLFsc5uAxYcD6c-d-WJG7S_spYag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 14:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQwgN-00046j-MY
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 14:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbbHPMEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 08:04:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbHPMEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 08:04:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mvHHl04gmz3hj0Z;
	Sun, 16 Aug 2015 14:04:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3mvHHk64K7zvh2Y;
	Sun, 16 Aug 2015 14:04:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 41XH5gMpLYGq; Sun, 16 Aug 2015 14:04:49 +0200 (CEST)
X-Auth-Info: tk8oPn8a9/v8za6+i8tG44sMBZroREq0M5u1EIAEjPiZmrHIBHUhH+yqHCRseYa2
Received: from igel.home (ppp-93-104-187-70.dynamic.mnet-online.de [93.104.187.70])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 16 Aug 2015 14:04:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 49B272C3F61; Sun, 16 Aug 2015 14:04:49 +0200 (CEST)
X-Yow: I have accepted Provolone into my life!
In-Reply-To: <CAOLa=ZS1gQuKYqYGjXx3M_XLFsc5uAxYcD6c-d-WJG7S_spYag@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 16 Aug 2015 17:16:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276018>

Karthik Nayak <karthik.188@gmail.com> writes:

> I think we need to squash this in
>
> diff --git a/Documentation/git-for-each-ref.txt
> b/Documentation/git-for-each-ref.txt
> index 3099631..17bd15e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -129,7 +129,7 @@ color::
>
>  align::
>         left-, middle-, or right-align the content between %(align:..)
> -       and %(end). Followed by `:<position>,<width>`, where the
> +       and %(end). Followed by `:<width>>,<position>`, where the

s/>>/>/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
