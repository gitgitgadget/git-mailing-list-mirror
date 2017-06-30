Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CC1202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 03:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdF3DSz (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 23:18:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35279 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdF3DSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 23:18:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so15339624pfs.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=Y3v7t5fq5rTdZKt9r7UhViF35bSMfeRN43mRzfHTFlM=;
        b=b3WUqZ2nicDdFqlxu+K5vsiY/n7EymV6xFifQ5KBGnFZ5PU1jg9ttgfnwaRighCQO6
         /jp8AdmQXLvBscA+9DKcaFcyRo2sBNsN+00AzEXiRojiR+rp9GBXh5v4dnnK/y78+lUr
         vkj+3C9vLXyORFBfV3hkwFqJNd0vuMG9qSEeTZP6adIU3JR3VsghJBpvZsWxB9GBbl9I
         CxeEWvtYOmHvVu4nehGMl5AtQUdSiMzsPdgIafOcpVGWjNZo9aRwzxp+tz4cLUCkN97C
         85u/i+P878xArDu7rcP9cLfNldSmfLDzNL/vkERMIlLbgI1gXjcuwGyy4vsApWex9u/3
         gN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=Y3v7t5fq5rTdZKt9r7UhViF35bSMfeRN43mRzfHTFlM=;
        b=ayacSVxaIW+KPK1JsJ/Jcqnxs1DzJOx+cpob2PuPgYHqZsKTpaF//sXpvAGN/DBKKp
         Sqst/MYETy8i49xBokDQmVFivLngnKFMbqa6hTz1cayVqIHfBPktOSr94KGC0fI9Ck6s
         V41qRj+zfKUZeAafHzOi/VRsTbxBQpWg8KfTH1iIstM0eyZAWc+yKiMvgjJWUU8BDKUP
         YrXrQNw2Qu53dc4J8qFqwy7JEXOexAfkGM9kwJ+dmqkM1GsWNQbQbXrWEW83E7cR/KAd
         /kPMgnjETz0Uww89+qJAxLyqrcxtAm9jWHXjaJ3PZ2CTSUqdB3qtVi1Lc/4VKzl4omkF
         SO2w==
X-Gm-Message-State: AKS2vOzI5URHCb9DYSW3YtU4CC1vT9U5cJ3FyFpEsQ6pMXQnkj3lnKap
        m8oPUS4R33bznGP7/D8=
X-Received: by 10.98.206.67 with SMTP id y64mr19787239pfg.108.1498792734306;
        Thu, 29 Jun 2017 20:18:54 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id e77sm14247861pfk.123.2017.06.29.20.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 20:18:53 -0700 (PDT)
Message-ID: <1498792731.2063.5.camel@gmail.com>
Subject: Re: [PATCH 1/2] commit-template: remove outdated notice about
 explicit paths
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 30 Jun 2017 08:48:51 +0530
In-Reply-To: <xmqqzicqu17z.fsf@gitster.mtv.corp.google.com>
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
         <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
         <xmqqzicqu17z.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-06-29 at 10:56 -0700, Junio C Hamano wrote:
> When I said "I would have ... if I were doing this", I merely meant
> exactly that---as I weren't doing it, I left it up to you.  But you
> did it the way anyways, which is very nice of you ;-).
> 
It made a *lot* of sense, that's why. :)

> Looks good.  Should we consider this signed-off by you?
> 
Yeah, forgot that. Will follow-up with a patch.
