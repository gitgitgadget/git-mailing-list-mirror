Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3A91F404
	for <e@80x24.org>; Thu, 28 Dec 2017 00:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbdL1A7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 19:59:32 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41554 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdL1A7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 19:59:30 -0500
Received: by mail-wr0-f174.google.com with SMTP id p69so29172525wrb.8
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 16:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xnc3UWb4bCLyD6b5rDCjIeGPZX3p3Mzeh0GWA3D33k=;
        b=hh8fOfHJD33xmNrtFewcT5OhthplGIlXyjrUZabSrPfDEwEVwTNByHsYVU8rAS5LiZ
         QvpXhfd1gccI8sz/OjEjbsleF43UjLFlIqiiixVOclZa3NKztbKi2Lpp5CDrasuUBYeI
         C1gEidHgQLG02xpik6f79Ig0WftGlk0COXoZTdhHz0RcBL3pRlZf3O1p1CXPkx4rkK5X
         rvEf3yYXLxQD7cG/zZmA1sZ4Q2GWOLxq+g8d2BWHvdBfEgtZCI5P5GywzGsptTVFdfw9
         FVc1LMOXqFNnokgyscHilEgpvxC2yBpe5USK+WEO1xXDAW6iJDM1SrrGahkKC/w9EY0/
         +6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xnc3UWb4bCLyD6b5rDCjIeGPZX3p3Mzeh0GWA3D33k=;
        b=sinELH8bJsRiJ7BIZilkFEEN4UT3R+9cI46OlcOc4mdNNs99WLis4yblFE/ywMKkUV
         cLX5EdaH7qT8mEiLFQjOzyICt9f3Xk16fjXP+S8khkbvXjOU95UsQs1f6meT24v+65u5
         KzZd2z2camRszL1mLL80KUPcOqHzfOTguybPBfPgrYpdPis/IYJ4Xm9BrHiqynsyg+PZ
         f71livg1b7UqDbkCwEHei6Fhwk4jSY43neMdf9+C8m1HQVIuUJw12cO4KkHXhZomfYub
         C9x9qNLzxGMr+zl2mF0nmIeRLBxB/M/K22TdO2AlMeL8B0p/BnKuV6wzvk6CW+LPGemo
         eb0Q==
X-Gm-Message-State: AKGB3mK30frR3SVbhn1Wo9hJqf08zH9fn4EAi+CSJSuhtKoOV50ZF5yX
        /rfcekdOked4/OtM6qbgdzk=
X-Google-Smtp-Source: ACJfBoukvQBP3PdZqpVH2cqI5nS33FMn/kHuX78KqQ1KEoQqpTZO4RNXfvDURWc5Vv/hr03deOFF8g==
X-Received: by 10.223.169.67 with SMTP id u61mr31482772wrc.30.1514422769771;
        Wed, 27 Dec 2017 16:59:29 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id q7sm14994744wra.83.2017.12.27.16.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 16:59:29 -0800 (PST)
Subject: Re: [PATCH v3 0/6] Renames in git-status "changed not staged" section
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     alexmv@dropbox.com
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <66038d94-6e2e-9af0-d8bb-04cbe6f189b8@gmail.com>
Date:   Thu, 28 Dec 2017 01:59:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 27/12/2017 11:18, Nguyễn Thái Ngọc Duy wrote:
> 
> v3 more or less goes back to v1 after my discussion with Igor about
> porcelain formats. So 7/7 is not needed anymore. 4/7 becomes 5/6. The
> meat is still in 6/6, now with some more updates in git-status.txt and
> to address the comment from Torsten.

Albeit a tiny concern expressed in that last e-mail[1], this now 
seems fine, and a few tests I did came back as expected. Thanks!

Regards, Buga

[1] https://public-inbox.org/git/CACsJy8A=jZ9LAuM50GVjNT5gtdiYYMyMuPBSrJFO4LmKVQsETQ@mail.gmail.com/T/#m18b4e2cb2b7685fcc9650f3fb71b2191ef74cbe1
