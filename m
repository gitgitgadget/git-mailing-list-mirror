From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v15 04/16] Refactor quote_path_relative, remove unused params
Date: Thu, 27 Jun 2013 09:47:00 +0800
Message-ID: <CANYiYbGr4A-PQJtiLwBWd2xqkWBYUPvuVCnSOV4_=sL2qYssnQ@mail.gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<bdd209a2f3848ffa784872f4c244b37d38be82c1.1372175283.git.worldhello.net@gmail.com>
	<7v61x0wypk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 03:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us1Ii-0001AJ-7C
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 03:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3F0BrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 21:47:03 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64866 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3F0BrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 21:47:02 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so111657wib.12
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 18:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9+qMQb3UGqBYXCptdHoqJb5KiPaVIn2SGIYhNaw5B8I=;
        b=WnpZntEzBxeuHEoBTLUxN7XZhHwyC5L0f6Ycsy2TP9Oan5baPiqQu7wP1pDigL0GfZ
         672G72OMqwfenHlCxseu5VJFyFVeenGWAdtzPna20b1xryh+uquEHhpJ7ukjFfeQ7WFH
         SMxuiYCjY01qXNYVTugUNpywWqPyKiUVI52qbYKNwIjFZnNQNd9Qo18bK8lTH8pWohnF
         zJUDNZcMPG12yJiQRrzC6exMiI4Sw50p+JvoS/ibevyL72XSQuOf0TlaeMdTsX0esuVM
         EmutZZ1zelQdAdYSzHjp56NOG4QqpkCe9zM2brhOCVqPmlhukjr2A0qHYiLNvR34kdXG
         o2Gg==
X-Received: by 10.194.133.106 with SMTP id pb10mr4570154wjb.62.1372297620801;
 Wed, 26 Jun 2013 18:47:00 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Wed, 26 Jun 2013 18:47:00 -0700 (PDT)
In-Reply-To: <7v61x0wypk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229081>

2013/6/27 Junio C Hamano <gitster@pobox.com>:
>> diff --git a/quote.c b/quote.c
>> index 64ff3..ebb8 100644
>
> You seem to be using unusually short abbrev length.
>
> Please don't, at least in format-patch output.
>
> "ebb8" may be unique within your repository, but may not be unique
> in repositories of other people who attempt to apply your patches.
>
> Offtopic.  Fixing this, without forcing you to use the default
> abbrev length everywhere, _might_ require a bit of changes to the
> configuration mechanism, or "git format-patch", or both.  I've also
> seen in some other thread that --numstat was used in addition to the
> usual --stat, which should not be added to format-patch output only
> because the user configured it for other "diff/log" uses, which may
> also need to be fixed in the same way.

Thank you for your notice. I find that I have a setting: core.abbrev=4,
which overrides the default. Maybe I set it two years ago, when I wrote
my book on Git in Chinese.

-- 
Jiang Xin
