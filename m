Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A87720705
	for <e@80x24.org>; Wed,  7 Sep 2016 11:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756574AbcIGLr6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:47:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32925 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbcIGLr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:47:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id 128so867966pfb.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=raK5UhzSxImXOY74d9M+0u5pS5geHUyB/EiEsYTyAkU=;
        b=WuPmaEzVkVXSGbdmDG9PylYofwu5r5O3Qgsa+coF7KNrpxBSPvEBzJEFbqnKImFu3V
         0TSuQSFFiMF910mLrkLnIj2cLM/t6+Nh/s885FSfHfOW9IE+M+D8xjLYbDRyTpg7/uj1
         4roF5lCbc5oa8aYrTlYbjFyd3IsnGy0udpeK4aeEktILiiTp0yQlv3YOOTaP74k7vmu9
         fh9xyeZcEQNXC9VigYD4tGWReEj/R1nr7/M0VeN/wY66C+ZhtyUisUNxD/cFXf2aOZo6
         jVJyN09iHVv+5gUVto28ZGIRRSIW+f11umkencS72gYo4fSmRV4j6LfAcLZ5uPQjT5ZA
         Lbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=raK5UhzSxImXOY74d9M+0u5pS5geHUyB/EiEsYTyAkU=;
        b=czKnQIbPZEpmVqwg+E8oYT/BbBDlWSBs9hNHa+8xLj/xFVcTdCSzlrCK2rnwFnQ6kM
         ewk0yWSeOwtQkkgFpYDISNjj9LnSip4uIBHkCzKEczdtK7seWCurz428/umDtHEZMEQJ
         oBAnI19FQsAvEfKFQbKFP4hzbnUiXdkw+Vd5AO9kufpTstFBjXHA9P+XEXs30aHcsJqN
         jZim1VM5l5aTRrCt4Q6Ca1HAD+UN7TquH/HJTZRNcJZvnhxJ7Kavn6pU5nUIfG9+EmvJ
         hZKGk0MUOFVUrbB+h+xpgBgrSXkMvYE0O3khWTi+D2QQBB/H63Y1pIoMPAXHZzBlcrOW
         bcug==
X-Gm-Message-State: AE9vXwOMcSUPSGb96vdQT+lU8ARbxImUPzMgEpz6VN501lZHqLIGawo7aoR8RR0h+takUw==
X-Received: by 10.98.36.216 with SMTP id k85mr29247367pfk.73.1473248876504;
        Wed, 07 Sep 2016 04:47:56 -0700 (PDT)
Received: from Yasushima (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id wa9sm48452381pac.35.2016.09.07.04.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 04:47:55 -0700 (PDT)
Message-ID: <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
From:   "Satoshi Yasushima" <s.yasushima@gmail.com>
To:     <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>,
        "Satoshi Yasushima" <s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com> <1473177741-9576-1-git-send-email-s.yasushima@gmail.com> <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
In-Reply-To: <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
Date:   Wed, 7 Sep 2016 20:47:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
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

Hmmm.
Although I noticed now become PATCH 3/6 has lost.

There seems to be a cause in the following taboo.
Sure, PATCH 3/6 is little too great.
 http://vger.kernel.org/majordomo-info.html#taboo
  >Taboo things to be done when discussing at VGER lists
   : (abbr.)
  > * Message size exceeding 100 000 characters causes blocking.

To somehow.
