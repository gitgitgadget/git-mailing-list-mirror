Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148321F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbcJKRhz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:37:55 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34144 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbcJKRhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:37:52 -0400
Received: by mail-pa0-f44.google.com with SMTP id rz1so18416873pab.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0p6A/tYP1vsZIdnMiKx0OjozpOjspnSOHOgmE3t8x14=;
        b=USflsU2huZ2SzUKazMMsrcq95b5WauaKUJncJ65LhKn6LQbYLd8k8YHzUORNIfeyf3
         M2Ew0ZekdcGlj2n+07oW0X+Ib2n8qlKBAZBCDuoqkuCbsTWGZZF9FmyQnuqinjIBV/kl
         FFHniOV/Qoz62BzMBM4BJxVEod0uFdnKdnu6HMLxQnDEKYWoAKxUs77K+E0XWMcz3Vty
         QIfXjtaQ2OnkTE1EFeYzo6ExabS/XO19O6UZ1QHT2VwUCtWr8c7jzl2fmy+MvJUtGfgI
         +QOM3wTCql1PaaDEGS4AaSUNXJbaTAIecuVaYKHcbXdoMhdwnV5SwjTT7EWh1VNv0kKo
         4g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0p6A/tYP1vsZIdnMiKx0OjozpOjspnSOHOgmE3t8x14=;
        b=X6ClPE+WYArgdxmbS/3OANoAKRnppKmQCcc/BbbZAZdI/zpel8CpeK8nJVyTMN96Fp
         zfoWCKIdA7fkGKOtCB1MzM7fVAZW6F818t09tx6P+l2Z9/CG4kaUTP+PHEErb2y/DbPc
         B0mB/X0vfrlJkkDVLuNuJ2PQYJlIyZp8EYZo6uJfqdCht2FbyTqArRR9C9OLKhje4FQi
         AZ0C0ev2/A9q8B4fOc2Zc6q5UNo2JC4r1DKfjOmy1sJQtgOIOOYk6Dx68OE1Y0UShLa1
         Gp8FcDTGZzWDj4yZbEl+dnaZm/KMGwGpemOUWYDZHcfw40SU4/jrdWm7nwp6ymJmiDz6
         aObQ==
X-Gm-Message-State: AA6/9RkbS8R66J9miqRx3nBH33NDATOueAN02Ju7LADaKYEEdgITKp0Tm/3RAbyu/hemF9vD
X-Received: by 10.66.235.10 with SMTP id ui10mr8446143pac.81.1476207471750;
        Tue, 11 Oct 2016 10:37:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id p88sm5732688pfi.51.2016.10.11.10.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 10:37:51 -0700 (PDT)
Date:   Tue, 11 Oct 2016 10:37:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 26/28] attr: make git_attr_counted static
Message-ID: <20161011173749.GC9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-27-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161011002115.23312-27-sbeller@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Stefan Beller wrote:
> It's not used outside the attr code, so let's keep it private.
> 
> Change-Id: I0d15e0f2ea944b31d68b9cf1a4edecac0ca2170d

Looks like you forgot to remove this :)

-- 
Brandon Williams
