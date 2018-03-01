Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062AE1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 17:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033436AbeCAR3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 12:29:39 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:44382 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033044AbeCAR3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 12:29:37 -0500
Received: by mail-lf0-f51.google.com with SMTP id v9so9404476lfa.11
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BqIe73rwXVDZTTdK7SgdcHlqGvArEtBCZONEv6j5RLg=;
        b=iHg05mxjKHIxFwbT7wCDKMOt0c8uM5DBSP5Ku2cRvZyvVXmoZ6x28i70bx3syD0IlB
         ccm+pvBIrtkcbRyIdSRc1I9FdBRCdQPxNIgGulIajZKmJK3GxcMNqxv0UhLiVwPbpJLP
         KttAP8fh0IX45VnZZk3YDZzc7KOtmCnvxAjcxwg20S4XKdXZiR6fXX9SmQTqfD3abjjp
         ND7CMe8VfXcp5IoPeiNqd8tZiyMkNBApl8lMeK3fge5kh144PqJBS3oBBYlSu0KFbZVk
         8A/DPkNnW2cOkfhS2DXClasAH1SSVHT44R9dU4sJprXwk2bjcbIelTjakqytsVgVA4Zm
         HMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BqIe73rwXVDZTTdK7SgdcHlqGvArEtBCZONEv6j5RLg=;
        b=Q7hMrM8ZiWNh5tGclLDx6ImGzUG3CJ/w3vhSdvnuFL5KPYb0zttVCP4pNUUa8kZZkJ
         pCOgjdAfQLXVwi4Te6CWvm5QH9+BQzKq8TjOaTWCT5DY+wEIhdgr/1dhzagRdkz3H0Un
         ONhVJGAi1dzYMkBBCAxM0wUSL1vLinPiDm871k3kr/eR1S+xoiwvP6oeA9JqT45DauCp
         a6Ejbi30jxo+Co4iRE/x5yFbWG26S+CQUztpRDeDVjzRBJXV88mf3CTOq4UHoUbkLmd4
         lddn0EZb61xARG/MJB/bMBskLvZ1jtwDjdhIHdo/DivUrRFNgtbLEgYQR1mzM3336cQi
         WSng==
X-Gm-Message-State: AElRT7FoNtMYmJn/muTTcu3EHEw+90ufnW+EGdG5kNHw9fT/+zDHi3bJ
        039O4ttZpdw568ln7ibFZryw+EmQ
X-Google-Smtp-Source: AG47ELuNyChTFztU894DndXsnp0PDXk9TAFslPdi0AmZqDiQJBUwp3wb5CkN5KudhR6HVQMcnP9xUQ==
X-Received: by 10.25.222.207 with SMTP id i76mr1761804lfl.133.1519925376254;
        Thu, 01 Mar 2018 09:29:36 -0800 (PST)
Received: from [192.168.20.21] ([89.113.128.32])
        by smtp.gmail.com with ESMTPSA id q63sm951627ljq.17.2018.03.01.09.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 09:29:34 -0800 (PST)
Subject: Re: Obsolete instruction in SubmittingPatches?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <48b5c506-6882-81e2-35f6-7d040bfc6017@gmail.com>
 <xmqqd10okcfu.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <927e3166-9c60-fca5-ab41-f6d38380c1b1@gmail.com>
Date:   Thu, 1 Mar 2018 20:29:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd10okcfu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.03.2018 0:54, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
> 
>> Is this part of guidelines obsolete, or am I not understanding this
>> correctly?
> 
> I am merely being nice (but only on "time-permitting" basis).
> 

Does that mean that the integration of a series is easier, when there is
a re-send?
