Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BA11F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbdAYWwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:52:11 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34736 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdAYWwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:52:10 -0500
Received: by mail-lf0-f47.google.com with SMTP id v186so136997540lfa.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yvwg0dcieZ5iRpPHQFYs1ZBVhmWkOzir1HxPi0R1maM=;
        b=iyBnuEDS3KjsNYB6tNzy/OKYsb5eRiBL9NjMK0oit2i1AoBe06qYvcAS0QJthGPj6G
         olABG+wTTGy3BWPKxL9j1wH9heh7/TAayITpZ4DVrITODvDkxrHcLEAGWrGFhxVdJKgY
         B6epmKQmyeTCPisRWnzU6Wu0twhZy/nK6jLJ8MoOJyf75o4JC7SNhzLCvj2nfb1fbnEe
         yF1B6gCy8yGvRmM+9wqDdMOJlat2hNojrU0a76fPUV3RYc+eRCRv9rUI+Tj+4NgARU7+
         RUzzv4b1Pmpvl9K8WNfr/T5C/u/PRLe24HDefJXKcHyukKC1jC7D0lcvV79a4CRWUmA4
         QSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yvwg0dcieZ5iRpPHQFYs1ZBVhmWkOzir1HxPi0R1maM=;
        b=qJ4ZOP2ylKwziSuona/WAONJKKLLH8H3HROVdKhS3bbJhrdKdtrdTOI5R+MjwnpMfE
         ycPT8W1rdacgXesrUIGsli4Wn/iP4RqMhQYM+OEsuCozhVT+Z1MDbPzbxiW0NqPx8KCT
         xafHf/NHJ5jv/Vfw1jklh1YEsAXpljOyMAksc+sfuuqrUhn/ZR2oQyHkb0XVCdwkTVk4
         Xmj2wGeqG2PMTJEAvDQa70PEJ6aYMyZw2b+AIGxnGiMO3VgYUBBQmeboVaWV/x8mm+oR
         9SiDb91LduCdMW8gHehElVWJarEiepAMzBpCYMl198HCUwnhYO6WKkq8uh6kQ/H2WxjG
         oWjw==
X-Gm-Message-State: AIkVDXIsvqc0m5Y5xwUswT2yxpQaeNlBc59/khsP6jTFJk0ypvDstWnQQF9bs4OkR9d0NtJqVIwx9d/2+P2VfQ==
X-Received: by 10.46.33.75 with SMTP id h72mr16931797ljh.37.1485384728888;
 Wed, 25 Jan 2017 14:52:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Wed, 25 Jan 2017 14:51:48 -0800 (PST)
In-Reply-To: <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Wed, 25 Jan 2017 14:51:48 -0800
Message-ID: <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 January 2017 at 14:24, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Jan 25, 2017 at 2:16 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> How can I force Git to not assume my change to the first line is "redundant"?
>>
>
> My guess is that you probably want a custom merge driver for your file
> types. That's where I would look initially.

Mmm, that sounds complex. The "my-code.x" is made up so I could keep
my example as simple as possible. In reality, it's Maven's POM files
(pom.xml).

So there is no setting for any of this? There is no way to switch off
auto merging for certain files?
