Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB36C207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 14:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbcJLOni (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 10:43:38 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33077 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933756AbcJLOna (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 10:43:30 -0400
Received: by mail-lf0-f45.google.com with SMTP id x79so81393383lff.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Y26PBciA6C0LzvEt8OiZNEDox0MRW7w8qNJGxWWsejM=;
        b=BHANllH8BTU5/9e2vsrNIM34Oa1RwWo+J3OmUul55RxH/qAgQqf8yxGmgJn7UibIO6
         9sr58C2wnX0DW1MIEb9jjwac824CRDjPES8SttNDNDcAoeEfPc5O9/vNh8iRCzgIOhql
         XqGCWR7C8eJwr/8K+X5Je+h1TEJCpgG4GlqMkI7BUNDZQ+OglkdF0OKdk251gx3JW7FZ
         xJBn95fZI6F32vU7+CxODwQKFfDVeurdLUCeMfZIU7RyUcjn1HAUZL5rfPIggRPuuAdI
         Nh2nIfh06EC+b7Uogp6upYj0eNMuOHHe+1TGV4dMvIIa7G5sbPMZxhxuvZ+nrOZ3HznR
         FAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Y26PBciA6C0LzvEt8OiZNEDox0MRW7w8qNJGxWWsejM=;
        b=JudMKU9Hv/AXVcL3Up0QrHhlA4CQZE7v13waNhi/2LlRxeme05OpSBZSUiPazWTt+U
         /X1oQnK0k0E+KfJ9TrYr/qnrqpjLwxycAlMEdIXyOHsYEqiQ/BqAVd1PkaNb5t38c95s
         kLoYJA2F2+Q8QlXnXOSq5vGKhcRavD/2U9JUHQwrDvemrURpce+Zsp8LmQKXxnJcOUGh
         l0+oPrpHp1JZ/UV19flm89mopLowM74wzOVxr7gHk2fL+1HdBCgIIvswIbC0sk9SkWoq
         qV/Bi7RK4gt/9xsEugkEJSn90i0IH9aY0qFRDzhTEdn3bW1zhYIq4dIAYowV6DmJn+Vo
         p84g==
X-Gm-Message-State: AA6/9RmrPf2MZUXmM/CsKtBjtPjIrX46pOi9lWyE0F/XK6AXJb8nrtCVLW+R2Nd+VtQuoZeHkCKPvtLQ9Obbjw==
X-Received: by 10.25.29.82 with SMTP id d79mr1798832lfd.52.1476283408186; Wed,
 12 Oct 2016 07:43:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.173.131 with HTTP; Wed, 12 Oct 2016 07:43:07 -0700 (PDT)
In-Reply-To: <1240187899.41938.1476280216470.JavaMail.open-xchange@app08.ox.hosteurope.de>
References: <1240187899.41938.1476280216470.JavaMail.open-xchange@app08.ox.hosteurope.de>
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Date:   Wed, 12 Oct 2016 16:43:07 +0200
X-Google-Sender-Auth: h6fznnmBuuaazWPDqrDLsbknzAU
Message-ID: <CACNzp2nG1KfFuiSH1UUGVSz1T39PjzfDgCp6vqOVe7-Lph2yNw@mail.gmail.com>
Subject: Re: git branches & merge
To:     webmaster@peter-speer.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


the IP will not be overwritten, you'll still have the new IP in
master. Nothing to worry about :)


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
