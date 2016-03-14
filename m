From: Alexander Rinass <alex@fournova.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Mon, 14 Mar 2016 22:45:43 +0100
Message-ID: <A81BB0E5-4879-4A86-9019-BB76734BA9EF@fournova.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com> <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com> <56D9D8C6.2060104@ramsayjones.plus.com> <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com> <56DD41D5.60100@web.de> <5C6A30EF-ED0A-4D64-B971-CF873C64B46E@fournova.com> <56DEC5DD.2070407@web.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afaJH-0001g4-7o
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcCNVps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 17:45:48 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37585 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbcCNVpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 17:45:47 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so1502291wmp.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N2X7ZuS2tVABLN8aBH1VzKf4vTUMzp/EEL5VcEhBRmY=;
        b=LwJgnzB8rfGbzjBOlgF1hrJFhPhr5gxGeBEk66DgYQJV9cRQ3RELMpHDbewZ3YTwVf
         dP/2u5Y54hTOGFvzgXhLQSCgFXnjOqt0pBXZkQ17ZEuiEipfQPDGtR98ESEkwZWgW9Dj
         1BlUXkp3IWHGPmF1TGRvtVLK9QR3pp94C6mBnqIsM0xfAAufXYUIHusbKP2hjPYBb4FR
         mmbciMQjAkGPNVTg+XxvjALvv69rgGWm3AYHPF6D7n7sWbydrdywyMORP0PaG8+dYBb0
         Xx2VH7qU7pPmTrWLLOEqFGCxSPztCY/YSfjbqnt9tZtPWeMeIYyR34uJBm7blPhlEn3f
         yVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N2X7ZuS2tVABLN8aBH1VzKf4vTUMzp/EEL5VcEhBRmY=;
        b=AOR+UXVT0VPlXedBsornJM0sH8nFH2xFtB0k/Ozyih4NYJHMw4vYH1ZpeAyUb7g0R9
         lmL4VO02DShzjN7NU9Oo/YO6PjMZoGMf8Z6FuLvKqP/x5mq4ICB9sF0rOPHoagdDxIJ9
         d27mRtRf4t1cK1CLIoFlrpfn7Yhhspdh2fIOX8Fa9MoB3g+ngiqNhIx1atCR6iKGIPVh
         POiMSG5gTJoQchNUns0RYkQG939gk6jVWluCozIHNjHuVXFCboAo3lU29euZC9oPohjW
         2l5ma28EgoatpmvCkUr1eEwNNMuWR86yUFiUPVgplqgrOMb+7gNbIfzLM0LNCqfacuZI
         4Cog==
X-Gm-Message-State: AD7BkJLs1dvnWSef4eqCdFEgVdMoCmDjWdvZBfqNLIvh8GEoURsGdHCYngsHgBPpDc81PA==
X-Received: by 10.28.153.135 with SMTP id b129mr20914348wme.3.1457991945359;
        Mon, 14 Mar 2016 14:45:45 -0700 (PDT)
Received: from alexanders-macbook-pro.fritz.box (aftr-95-222-24-110.unity-media.net. [95.222.24.110])
        by smtp.gmail.com with ESMTPSA id h7sm17846559wmf.9.2016.03.14.14.45.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Mar 2016 14:45:44 -0700 (PDT)
In-Reply-To: <56DEC5DD.2070407@web.de>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288819>


> On 08 Mar 2016, at 13:30, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>=20
>>> And if not, I can put it on my TODO-stack.
>> I have read through the official contribution guidelines and I think=
 I can
>> send an official patch.
>>=20
>> In this case, would you prefer to have a single commit since the cha=
nge
>> is related? Or would you prefer keeping it in separate commits, sinc=
e
>> they are different commands and I can use commit subjects like =E2=80=
=9Cdiff:=E2=80=9D
>> and =E2=80=9Cdiff-index:=E2=80=9D, etc.?
>>=20
> Thanks for the work.
> The same issue fixed at different places:
> I personally would prefer a single commit.
>=20
> Another thing is, if we want to add TC in t3910,
> to avoid future regressions.
> (Otherwise I can help with those)

I created a test case but git diff exits with 0 if it does not recogniz=
e the file=20
path so the test case always succeeds. Can you give me a hint or one=20
example test case?
