From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] reset: allow "-" short hand for previous commit
Date: Wed, 4 Mar 2015 02:10:55 -0500
Message-ID: <CAPig+cRXZ+QRqxGPCkHTbW7ZbuPVpJndZU-7mS7GdtnqScfwfg@mail.gmail.com>
References: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
	<vpq4mq13f69.fsf@anie.imag.fr>
	<xmqq1tl5acwu.fsf@gitster.dls.corp.google.com>
	<CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3SR-0007Sy-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604AbbCDHK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:10:58 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:32936 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152AbbCDHK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:10:56 -0500
Received: by yhl29 with SMTP id 29so21125017yhl.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HKfXhQSN8FuVcSK/79b2adOvYvIf9JJTMYmptoVTim4=;
        b=q5kr69wnwA7i5wl6GwRTOskCaJAT9q/cF8lemkXzUOlzLEjoRSiX/Mjx2xlzYl/ubY
         dsG12sAkgRrtnH7yBSSW04ptEnGc+Qjoveaiy6caA7zMQo7sbrFELlAe/n3DOOqH64xw
         yxESBJXrDIdqJBNdfDE+HT3+/q9+92IzPsKadkoe88ixAa1cXU5IZ51CDKBtn9qwcuPy
         xWT7Y4tKmXphu4YZCbTq++RS4rfOtjcjigCPiVVyJYPvymJEHzp8Qoe2h5hlV2UMybSm
         NaHSZzvmuGOAL61NxMDQdx3SAPTiuIQslbUnoUOfy/IsEjzILe70PSP9dtlysuAwPN/K
         8MFw==
X-Received: by 10.236.63.6 with SMTP id z6mr1780017yhc.65.1425453056054; Tue,
 03 Mar 2015 23:10:56 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 3 Mar 2015 23:10:55 -0800 (PST)
In-Reply-To: <CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
X-Google-Sender-Auth: lScVdRabn0olwqiXSo-Zt7iE7cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264725>

On Wed, Mar 4, 2015 at 2:07 AM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>>>> From: SudShekhar <sudshekhar02@gmail.com>
>>>
>>> +             if(!strcmp(argv[0],"-"))
>>> +                     argv[0]="@{-1}";
>>>
>>> Wrong spacing (around = and after ,).
>
> Thanks for pointing this out. I have corrected it.

Also, add a space after 'if'.
