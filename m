Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C05C1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeL3ULV (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 15:11:21 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:40919 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeL3ULU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 15:11:20 -0500
Received: by mail-yb1-f171.google.com with SMTP id x201so6267931ybg.7
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Fjdmne42oJwnHC/RfV8I9aaAsnVwFi2xUYnCKhPDOC8=;
        b=fD29aM5zSnImI4TObxXWTaTK9XupKf8mglrGvI9aeNF9T1gw65gnCTqvcZ4T5HrVnY
         GKr5dPjkvAP6n8vOYLA6JfCsMb93T3ZaNGQH52kGW+XzBeECDnde12+37FOOduwjMfml
         hWDsgRanH7+8EJ9Vu4gFUtt1d/9qdems3fhXn4ir0g0BUM0NCqdHYjcEUBaj7yGwj1R7
         gFsnOstcSY9QqqlXLK1g4owJa4IiLd+lP7DuJR2nKSDgeyO2WPNM4O/6M+lORIYNnUCS
         nYSPqUpAQ3d0VwQqKNWKrLWZgAHuiyskp0rst4pzHCZGptY6n1FmYO6MqxydKbPVLFFT
         hFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Fjdmne42oJwnHC/RfV8I9aaAsnVwFi2xUYnCKhPDOC8=;
        b=qhxCKk6pDSRksVAqVrru0cV5FtvzUJW3tG8JbSIHDH3isj0u/0qGye13qJK5f+SVUg
         W/Z1BjbOAndLbnCVKAqBRPrJENDLXnTguvsPJ4oPBuwI0MpnrYRGpVr2HoWIUZ23XLn0
         y78iWk1TjjmRieGbfhY+qj+m4dzzQO4k57qxmVVqbcGJMpYk30Dfr/0tNSOp7PN7uaHM
         lWpkMMlfSFbsBf666gClnjFM3AurYmVvYa8Vo2nce8WI5cQKT2JUI/U7KUkjL63z20RS
         rb6ZHaV1QNAIMRGsPp1LhcTmU7e661dd7+OXDxdfULUfB8jyy9+CE22FUTGyQzfVGYCJ
         JZoQ==
X-Gm-Message-State: AJcUukdCs3KeY5Ek61WIatOt5d6HuVb5Gb+R8lraASLXQrmfLy6Ksq9t
        4wnI3NknHrARNr+ZknSypKAOxHGRzcU=
X-Google-Smtp-Source: ALg8bN6XOBE6qfQ0zVz7U6knuR61NrYrHz6uVDrd6X3kvFuNviSDeqndH/SviqTjUd6DmuhFSuNGpQ==
X-Received: by 2002:a25:ac24:: with SMTP id w36mr2680766ybi.516.1546200679587;
        Sun, 30 Dec 2018 12:11:19 -0800 (PST)
Received: from [10.16.0.13] ([142.234.115.18])
        by smtp.gmail.com with ESMTPSA id j16sm17693600ywg.4.2018.12.30.12.11.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 12:11:19 -0800 (PST)
From:   Xheroz 128 <kenneth.951218@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Git extra hook, pre-upload
Message-Id: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
Date:   Mon, 31 Dec 2018 04:11:14 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Kenneth Lee, a student at Teikyo University, Japan.

Currently, I=E2=80=99m doing my Final Year Project that requires a hook =
that executes automatically on the server side of the repository, before =
the objects been pulled to the client side, and after the objects have =
been pushed to the server side, which is "post-receive" hook. The =
post-receive hook work well for me, but I couldn=E2=80=99t find any hook =
to be executed immediately before an upload-operation is performed, i.e. =
before data is sent to the client.=20

Why Git doesn't have a hook that executed immediately before the data is =
sent to the client? Any advice on getting this hook or any similar =
function of the hook?=20

Thanks,

Kenneth Lee Zhen Kang
+8180-9828-2935=
