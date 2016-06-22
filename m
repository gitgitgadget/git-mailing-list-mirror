Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D127920189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcFVTCo (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:02:44 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35178 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcFVTCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:02:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id v77so7556874ywg.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:02:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xIp05wZF+XBabH9wolaYHuj1pxrvR3gtV2EytVKcleo=;
        b=Rz5bszrdNYuUeq9229al6GB3fr3Ml87CfUPd0XpUq6Bv50pH+8dbaCn0IgqTYnwzfQ
         OzfPDjbzG5Q1gG6JaWbDs5sxFqeiPTOQrqqSdBAPa/80ZUrMhy2ksiAjt2qdw2haVCN3
         Xl2pSjIyxy0EGcHNpt7eGHond2To+N+48/uvM6/+l9XVPayIdy+6gJ/QZc9N/foPufGB
         k47rYxyArXy+PqenRLrn5Pwkg2Rh9zt0Ay2Goi5RjhR5XuJKuzzZcdsBE2z7wW2g4PF4
         B/700UOX8RVN6ylbiWH2elXt/wcspYSx7e0CUD7llF5j/eQBJMZbwWP4fyp1+tZbWnkI
         G2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xIp05wZF+XBabH9wolaYHuj1pxrvR3gtV2EytVKcleo=;
        b=XRF5zlyqTqVzWPuCDS+GU6iw345O9p/XeNVwZAF8w4aOn0hpIpL0APFugCLI8Uwqwt
         sZwnm16B+SRWBbCSmideou89XE+jXRIQ3egmXsbCmmu0DS6xyrXwCvZuwlAaGHD3WYpm
         90YYd+Zhoa1Y+M/CrIqKWyhd5++qFz1HusWwsw8tignxLZYkq1q9+nC8ouoe1N0Jd2MH
         U3D1i3vuBNXNb78s2nx3rfva80pIRSad88Cwl32ye8VRUB9uQ7Jxx3qAxeHfYdOI026r
         1wHpkx1cMP60IcwS0NwQaB6j8uwZX8q2uV/pO9zBqcCCuBXjWSHOPT5sBhKOcrWSt0xK
         KepQ==
X-Gm-Message-State: ALyK8tItAXyn4QfpjZIX2PhNh9tqVxzOxKxDtvgw5R8DlG4d3aPcWXadB5lUMhJBMYyuJyWXjk7Qgjm/K3yIgg==
X-Received: by 10.37.11.199 with SMTP id 190mr15880625ybl.151.1466622158191;
 Wed, 22 Jun 2016 12:02:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 22 Jun 2016 12:02:18 -0700 (PDT)
In-Reply-To: <20160622190018.GA786@dcvr.yhbt.net>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
 <20160622024151.GA20206@google.com> <20160622190018.GA786@dcvr.yhbt.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 22 Jun 2016 12:02:18 -0700
X-Google-Sender-Auth: ZbkDsjBX9qUnKsxnXDJav6Oh5uY
Message-ID: <CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
To:	Eric Wong <e@80x24.org>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 12:00 PM, Eric Wong <e@80x24.org> wrote:
>
> Just wondering, who updates
> https://kernel.org/pub/software/scm/git/docs/
> and why hasn't it been updated in a while?
> (currently it says Last updated 2015-06-06 at the bottom)

Nobody. It is too cumbersome to use their upload tool to update many
files (it is geared towards updating a handful of tarballs at a time).
