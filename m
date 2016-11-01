Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6E620229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbcKAUna (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:43:30 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34675 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbcKAUn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:43:29 -0400
Received: by mail-qt0-f178.google.com with SMTP id n6so66740443qtd.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DSCiBeb6REMyUVWG46R/d8QGA7SjrTSF9oTl9kK/0ME=;
        b=N4lV6lV8OmKUbdxtFqvgEMLJQOgK7QlsjMDyO0BdXZRJX7JYlwQXNw4JZ1Y2+AK0Ef
         3dMI0wbFV9aD+qELQQ9m8BK4/FDOyJZievZHOzlR5anJySa+2umO14wxx4YA8HoR+COy
         EK7XVvN0TY087GjB4BsepcrA5LjdLuXNo2RG/lKoEkVhHe0wgCA9EoAOH4zxwxhHfyE0
         MBZvb2HJPMCWeG5FzIyC+nwxUJ1mikdyThwUCkD+zP6tWElrY+0HOOJJYoT+k0wu8Fnc
         zSiEq4DImz558luENJEF6w0r3qtM+etcV0h1U2w9wMkNGYFMvOLI2z9XSYaqlAHTJ8m6
         4rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DSCiBeb6REMyUVWG46R/d8QGA7SjrTSF9oTl9kK/0ME=;
        b=W4hfFSeywmHjgBozNYbG51yKfMwD2MnwuQ/nCDImaR0JRPuTg2FhakKZkhZ5bjK1DC
         9ejhp7RVAs7avyjE4aWQnOh8Uzuga2QeMW+//uJlUnhxRrvwV3XDww7Eb3JyWLjGIgcv
         H0Vk9Sy/Vs4jG9zFlAmz/nngH0bBlHxUD44qme4Gn3lv87kKpRF76/dHQFJxVoM3g3Ui
         jtOiFltpcA9uIvu2eDH8CfwLyxR8Ru1ojbAKHEQ1o6Ii06nVMimhGGYXRGV7Jad3Fqf7
         29oG0x03xgXUvsuTTsCDSGPYGMtSFBkwOCguVzAtcjFnhEI9MacNdm63ZUc3h6/Y0h5k
         BeTg==
X-Gm-Message-State: ABUngvddQ1MKMBBVKevYZHcPlj9DpUAPgX6WLzvfGL+XnDWNKxuw3I0B1stWu2jZWMgT7QKDI/8cCn2TFjrqOTzE
X-Received: by 10.200.34.6 with SMTP id o6mr33091354qto.88.1478033008322; Tue,
 01 Nov 2016 13:43:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 13:43:27 -0700 (PDT)
In-Reply-To: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 13:43:27 -0700
Message-ID: <CAGZ79ka2ddH0WDUyWfKhg4mULY-VwYFvZ11E5pQX6tXUqBeUGA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  * "git clone --resurse-submodules --reference $path $URL" is a way to

"recurse"
