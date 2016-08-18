Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFAB1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbcHSBgk (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:36:40 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38182 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754791AbcHSBgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:36:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so19500015wme.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ypo6TWFdgFY2c6q3t4CKNnsIF8U/lfAaCcer1sofIuE=;
        b=w+EhzqWxbJ3xhKfn/oPRbD+NIqz5YYkrsqorlEPrJeiGuOoc95ETCpG67TX+kbTyTr
         WiY8nE1FmZ3ioESv9tqDFPjR22ryxhuQ0BS9lIFkFvIztyI7hfEhA/iLE9m6jpGVX02T
         4POLJ/io7eCXWnUog3eMjk7V7LEDohhpVaejfhTICK6U0K8L4+kNkSVietNVJODbZjiC
         lJ4UCdfYR+K0QpWt9h3nexQZpLcb1+TmgzWgoscL0s9Zf3gp0+1aVq6jXKetOoXG+DVp
         LraX2u1diOd1ZdgWYu/jNn+nvUXzXxQACBYPUF6PF8lSXiPZNoX0Ruaf7ROESd34ChGD
         x5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Ypo6TWFdgFY2c6q3t4CKNnsIF8U/lfAaCcer1sofIuE=;
        b=RSLox5XRYaGDtAuZTV9BQexFOfv/ad1bU/Uf78Qo+lUHZwpAd8UfnRoqUSfyefELrt
         vC5yKD28emryUU47a3MQczbjpm72docntvfvL3nu9yXhhzavqFab3/byH5ot/odTA8dE
         w/BCuQxuG13kSExRkttpUg21S9k0ILOCw0JbcLCDoe7FAXAacaOn1RdCj4DanUeU5rDb
         l0o0v3pz6IbKHXTUrvmjJDODbOybfL8VIec488Ph0qGHMfrK0i7Fa0YxKV0iWn+uhpdc
         BPWB4rJ4wcFUkbFyqA3RjZ4WY9SuSbGp4bX3Ol3XVfORYNJq/s/zgkeU9hNTOYKsA0OF
         BLiw==
X-Gm-Message-State: AEkooutwjPmqZAkhuEsSFsLDmCOs1B1ego9p+pUozlybcQYDnoO1+82dG5TEFYxDabYZmQ==
X-Received: by 10.28.140.10 with SMTP id o10mr423164wmd.36.1471539215980;
        Thu, 18 Aug 2016 09:53:35 -0700 (PDT)
Received: from [192.168.1.26] (abpk106.neoplus.adsl.tpnet.pl. [83.8.52.106])
        by smtp.googlemail.com with ESMTPSA id za2sm3034309wjb.34.2016.08.18.09.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 09:53:35 -0700 (PDT)
Subject: Re: Working from different machines.
To:     Tobiah <toby@tobiah.org>, Junio C Hamano <gitster@pobox.com>
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
 <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
 <60d5e760-dbc9-121e-f003-a6971534cdcb@gmail.com>
 <4a154cc2-c3e2-65b7-4bdd-d7c41d700491@tobiah.org>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0346c307-931d-a7b2-7179-9c75b16bace4@gmail.com>
Date:   Thu, 18 Aug 2016 18:53:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4a154cc2-c3e2-65b7-4bdd-d7c41d700491@tobiah.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 18.08.2016 o 16:28, Tobiah pisze:

> ## [...]  Why does it still mention 'flipper' and 'tart' and all
> ## other branches I've played with.  When I delte them locally, I want
> ## them to be deleted everywhere.  They just keep accumulating.

In case of non-mirror setup. Git wouldn't delete remote-tracking branches
(e.g. origin/tart) if branch in remote repository is deleted (e.g. tart
in origin repository); you need to prune (or set up to auto prune), e.g.

 $ git remote origin prune

-- 
Jakub Narębski

