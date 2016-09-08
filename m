Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1982070F
	for <e@80x24.org>; Thu,  8 Sep 2016 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbcIHM4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 08:56:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33113 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbcIHM4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 08:56:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so2500434pfb.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=vFSaYQCD1N9Yw2AdFLcVqNC/M8ilmB0KNZnYnaEwZOk=;
        b=O234wg1eF43ibBxqySAE8wpx6X7nzjO+5bmqMorbT/oEXwTDp5NsWHQeFf3whNj1f/
         i2nj7ls1z3G0oYgoTvAovW3INYHJc+iNOa8zDpgK3745mq0r67LLaalR/gwM2T8snrRF
         8xWpb001LWdd9JK7F/o8EdvFrv/VqyGHQWEDLYShJas0o3NXJhDUoEvucQpvV9oDmAXu
         5Z2pDScrLppEqnm0TbnEvYT5V3EF5GhMmUzyIe/F05R0bGDA450HRE9bHEY2Am6LU+le
         07y0zpb39GTvK2FO9gPswhpLyuzx5TIwHeByl69ydSoZQpeSPsto6sJiIuEjwYFMzK4M
         AnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=vFSaYQCD1N9Yw2AdFLcVqNC/M8ilmB0KNZnYnaEwZOk=;
        b=Y9hB5d7lOfkVsB4birVc0rhEdrZtKuuupBizGM484lAp8w1WR7D7+pck4rRqET5Gc/
         7JG5QInIgShPPClbIZE4LoDLC0IgdGjYWalDpfYYsfv+KEmRL7zUyxYPaHvrHXGGI0wS
         7LPxD+TJGcNZCXpIAN7eKLUgT+9G9SRJomCIvnWkVfpH0ij55DuK+njj4usNOyD7eZsr
         6bVuN+5MlrzSPwrV6CbaqKWrOwFMEy9k1n4f+l40he9q+LtVuBUQPqox6kccDXCmvqYD
         LalSH+8sQQFuLZGQOeFOiFxxgiK4hhweZsy0hpPKpBS1GX3EXvrV0HxXDZO+sVp09PPS
         HyXw==
X-Gm-Message-State: AE9vXwM5e/SeLRgK/GFTyGxSVkR1iyMhFhOxv/JVlKgEOvGvEDHxZ2H+bETD+T5fNiLI7A==
X-Received: by 10.98.196.130 with SMTP id h2mr50777593pfk.140.1473339375929;
        Thu, 08 Sep 2016 05:56:15 -0700 (PDT)
Received: from Yasushima (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id an11sm56420813pac.26.2016.09.08.05.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 05:56:14 -0700 (PDT)
Message-ID: <9F5449944F884C4AA333D4E756B71BA4@Yasushima>
From:   "Satoshi Yasushima" <s.yasushima@gmail.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>,
        "JakubNar?bski" <jnareb@gmail.com>,
        "Satoshi Yasushima" <s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com><1473177741-9576-1-git-send-email-s.yasushima@gmail.com><1473177741-9576-6-git-send-email-s.yasushima@gmail.com><048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima> <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
Date:   Thu, 8 Sep 2016 21:55:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-2022-jp";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3564.1216
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3564.1216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 07 Sep 2016 10:35:22 -0700 Junio C Hamano wrote:
>Since I received the patch directly bypassing vger, I queued it on
>gitgui-0.20.0 from Pat and tentatively merged it to my 'pu'.

wow, thanks so much.
