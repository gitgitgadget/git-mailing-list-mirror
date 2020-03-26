Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4218C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 16:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A79A2076A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 16:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCZQGs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 26 Mar 2020 12:06:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZQGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 12:06:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so8488211wrs.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwuDMJWWkKSDLVnmUl6yNdKti530DAzrQ0bD2WV24XQ=;
        b=A5MMgeD4Pa3fDbRLO9dBjgpMIei6z066qC3r93BVdVRjFgjhjHxC5Uga9DpaGsrP+e
         9i+2v787ozrey/JORKx3x0DM993kn2OqzEoQjVhisKGJ8zvdZUYAOKA49A8HzfCMq10A
         bSpgKwUdW+Dmc3LFHphWWGCsAGimgNRFqU5ZxyN1H9ZLDA7vUk1Z1d+13dq6696yTJEb
         xh+XsADG+n8a14oWsqBP55hstJy9xgjWfWotUCS/t8vFJpZh5VYLjf9wo2fPhP8pqK6i
         cuoZ5bDQZkpVVc0TCOgNhWqxH85SuB3uQUl9SIO+be7c9dakygowjKO5qiybd3U2nrM5
         cNaw==
X-Gm-Message-State: ANhLgQ1mQQ4oiBGHNEmrjcN7v/xjDwtHovkAkmuXF9Pm1teLCCqDR22M
        gZRTksZbJ0PvceGJkJfWwlrfKf8kVpXlD3j6LC0i0SVE
X-Google-Smtp-Source: ADFU+vu9q1GP18cnClSHVA8V7+TnpRbhcxleg5c+I44e+uhhBz1Oj5yftUP10gE/nWIuyXHhHws/sZOfJhBTTCKxDMQ=
X-Received: by 2002:adf:82b0:: with SMTP id 45mr9974571wrc.120.1585238806916;
 Thu, 26 Mar 2020 09:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585203294.git.congdanhqx@gmail.com> <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
In-Reply-To: <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Mar 2020 12:06:35 -0400
Message-ID: <CAPig+cTajaEU6wFK9wVS77ppeqpwqM95XLMeYRCHUORjBFa3Cg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: refactor docker runner script
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 3:35 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> We will support alpine check in docker later in this serie.

s/serie/series/

> While we're at it, tell people to run as root in podman.
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
