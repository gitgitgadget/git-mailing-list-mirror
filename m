Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A1B20401
	for <e@80x24.org>; Fri, 23 Jun 2017 06:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbdFWG65 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 02:58:57 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33137 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbdFWG65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 02:58:57 -0400
Received: by mail-ua0-f182.google.com with SMTP id 70so32092113uau.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ea4zJonZg9tbwMrE6tSeHdf8nmJ/1f6I+816LDboHxk=;
        b=di6UHAXVqQK86ukpG7TNgeeHMJA5oFrf3rDcArjCgj5egc6OgQl+Xsdp7FafvlJtoJ
         zdkOb+HsMP/i+wmUQguooKTfO669J6f6Zdzj+Omrov93Whf2i6K+RnvTDzLGNxIrcDL+
         WcNmv8aYQqiDeVyl/lIo08UawbQQgEYx0CsYWZrqay1mePtu/WcO/bikzTU/C52/wV2p
         6gL8g550pOIafBMF9bKPqn/21ULc7DvjmJyiVvStzR97viU4wd9K7trVg7U6OaAdY/kX
         +c0zH9Icmd0C4+Tz5Y/s0nArOlctjcFQVWnsNW2PJY1IfbOz71UWQjsxDX8c8x+zjK60
         hnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ea4zJonZg9tbwMrE6tSeHdf8nmJ/1f6I+816LDboHxk=;
        b=G3HPJfYkTYpXyZiz5tADMXrrz0XcvGXHzSrPPhmwyyMzv+WXGAiwVIGLhA+EPaiPXZ
         r8y/KETDYt2kMZdsC7uulYxRfuV59ItA/Esx002kyw4nc+dLSg0qNYCqLkU5tBJhDigO
         y4PKB8curnVw00JCtcbQidiTDC/IWBTJhMOkLQFUUCL1gzr/BLKs5n2Xw2g1Er6Jp7tG
         2HSlIeufygtmLCfLoj/fyh5t2qE5bcjiX2Aqum7g+D2uZ4OSz1NAiuDRCbbxV0nxKSfD
         SinqMakq5aPrY9q6Degd87k5x/Aq/oHYr2eEXn0Kq1XUZsDGMDbszPX/7e3pBxPVO5Dh
         tJYQ==
X-Gm-Message-State: AKS2vOxeyQXB7jtazNM0+tH2OnrEoxs+OwB6T2FQ/AgiGi69fg8PcJom
        u5BWHlNhM5ylzLQbFSjZ70hdBTGFlQ==
X-Received: by 10.159.59.143 with SMTP id r15mr5176180uah.110.1498201136125;
 Thu, 22 Jun 2017 23:58:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.184.136 with HTTP; Thu, 22 Jun 2017 23:58:55 -0700 (PDT)
In-Reply-To: <878tkjk7m7.fsf@gmail.com>
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
 <20170622124803.45sduodpfbwuuq52@ruderich.org> <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
 <20170622134708.fcc4zxakga6p255x@ruderich.org> <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
 <20170622204628.eintlap4uchlncub@ruderich.org> <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
 <878tkjk7m7.fsf@gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 23 Jun 2017 08:58:55 +0200
Message-ID: <CANgJU+Um-2CLDYYsS=acJ5udc8M2Wr9KSL3PuGAYpda0WaMmxw@mail.gmail.com>
Subject: Re: your mail
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 June 2017 at 23:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com> wrote:

> +You don't need to be subscribed to the list to send mail to it, and
> +others on-list will generally CC you when replying (although some
> +forget this). It's adviced to subscribe to the list if you want to be

FWIW: "adviced" is misspelled, it should be "advised", and IMO, it
feels like poor style to begin a sentence with a contraction. Not
strictly wrong, but sufficiently informal that I think it is out of
place in docs like this. Better to just say "It is", or even just "You
are", especially as you use "you" later in the sentence.

I actually think simplifying that sentence considerably is preferable:

"To be sure you receive all follow-up mails you should subscribe to the lis=
t."

flows better and is more succinct than

"It's advised to subscribe to the list if you want to be sure you're
not missing follow-up discussion".

> +sure you're not missing follow-up discussion, or if your interest in
> +the project is wider than a one-off bug report, question or patch.

cheers,
yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
