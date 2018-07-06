Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513561F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbeGFTO0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:14:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38975 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeGFTOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:14:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so15281992wmc.4
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lnNj3DiLnlu+p8GcTPRPqgOe9OVQ2kWloiq+EmTAGTg=;
        b=b2P9MWVmjwkq56uJPwF2/6bSzKoVv1fOAEGLQwi0PV33KJMEP8XNURazs/n4j1AGRD
         AsqXxx7wgbVq9XqOGkyW6DZKVuhvTM57BwDndZgW1jFWT+wcJfqM8gYQK6rVLN5TedPH
         2ZSr7C0wO3O7wkpzsWZrzfDii7WGau/CoM3cRlNE98yaFktxk93VIKVVn+rWn3TACClG
         PD8J3w7JQl4tvM9fY951SqMZHRS3maXcsATzOfbpLLe8uHn3UHeTrRZ0LW5HHwl6QnIo
         fYk1T2maowu8ZAok59mU0Dr8STvikwHOckNH6E9k7u2JWH9lgY09efcji4eOhuGO3+WX
         x73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lnNj3DiLnlu+p8GcTPRPqgOe9OVQ2kWloiq+EmTAGTg=;
        b=XG5c4fN0he1eEnf56VLTHAMgOjZ7VEUEtyw3N+ljTysI9jh9o/1hDqKNy5d0McyKAr
         PWGgP8nh//efSnf3nqxJqBhiN4ixzID3KYhQgv/SAkLcL2BcbLZAKpHD+UIm8MNID/ld
         gfzDv9LyE/8fj6BE7n6JC8lnqw/Wvl3lK5/DI+GSlzf8rJhC6gwFUNYKTasknNjE26rO
         oSd2QcgYyTsA05viF7KcYeiLZwT/Nylp5o5FhIM/BRRMmVfh612HHHLn0eNVhfM/pgRj
         Ox3usOoA48Xk3MMDBr3WNq+bjQMIZ3MIjPc8oY4BVwvUdZ5G7lUYW98YDh/q5V7yUDjx
         w3LA==
X-Gm-Message-State: APt69E1AGu0PUHs0z64BRtpNc84N74fv8kVJaAhqSUF7f8xMb3dqPuRF
        9TAnhLeQirrxiJ58SYCav0U=
X-Google-Smtp-Source: AAOMgpftMpghyBx3H58aRLahtRhQMcm3HtG0uGoKU4Md6Z7gFKO2RCQd5EcnUrHLWZBKcZ3zllF6oQ==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr7739459wmf.146.1530904464034;
        Fri, 06 Jul 2018 12:14:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e128-v6sm14946544wma.46.2018.07.06.12.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:14:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     =?utf-8?Q?Rapha=C3=ABl?= Hertzog <hertzog@debian.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] l10n: fr: fix a message seen in git bisect
References: <20180704154357.26964-1-hertzog@debian.org>
        <20180704154357.26964-2-hertzog@debian.org>
        <e5233798-eefc-5c8d-937b-659726ab2a6a@free.fr>
Date:   Fri, 06 Jul 2018 12:14:22 -0700
In-Reply-To: <e5233798-eefc-5c8d-937b-659726ab2a6a@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Wed, 4 Jul 2018 17:45:52 +0200")
Message-ID: <xmqqd0w0kwhd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> OK, Will queue this patch for next round of translation

Thanks for an Ack.
