Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CFE1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcFYQnU (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:43:20 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36730 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcFYQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:43:20 -0400
Received: by mail-io0-f175.google.com with SMTP id s63so118698161ioi.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 09:43:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3BmCxIntyKctg6zpup2H4cY4CKIi+jAzr+qNIuu10KQ=;
        b=qu7LGnUPdWFIE16e6DzfCO+MvgEJrwADeLw1J2kYyfcb8EUtbLT/MPr8xLXYzE0aSE
         qrdt8P5zFMMUEmiFCJXsUApnKOSD01uEr+ix50DNR9+AQiiQlt2dIfv6fuXKup8Lp7RG
         A7TebpUkvihz/IxlwP49+j4IeXj56uVtB9pM6wcP8zJakp3AQFBUvzsVtfbQksXYuCnY
         lY2ABxNkRizlenhfZhuBYzy9tgEQS8mYReyHBgDdh4B2iJIkZnvkjqrbqU1fbLP8GZnB
         6S2InvyC06/Dtatkw7UGDFq2Ukyr8kNQZrIQNmwLKQhFvOYEciIB9rPYAK4VUb4mYMhR
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3BmCxIntyKctg6zpup2H4cY4CKIi+jAzr+qNIuu10KQ=;
        b=iv1WMF3sRdtWrIUKoWpbK2N9GXRe7nxIyR0loSijX+PVb4LWB/avR+bx3P55+gomkv
         4Tv9OTQEWy9Do9ikw/9u1lnjVs3UTD7xgwFM+jWxpGMOzHMsScvFMBxbqB9HeSYP/B7w
         CzefT7zfbWhlQqGauhgc9/eDU2xcHevx/iJL0KIvTNzPL7sA1bhNeTc4CTQxqT9qxjIt
         PWOqi4nTpY3p+pLy2bd6r5izfJvCjP4ueS63Fhdjwb1eZnDPBI139U33EqJDfnvm3eTf
         7WFkK5k51InVNCVZKHFlEfAPUioeff2PnqghBUBcurwRkIG2igCTysrTzIqJstfJ4NQn
         ah2w==
X-Gm-Message-State: ALyK8tKWvapSGMT3S+kEKelULyxGVDUwVJ4F/o08J85vPqOw9FGbWCokRGcgLatt0VgWorTLwfsqoFk8bWD5mQ==
X-Received: by 10.107.159.16 with SMTP id i16mr9647275ioe.29.1466872998179;
 Sat, 25 Jun 2016 09:43:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 09:42:48 -0700 (PDT)
In-Reply-To: <CACsJy8CKxzpphPB4iST_QzP1BqxYZuPKftyvsovwphysXzGa3A@mail.gmail.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <CACsJy8CKxzpphPB4iST_QzP1BqxYZuPKftyvsovwphysXzGa3A@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 18:42:48 +0200
Message-ID: <CACsJy8Dmr8QSSMycetPH2WNECc0A=cOzG6o+jffT4RSWwVC+Vw@mail.gmail.com>
Subject: Re: [PATCH v12 00/20] index-helper/watchman
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 3:28 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
>> Of course, as soon as I pinged on the previous version, I noticed an issue.
>> ...
>
> A bit off-topic, but you may want to cut a release for libwatchman
> (even 0.1.0 would do) so it can be properly packaged.

And I'm done with v12! I think most of my comments are minor thing
except the "really || cache_errno == EINVAL" change (which I still
don't see how it's related to watchman).
-- 
Duy
