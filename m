Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D885E1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdFJJhX (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 05:37:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35684 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdFJJhW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 05:37:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so11070607pfd.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=ofpVTo9WacbE2lIElp1hyVYRyowS+/sHfS2/FAqxt/U=;
        b=bfBYEEoouqFKNSnRHe3UoxvLxi2cffxs6QIO0m7HY1WlCn8MRuuxr81F8zmIz/wYSK
         brCIdHCP/pg/qAQ8RbFJg+aY1NBXZJX2YWWfsgbPhjHptyghSq2dDi5kJUtvnwMl454S
         QRMgIysGhwgMZeJOTFzESk5SdSegdzuDw47tD5iq5CwADNxtlLWXk+Wh7FNvCtJ0IUDA
         zZ2B+6FFW6dnXASsoVkz8jiHuiSyhLrw31+3R4ZSDa6o7662jfC2YIIV5+TMa887oD6G
         YDQoj6BAeJZXDFqP1Rqi2DCL+xbFi+KGoDs4E/pXzlYVgkzCdA7HG7U3Ey4Y+9dJZS0Q
         uZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=ofpVTo9WacbE2lIElp1hyVYRyowS+/sHfS2/FAqxt/U=;
        b=QxoxYQKQhqIMTeVCNXcKje14+G/jdA0+25llaXlPsSy2G06Hvb12rtgEucIkNsUKl8
         I7WpLfwxRmTtMHzBbE2brornivCg1BG7aH7J8NMGbMcMJ/pVJfxW5MwYW9rc6iqG/H1j
         7cDxJE9/jAlQvpSS7vZ7lRsBRARUJfgD2omKWk3q5oWePox1/t56mKQ0EU93nUsxdIWB
         yftDamxUYBAY81Oapm+Qf6HsOVg5AseF9BxXEA2Xw/VHCwh6E3T7CXJlz5Zm6aQu3+zG
         VufPj/z8CNlrvKfJAHkddgJeIuD9zPZtnpBW8pThXgqcSDCE432nji6WyLRG/JnCb0jX
         IarQ==
X-Gm-Message-State: AODbwcDE7YzLHwTpm0xnDcwsUkfln4HbYyju1jFvOpjdFIlme92CaZI+
        FcoW5l5K0t4kyA==
X-Received: by 10.99.44.68 with SMTP id s65mr37490343pgs.73.1497087441368;
        Sat, 10 Jun 2017 02:37:21 -0700 (PDT)
Received: from unique-pc ([2405:205:800f:e175:94b2:5f2f:a42d:438b])
        by smtp.googlemail.com with ESMTPSA id 204sm2936438pfu.23.2017.06.10.02.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Jun 2017 02:37:20 -0700 (PDT)
Message-ID: <1497087413.25534.1.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Date:   Sat, 10 Jun 2017 15:06:53 +0530
In-Reply-To: <1497084241.8531.2.camel@gmail.com>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
         <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
         <1497084241.8531.2.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-06-10 at 14:14 +0530, Kaartic Sivaraam wrote:
> Looks odd. 
Just to be more clear by "Looks odd" I mean that the new status message
looks odd in the commit template.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

