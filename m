Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F8B1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBBJuh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:50:37 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35161 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdBBJuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:50:37 -0500
Received: by mail-oi0-f51.google.com with SMTP id j15so6175034oih.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a01C3K1Y5Gz2hdIAqsjGNINL1D1ItPOJK3xyTcCgsgw=;
        b=chWsvfQO1i/keXoGOw4+y/77F9S3YY5RhIrJ3URZnchwkWsTRVlypbQGWHeV4xOyBK
         j3olMADxnWomX8sZtK4VOH3wRzcRi70wC3uDsaDPIJOiE6MQfJn8I7Y5KTsQKmmUZuJQ
         NU0cRj7SsnekrFRZpBmNroYx2kC5314VVExBki0yCypV0v/Ewh4QsdsriURQk+vuQSk1
         XLvV5r7w6exoGln4BtrWaZzxJ06pw3DpL3nMQb1YybjEd75vnOQPdlN7exc/AprLn8Zk
         +eSfrYwHHISUVNiv/0BPMMvDMtVYJ2i2IOCnpSnEUkJ83/yUy0ybF2+p+RQ2ovQpPx/6
         W1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a01C3K1Y5Gz2hdIAqsjGNINL1D1ItPOJK3xyTcCgsgw=;
        b=VEgpAB1uwuTWT1yKwCVNSKq0D48DetLCVvtSXV7ib7mOM2CmrXkz6QxmIbnK+67VQH
         HrdyL71ivgXL2SSkuGhopKeBD3j0lVK7PW4VohE4W2D/4D/pERZwVs8VVIqjdyCBm/aH
         4Osp2DIzhy/962yzmXzhcqqBDIzymvOF9y9kDPFWcF6QFTWp9t1jiLGvlr0cvKiYVn6t
         YDglTWutv703P0hnjjWY78QtTIQO7b2Ee3Z1IWFStuzKXoehdIGlhmaKekrnZ3+xb0f3
         ETbjw2XhcpnAA0tO7MiJAqDewH5+32DVgTsmj5ruISO1M7q31C/WxbeaXcuvWvpUmV15
         Qabg==
X-Gm-Message-State: AIkVDXL02grONdDGG5xUITh5aXHiC+l6j3KskjTjrOxLDxuY+C97wweGs04l+CDs/gmDNwGAzwz0e2Tx8qQ11A==
X-Received: by 10.202.79.138 with SMTP id d132mr3223561oib.169.1486029036429;
 Thu, 02 Feb 2017 01:50:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 2 Feb 2017 01:50:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702021043110.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox>
 <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com> <alpine.DEB.2.20.1702021043110.3496@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Feb 2017 16:50:05 +0700
Message-ID: <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 4:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 2 Feb 2017, Duy Nguyen wrote:
>
>> On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi Duy,
>> >
>> > On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> >
>> >> This squashes two changes from Johannes and Ramsay: [...]
>> >
>> > Sorry, I lost track of the worktree discussions... Could you remind me
>> > which patch is supposed to fix my continuous reflog corruption?
>>
>> The corruption caused by git-gc? It's not fixed. All the changes in
>> this series is shown here.
>
> Oh sorry, I meant to ask "and if it is not in this patch series, would yo=
u
> mind pointing me at the patch series that has that fix?"

You meant this one [1]? There is nothing substantial since then.

[1] https://public-inbox.org/git/%3C20160601104519.16563-1-pclouds@gmail.co=
m%3E/

--=20
Duy
