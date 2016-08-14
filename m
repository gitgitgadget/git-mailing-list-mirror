Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA3B1F859
	for <e@80x24.org>; Sun, 14 Aug 2016 08:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbcHNIwN (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 04:52:13 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33034 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbcHNIv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 04:51:58 -0400
Received: by mail-yw0-f171.google.com with SMTP id r9so13694734ywg.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 01:51:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qEXtpE7P+Lg/v3BdQDJhxvSHKnkF4xMGgzzKxsO7H7s=;
        b=Np8Atn1xYSts1DESBlVrkCU5YaFNN9iXc76BT96jroA+n2aUj4JrsO8WSYppOxlZJd
         GZOn1LBB0GYRBu1qLYwsR4LSrQpfpI1VyF0y/ss7NkRhfuwdeAdCxdsEw/8ztDJi5iDA
         3E9AvsW7XMB9Mn7fIWqezR7YW+q3cN2Df4UEpMQH/QqfagSsY+hK4Pmltn1xzJ3aNa+F
         iP46PW0wRA0AcFuhWKlO4hlY3H85fir69mZcoCxxSJ6JfNOFQlE7w4O7AwmD/9NFVQTL
         rF3LkAzu3bbyRJAYTqHnqnsr+vZ8OY1z7XggjItfADNjrI3H7h+0KA1yE/1pMlPtRMRE
         IUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qEXtpE7P+Lg/v3BdQDJhxvSHKnkF4xMGgzzKxsO7H7s=;
        b=A7bIhORH9W/cPb4zdFTTb0Ms4W0RtXNv+fjTj6dvv01fOfxkZ7FWDPKPa+AAgVnC5V
         GfGdg7vm8EmYeT2I7FJYJPCd0UBHRh61UJOmENB/AaAzzMmEQwASHRniAJi2/XF2fzFd
         ji8Eh+DdPk5752PMT50m5/dd3JCpCHIJm5ydXa9v7gF+FGfVQUoSZQpMmFXLYD7O+2iO
         SQhZnvbH6/hrD8NBcKNFTPaW7TBF1JS7mCRaddMjgDj/CkubvIF2HeQh2cpApvTAdMxN
         uwucj9sUgW9Ct4bpC2WyUZYrUvIY8/JNWEnm89vdXc9uzpHL1zu+BvURYvdAPkl+6CnW
         NQEg==
X-Gm-Message-State: AEkoouv83BDJRUv5MXOIHdM3Zgs0po0mQUBeP4mOE1djM2tgPja19zCjE6bEGDxDvBE6YFjBYAd9jKm8rqh9GA==
X-Received: by 10.129.168.9 with SMTP id f9mr1926095ywh.258.1471158972157;
 Sun, 14 Aug 2016 00:16:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Sun, 14 Aug 2016 00:15:51 -0700 (PDT)
In-Reply-To: <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com> <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Sun, 14 Aug 2016 00:15:51 -0700
Message-ID: <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 1:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Aug 9, 2016 at 12:27 AM, Stefan Beller <sbeller@google.com> wrote:
>> is what you want. Maybe we want to see a patch that adds the reverse
>> functionality as well, i.e. git-am will store the the cover letter as the
>> branch description and git-merge will propose the branch description for
>> the merge commit.
>
> I almost suggested the same, but there is a problem with this
> approach: if you're are on a detached head, where does git-am save it?
> --
> Duy

Also, what about the case where a branch already has a description
such as is the case for something other than an integration branch.
How does git-am know the difference and ensure it doesn't overwrite
anything? Not everyone uses separate branches for each patch and such.

Thanks,
Jake
