Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EA31F404
	for <e@80x24.org>; Mon,  9 Apr 2018 02:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756464AbeDICbr (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 22:31:47 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45888 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754944AbeDICbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 22:31:45 -0400
Received: by mail-qk0-f172.google.com with SMTP id s9so7719241qke.12
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/GKcEgfh9lNI1EfDIEOqcc1PGBhX8c9hhSMJN9l5VFU=;
        b=ScgWs42c3DR+P45iBSy5yPzHKLje1FNiU4jec1Aw4B6mAU5Z8SDgd66fJ7TnZzrW+N
         PBpKE9PZ3sOpFPPc7KmxXO5/+rzAu1tZgRQseze73xuIypb1bsB0Swt+rzlRUmDDPyy2
         veqInMoHCpxBrYQmtQuR327A6rPAWD9ujEthl73ypk4lLWJd5o1r4rqN3f6rfvHAOqcX
         HksxpsIfu72a4vbIYf37czNHsTNR7B0qfJlh+1DEdwJcR23RRnVoMqirX64uoB4tEU78
         fli/l48RlxkUNO5NdYj/mGwwHn5OaHJMQeb/30ofnYJbZB+/hRQnO/0+Qzl2I59SRLlb
         lTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/GKcEgfh9lNI1EfDIEOqcc1PGBhX8c9hhSMJN9l5VFU=;
        b=D7KCo3XEDxUz4/qJbvAUqXZfy4bsb15FqTtB9AbNVHjMnlLwJPeDqaa/4M5EJROrYj
         JENa95AZQT0xGeoV/qseskw9xR/umvQ70KuKhuFdsN8fu4FmATMj0Dcm4Ezd9niZYrFi
         Hgw5uxZuvbKdADMrbTfL8hqOi2/AYoDLY0eSPl53hX2V6cW4QjwKZUdOWaeb6T/RVfEe
         2aI56kQqi/4h0O68LIsONYWz1X71JMEB3fySVVsfOFn9yifZRNKI3f+c10Y5pGtPPvFE
         rnRpWXC1QM7r5uk/bR5kGEnVmrzuDH6667r30mIILJ/1T8w3lQmnj7bfA1rU9Wue3Xdl
         i4ZQ==
X-Gm-Message-State: ALQs6tCwC71sG3Wvw/vQc0Dx4usF1VYFYqAVYudm6AYe/+hx9RXfuaLA
        ixyBXCK1RhSpSCjx9mguYGJAmZW09XePOlJmwYA=
X-Google-Smtp-Source: AIpwx4+Sfl7ObXyQYzdZtSigIxyk71HFELXi7IYlxuIWHLxIIildgUBWRvpH4cuqZyAAznn9FgThwCuS5owGUuGLrIQ=
X-Received: by 10.55.159.140 with SMTP id i134mr46260815qke.220.1523241104703;
 Sun, 08 Apr 2018 19:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 19:31:44 -0700 (PDT)
In-Reply-To: <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
 <20180402005248.52418-1-haraldnordgren@gmail.com> <20180408122832.65414-4-haraldnordgren@gmail.com>
 <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 22:31:44 -0400
X-Google-Sender-Auth: qRiKPrsrlzlGwgu27mBe0CxOxk8
Message-ID: <CAPig+cR4kA+SHmOOOq20BJGzqQkqKvYrFEqPdDF6g6c=apjHtA@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] ls-remote: create '--sort' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>> +--sort=<key>::
>> +     Sort based on the key given. [...]
>
> This is a tangent but I suspect that the description of --sort in
> git-for-each-ref documentation is wrong on the use of multiple
> options, or I am misreading parse_opt_ref_sorting(), which I think
> appends later keys to the end of the list, and compare_refs() which
> I think yields results when an earlier key in the last decides two
> are not equal and ignores the later keys.  The commit that added the
> description was c0f6dc9b ("git-for-each-ref.txt: minor
> improvements", 2008-06-05), and I think even back then the code in
> builtin-for-each-ref.c appended later keys at the end, and it seems
> nobody complained, so it is possible I am not reading the code right
> before fully adjusting to timezone change ;-)

I just re-read parse_opt_ref_sorting(), and I'm pretty sure that it is
_prepending_ keys to the list, despite the confusingly named variable
"sorting_tail", thus it agrees with the documentation that
--sort=<key> specified last becomes primary sort key.

For me, at least, that behavior (last --sort= becomes primary key)
feels counterintuitive, but it's too late to change it now.
