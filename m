Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_DNOT,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1AA5202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbdKWVmA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 16:42:00 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34267 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdKWVl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 16:41:59 -0500
Received: by mail-wr0-f181.google.com with SMTP id k18so13722684wre.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rZ+2bBXK/fuC93++QzatpFFJkzyqRswwnsbx5Ri4qyM=;
        b=b+REW+dnzn49qZMPTYGBFa96zz77/ExoxKMWRenRROvecOjJdb/4yHZkLqFkweOuZ9
         v3c99TQphSSdkVJISL8Xnredq/5nB5J713Jav6cNGhzEUc0/JVKmN6fUpWiEXvQ4nMCh
         +ytQGepHSPxojFcdESwAwbP+GLd2nEMJ54+Uu2hHYH6GZ5r8USj0HpLjujwu+WdK9GfO
         I0K/vZYXJLm9/HAjcGyZOOaznn9p0SuFHYOhhe32It3ueTTXpN/iZ4ibRyTN+GN2fV50
         wodzuhvibOvmsuc+xnpwn0vzj8RbxCVxiJbTb30q0/1kUEiivZqLhC79jLQwccUzFX7I
         eb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZ+2bBXK/fuC93++QzatpFFJkzyqRswwnsbx5Ri4qyM=;
        b=QwESjjDkS85XUT1YdxFcd1AjpKdEIr+Ry15WikJvz0FfZLwpkB2bTpEJNdIRBR+V8M
         QTwmm3jHn9192GmzlirsYofOMu+r95K5xXnGxvlHKTiIn8+AIC+9PY5UjEH7I9jajXRP
         HpvQbFfqbHZlMd/5RV+9eFt1Z2Z0rXKa/uQ3Q7bFPNieSq+FsvBEeEdfgnvlx04miZ2m
         aednKt7QrmIQ/2IuJm4jSTZe8lbNEtggqVtO6SwgejEzk5uVvCLh3sy03CFg5qYV+FpB
         V0H9NHC6jwVXh/4xC6HPfgwBTrz1lvolu8Bpx2mbkVOSacGSny36sqij/nDhPrsN+LUP
         8SCA==
X-Gm-Message-State: AJaThX5zuUtFT+l0soQNB0Y//ep/cU+2XWIrZ1rPEIcNcE1NpMqTjv4k
        MlGRBqLY/um+GEELAZ1QEJPkE6Yt
X-Google-Smtp-Source: AGs4zMbMWWKrO8vfbrE1ioIup/ITHmjzVkHER7CeqG9uvy1BZuW+RglbVfSks7svFHhcCJ7IxjV0PA==
X-Received: by 10.223.149.5 with SMTP id 5mr21583410wrs.135.1511473318453;
        Thu, 23 Nov 2017 13:41:58 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id l140sm9168917wma.5.2017.11.23.13.41.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 13:41:57 -0800 (PST)
Subject: Re: Delivery Status Notification (Failure)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
 <001a1148fe243ade02055ead2599@google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <4a773661-efce-7be1-f6a7-2d09a95f63b1@gmail.com>
Date:   Thu, 23 Nov 2017 22:41:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <001a1148fe243ade02055ead2599@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/11/2017 22:30, Mail Delivery Subsystem wrote:
> Hello igor.d.djordjevic@gmail.com,
> 
> We're writing to let you know that the group you tried to contact (git-for-windows) may not exist, or you may not have permission to post messages to the group. A few more details on why you weren't able to post:
> 
>  * You might have spelled or formatted the group name incorrectly.
>  * The owner of the group may have removed this group.
>  * You may need to join the group before receiving permission to post.
>  * This group may not be open to posting.
> 
> If you have questions related to this or any other Google Group, visit the Help Center at https://groups.google.com/support/.
> 
> Thanks,
> 
> Google Groups

Well, seems that +Cc-ing wasn`t the most successful one... :P
