Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7C420989
	for <e@80x24.org>; Mon, 10 Oct 2016 23:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbcJJXfE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 19:35:04 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35878 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbcJJXfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 19:35:04 -0400
Received: by mail-oi0-f45.google.com with SMTP id m72so5494300oik.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iEA6PvwwvH0ZE5eIvXNfpdE9eAAN6Erml+8hhRKILqo=;
        b=Ld5fmMaqJJoU5hRM0n2NZTyZJsqhbO/jWRyrAtx1+crJpqjxwADM/6wMtNAdoNBOu4
         Q1XB9EW471njAYhh42CRqR9aVnUj+F/Jj3ppSEfAPfv8FTNFL5aH6/1yyEWtkzknUktZ
         PhDQtUVGu0JYdVASgbFAJ1+aYwUOpw1FuEKSEKjU1zSQ9bToVDNtYdjs5mAmgfdVFoMz
         W2B+FPudwULEIPdXJIEuw9KRfrRJhyidjGHlBxmmUwiK7BzgF5Zf+cjJdK0QB3jwEYzB
         jHY2B2gpHBFZ4tV0L5T+rW/nD7LW8JwwkLvHUTVJZhIXtp9favaor4F1mMlVd+sT1CEi
         8+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iEA6PvwwvH0ZE5eIvXNfpdE9eAAN6Erml+8hhRKILqo=;
        b=d02f+IiXeAL2Mg3fxszAVAkWA4u95SNwdGia+SyjMpdQfKNZexZgDl4O8kD/lnny7b
         orsU4hDtnHR24oRHTO259IOkv77Gd+Qt19xX5WJoHeeA/Mdo9mvwYUYZVfszDxt3ey1C
         FZ8l1bU02R04+0OL7S6K3theMFCCy7Y++mxMJvGhbiNMfseabjUeNZuoUwNUS8WtJjcB
         VfWmHDXk9cwTp9EqgastsOCB7aFIwLrWEmyaGPPpSBG25wPIsHhwi1b5UlOxw74GC6wp
         Z48JGeIIzghXMvCmOnx1CAFO0jTtjHpfGMaRyaZcyxVlo4aF0qZzyrRH4KobZvHOzjqx
         oYtA==
X-Gm-Message-State: AA6/9RlDxXAERK+pB4Ffk6v1O4yk09EAHiZvfgeLL0+Qgkc8ZEP2I5j9kIROtdH0/Ru7sQ==
X-Received: by 10.157.44.214 with SMTP id e22mr438845otd.89.1476142503303;
        Mon, 10 Oct 2016 16:35:03 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id s23sm209129ots.1.2016.10.10.16.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2016 16:35:02 -0700 (PDT)
Subject: Re: Formatting problem send_mail in version 2.10.0
To:     Jeff King <peff@peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
Cc:     Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <577f6873-c320-7aa6-b42f-475f2afb9b92@lwfinger.net>
Date:   Mon, 10 Oct 2016 18:35:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2016 04:57 PM, Jeff King wrote:
> [+cc authors of b1c8a11, which regressed this case; I'll quote liberally
>      to give context]
>
> On Mon, Oct 10, 2016 at 05:48:56PM -0400, Jeff King wrote:
>
>> I can't reproduce the problem with this simple setup:
>>
>> 	git init
>> 	echo content >file && git add file
>> 	git commit -F- <<-\EOF
>> 	the subject
>>
>> 	the body
>>
>> 	Cc: Stable <stable@vger.kernel.org> [4.8+]
>> 	EOF
>>
>> If I then run:
>>
>> 	git send-email -1 --to=peff@peff.net --dry-run
>>
>> I get:
>>
>> 	/tmp/MH8SfHOjCv/0001-the-subject.patch
>> 	(mbox) Adding cc: Jeff King <peff@peff.net> from line 'From: Jeff King <peff@peff.net>'
>> 	(body) Adding cc: Stable <stable@vger.kernel.org> [4.8+] from line 'Cc: Stable <stable@vger.kernel.org> [4.8+]'
>> 	Dry-OK. Log says:
>> 	Sendmail: /usr/sbin/sendmail -i peff@peff.net stable@vger.kernel.org
>> 	From: Jeff King <peff@peff.net>
>> 	To: peff@peff.net
>> 	Cc: "Stable [4.8+]" <stable@vger.kernel.org>
>> 	Subject: [PATCH] the subject
>> 	Date: Mon, 10 Oct 2016 17:44:25 -0400
>> 	Message-Id: <20161010214425.9761-1-peff@peff.net>
>> 	X-Mailer: git-send-email 2.10.1.527.g93d4615
>> 	
>> 	Result: OK
>>
>> So it looks like it parsed the address, and shifted the "4.8+" bit into
>> the name, which seems reasonable. Does my example behave differently on
>> your system? If not, can you see what's different between your
>> real-world case and the example?
>>
>> It might also be related to which perl modules are available. We'll use
>> Mail::Address if you have it, but some fallback routines if you don't.
>> They may behave differently.
>>
>> Alternatively, if this used to work, you might try bisecting it.
>
> Ah, it is Mail::Address. It gets this case right, but if I uninstall it,
> then the cc becomes:
>
>   Cc: Stable <stable@vger.kernel.org[4.8+]>
>
> that you saw, which is broken. Older versions of git, even without
> Mail::Address, got this right. The breakage bisects to b1c8a11
> (send-email: allow multiple emails using --cc, --to and --bcc,
> 2015-06-30) from v2.6.0, but I didn't dig deeper into the cause.

I did not have Mail::Address installed, but adding it did not help.

I solved my immediate problem by moving the [4.8+] between Stable and the 
starting <. The result is spaced funny, but at least the info is there.

Larry


