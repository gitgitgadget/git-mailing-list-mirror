Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96291F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeGXXvk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:51:40 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45884 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbeGXXvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:51:40 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so2272957ybg.12
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKRFF4HCf1a8AhDCTn9ZvoHOqTsQ/jFDvuc9fVwZAY0=;
        b=ImfI7OaRnpdtBRNX+JpYEpBgwQgcKrOMX4sh/n71LUcJo7crPh7arT1A7Xoi4tJRIl
         muaYKg2Qm1iT23ebPuIGDsBVwWwSFCQqTMX3d3p/Nv3c6ohZxTQRMviV80Cwa9jV9u01
         m5TzIeE42T0cN32n9Qua0VkUOSyp3Ehq48UP+nmsJpE440XTTAbcYvPLqy/TQIXK1Fse
         qkCdnafx85wl4s2k2vV+AZMMHxd8GKJvYzSbGLVxAK2E0JMGvxTpwbeG6dSwaz+JMkeN
         s6jJpV82kayctrofocnRQbuDQDXzvWwK36f2+W8RUyaREHOk9iPFvIbXYmhWQz0Ypr8e
         Wlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKRFF4HCf1a8AhDCTn9ZvoHOqTsQ/jFDvuc9fVwZAY0=;
        b=AmGqnkbykNDzQrjspCqPmsUkk1+qGJs2oqcLsRay/u0m8yxhlEMEpgQdi1wpQYmN88
         bthkD1sDwerA+NPBsoHssrCEq+YfZR82olh1bwo3jDhc/DjXT9SFkFDJ1Dh5g2c9knb3
         kgwrSnkx403utHBYIsRQyKDlAq7m0ki3Lwypb9q+ZnUbPQWa/Gff1ptjrncIWWZ9/f+x
         /xI+3cGFfPXq9XS2QKcviCGY7JCs+DUVChvyPtm6z929zbOyWW1/idZR17gv/Kb+Heck
         woyigIAb4yLeIWcBXJP1r3j8fqN/hZeGwJsFvewvo7GJ8JxWkR2uHLbwW99Wj3Y99GcZ
         LIkg==
X-Gm-Message-State: AOUpUlEDLXx2gDjMZ4u0hJAlgDjWLrU8jsxr6LRJkbWHQIG30CKPzu/u
        gLgJkuj6vY1xT6pUsozit6R00Y3YRa5WCt+ivgeNDg==
X-Google-Smtp-Source: AAOMgpea5N7DNv/FzeNLzqnNHlav6dw1QtJFlvNg2VqeTD3Rarzj625CtxyJUja4oDgQFKsOMRPofry1/INQVOIUqyo=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr10341700ybp.352.1532472179104;
 Tue, 24 Jul 2018 15:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180724215845.7137-1-sunshine@sunshineco.com> <20180724220928.GE136514@aiede.svl.corp.google.com>
In-Reply-To: <20180724220928.GE136514@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jul 2018 15:42:48 -0700
Message-ID: <CAGZ79kbL2mHK9TzH6guRjJkzmaVSbMiPr5M47RPMtYzp782iFQ@mail.gmail.com>
Subject: Re: [PATCH] diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 3:09 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hm.  Looks like dimmed_zebra was introduced in v2.15.0-rc0~16^2~2
> (2017-06-30), so it has been around for a while (about a year).  But I
> would like to be able to simplify by getting rid of it.
>
> https://codesearch.debian.net/search?q=dimmed_zebra doesn't find any
> instances of it being used outside Git itself.
>
> https://twitter.com/kornelski/status/982247477020508162 (found with a
> web search) shows that some people may have it in configuration.

Thanks for the searches.

>
> I don't have any good ideas about deprecating more aggressively, and
> the patch looks good, so
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Same here. I wonder if we actually ever want to deprecate it further than
this patch, as the additional code to support it is only 2 lines.
So the effort to deprecate it (more than this patch) is more than
keeping the misnamed version around forever.

Thanks!
Stefan
