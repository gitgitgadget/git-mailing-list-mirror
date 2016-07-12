Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D591FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbcGLPF7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:05:59 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36383 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbcGLPF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:05:58 -0400
Received: by mail-yw0-f170.google.com with SMTP id w127so16345553ywf.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 08:05:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=myl/LPEeCLhk2ffu1kaop2EXX2/sNH/eMpJWPJeV5S4=;
        b=m8hvvfIAp8Buso9sna0rsLiJiLx8IUDQLv9johKRP+H9OeSvAZsSf09N80vaXqo51+
         yTozO2De6ZT1ZtFmDdqmxwptrTvnv0KrarEmmBGDkgWVGFaOlvmW/TlszwyJ2lM3kraC
         nQOlog/i93vIrWUqCwtLKUb55zfmhs0g8+mAWLfXr/A0KkT7La/UslJ/xlJuTnDPu019
         CTeyrmQyYDpc+589o88pg628iDDxjYrAmaSAeJQmf65ArWkiWSFcUMXj8YB+grFTqdht
         r9nSVeSfeTes9UuWc8ERR4gWz6CHHfqDvQIQxaUMwLsfvtIN5EivNsGxEbjfNHl2kKvc
         iP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=myl/LPEeCLhk2ffu1kaop2EXX2/sNH/eMpJWPJeV5S4=;
        b=mAjCBGd2FX/hl7DAHr6UzKDJOMMK5onxJjUIYHRE8+Y1ww1Yf0idAJg1o4UTWknaAx
         v1DgXVeh8No0MdkKKdFlgWMf605werr2aH3tLxrT0CS4YHaCYuKSCJ9bYhjFnHTN6zXm
         GmS/E/0VgpXhNsbrUk2wYdXB2uo/syb8boYERKia/aB4ctXKCzs6JqpU0tEx0o9vIAgO
         7rWhV63pzHrAPGh9IMZXtWkB1F/IpL7p8Ct3rgUFEDpMQacd5zyRHphANgKZAfW3BVJO
         KNS4iLZKgaGlgJYkB6kWhuzdlcD1VBvVo5gQWOFrjGG3J6ff7X/Robh7z17hkJ4YfEFw
         Sx5Q==
X-Gm-Message-State: ALyK8tJctJh4vJBGRnRZm9BzKCREXdBsSm39zscrjOzs1VAjGONC/ETmK3COH1kF1LLqr90U17LwCqvMPqH0bA==
X-Received: by 10.37.22.85 with SMTP id 82mr1944727ybw.123.1468335957456; Tue,
 12 Jul 2016 08:05:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Tue, 12 Jul 2016 08:05:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607121515300.6426@virtualbox>
References: <xmqq37ng7x05.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607121515300.6426@virtualbox>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 12 Jul 2016 08:05:38 -0700
X-Google-Sender-Auth: RCnduelYqi4_3mv5CpRRfqpwSso
Message-ID: <CAPc5daVVU0+Ext0tk83kOLwZxPGPUFZQ9_5y7yyX4JD0O3Napw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #04; Mon, 11)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 6:16 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 11 Jul 2016, Junio C Hamano wrote:
>
>> [New Topics]
>>
>> [...]
>
> What about http://thread.gmane.org/gmane.comp.version-control.git/299050?

Not forgotten.

It just is not one of the "New Topics" yet, together with several
other patches sent to
the list recently, hence it is not listed there.
