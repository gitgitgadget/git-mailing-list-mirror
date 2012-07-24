From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3 2/7] i18n: rebase: mark strings for translation
Date: Wed, 25 Jul 2012 06:49:58 +0800
Message-ID: <CANYiYbGkfpdT+FRpgaOPcHRBh6WhWe0cGUCNXh=UgOFPog=hfg@mail.gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
	<b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
	<20120724180138.GF2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stnvc-0005DU-7L
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab2GXWuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 18:50:00 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52400 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab2GXWt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2012 18:49:59 -0400
Received: by ghrr11 with SMTP id r11so114892ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KDaIbe8h5DTOjIHEOjIOIb3NSYiJ8CPX13QnpfLEzc0=;
        b=Y9bCQzYcfrW/pwD2+JoUZJXRnPbYnFyImk2T5YrbNhSrzw0AeLUzU7cFTfMrc+BytB
         7dQWmwvJqzJJCvtlFkDJo/c3iPjetIu6xbcNYuNi1qUv7a+ardbF3kADINTvAJm6K9PE
         TI3hkClPSgv+ORoBt0Jkm6ZHv6dL/fPzQfIrKsjHdSebjPSSvKxtmtpe+Hi5FqG15ddI
         ZbBLCOYOjMMMSe7RdJE7y/eDkzHTldP6xorX/gGROyd3xL2WCP9cW1HX5Telh+fIkMFe
         1vjShRZjeSfrUGGQdxrV4dXODpOFuoxBFVs/EhiWi9f+DPNfM9BC+6LEuqeBj4L7cFM0
         9wZA==
Received: by 10.42.39.17 with SMTP id f17mr18996140ice.3.1343170198733; Tue,
 24 Jul 2012 15:49:58 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Tue, 24 Jul 2012 15:49:58 -0700 (PDT)
In-Reply-To: <20120724180138.GF2939@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202080>

2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:
>> @@ -64,7 +64,7 @@ test_expect_success 'rebase -n overrides config re=
base.stat config' '
>>
>>  test_expect_success 'rebase --onto outputs the invalid ref' '
>>       test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &=
&
>> -     grep "invalid-ref" err
>> +     test_i18ngrep "invalid-ref" err
>>  '
>
> This is probably part of a message intended for humans, but the test
> does not say.  What is the full message being checked?
>

The error messages are:

    fatal: Needed a single revision
    Does not point to a valid commit: invalid-ref

The first line has not been marked for translation (comes from
builtin/rev-parse.c), but the second line is marked for translation
in this patch. The output in my locale would be:

    fatal: Needed a single revision
    =C3=BB=D3=D0=D6=B8=CF=F2=D2=BB=B8=F6=D3=D0=D0=A7=B5=C4=CC=E1=BD=BB=A3=
=BAinvalid-ref

--=20
Jiang Xin
