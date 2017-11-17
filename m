Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204AC202D7
	for <e@80x24.org>; Fri, 17 Nov 2017 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933671AbdKQNun (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 08:50:43 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39106 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbdKQNug (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 08:50:36 -0500
Received: by mail-wr0-f179.google.com with SMTP id o88so2173700wrb.6
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SnHqDIhqh42YE5x0k1EveZBZW5xzZ+kovssjmM0gIZc=;
        b=F5nkDxs4EExfsAJH1na+eZRx4Wx6PfU5jQ9LtECStqFVye1dHW0++VrNKEo08FpTSs
         QLFFefdu+x7OqAu5QAs1ovMaZVWXiJi+35Qvp0XcBVd1XpUfumQ/QLqt1/EC6a4V/jpY
         A0UTD7TbQI8d1UQulIwkTgeGy04kpw7l9XH7lr0dmiaElByfh1fypdIqFeiwrMSORp9F
         cmnZ9GUHZXoguHPhww26T+PHI0XYy3h/Z7kx7tzO+XLEMJeFWpDv2+zXZoA0niEw+dmv
         /GAQreBtu+SDbzac1Qf3o2DIOD0hISLBUd5p7GvXYCfYMb8Ykbp8X18Q/Eo1jZtTggrD
         5Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SnHqDIhqh42YE5x0k1EveZBZW5xzZ+kovssjmM0gIZc=;
        b=HRZpgKuCRa5liPzSdDD7YZOc1ZxMpUT9CB/npj7j2uwRe7Gt0QyNogR1EbbSL6IFZY
         A49JW+wEIC5/n6Z36T5PM76DAige+OlTT2vryFSnudLBylwIm63IPUe6pjiasHXZV7p6
         pK7SpjRcEUYRoZfxYfHeE9003Sf6AvDXcoq7IAlFQ61KbXJv6UoLQgHKSyZThnjnLN4C
         ci43ZCee5OXaxcZV+Br1npIexykbKd/b0iy24mF78xZaBouSMkYHrICLoluvcLpVf2mK
         /5e4NkOcrGznRcmjKbi+kdEp0SuLpSxH59GSHH7m4T/L36exeXVZGqI1LNqB4/PEGCq8
         eeJA==
X-Gm-Message-State: AJaThX43pf1xVTHBetxoUY+EqmH0OyjKDgJ7Zy8mbmO0WHYZKgS9Z0Pk
        ci/15roJ9BQHk0V0iRcLyH4=
X-Google-Smtp-Source: AGs4zMZcYtja3ecZdg49tok1l/hGbIXmyQgFXjpO9buC4P0ghFHtZD2VfIIQvDPVMQskFlgbKDCpVA==
X-Received: by 10.223.132.194 with SMTP id 60mr4671460wrg.249.1510926635086;
        Fri, 17 Nov 2017 05:50:35 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 195sm9197485wmj.3.2017.11.17.05.50.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Nov 2017 05:50:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git send-email does not work with Google anymore?!
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1508776071.2750.15.camel@kaarsemaker.net>
Date:   Fri, 17 Nov 2017 14:50:32 +0100
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FF8A4F0-C449-48C7-8C90-290BF86906C9@gmail.com>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com> <1508776071.2750.15.camel@kaarsemaker.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Oct 2017, at 18:27, Dennis Kaarsemaker <dennis@kaarsemaker.net> =
wrote:
>=20
> On Thu, 2017-10-05 at 12:52 +0200, Lars Schneider wrote:
>> Hi,
>>=20
>> I used to use the Google SMTP server to send my patches to the list =
with=20
>> the following config:
>=20
>> 8 ---
>=20
>> Apparently that stopped working today. I get this error:
>>=20
>>    (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from =
line 'From: Lars Schneider <larsxschneider@gmail.com>'
>>    Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
>>    5.7.14 <https://accounts.google.com/signin/continue?...token...
>>    5.7.14 ...> Please log in via your web browser and
>>    5.7.14 then try again.
>>    5.7.14  Learn more at
>>    5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
>>=20
>> Of couse I tried to log in via web browser etc. Does anyone else use=20=

>> Google as SMTP server? If yes, does it work for you?
>=20
> For 2fa-protected accounts, this seems to break quite often. I ended =
up
> setting up a mail relay on my vps for this. If you want, you can use
> git.seveas.net to send patches to the git mailing lists (doesn't work
> for other recipients, I'm not quite stupid enough to run an open mail
> relay...)

:-) ... unfortunately that also means one can not CC people using your
server. Looks like I need to setup my own solution after all :-(

Cheers,
Lars=
