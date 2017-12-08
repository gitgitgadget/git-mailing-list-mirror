Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB1A1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbdLHVTa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:19:30 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35334 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdLHVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:19:26 -0500
Received: by mail-qk0-f196.google.com with SMTP id c13so535125qke.2
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RgbnIS9AKrRaPFQYJtarv1kU/7Xst0Oqsl7PZWP/nEM=;
        b=Wn4fiPnnsiZp6/rdPKoKj76eag8j6VVU7QOwX0QVHdN4JkmTOM8FT6kD+rstmsEK6K
         spCBPikyHSLl9rClWF+4jhhVY0KfmvaevQZXC6vbUiAuyM9i+6q8mrIlR4IparjTyV1E
         LMvZrINStkYvf4c2g5VcjOsimZNlC4C07up9/aDOt/i/krUwwbpBg2XxXp5dcVphu2bE
         CmJVN0DJiFbeJ+6Y3qAk2GEXbK1bBSjgx6szc85tg435x4GFrz3o3HGalOcviZmq37yY
         C3tD1htL5lFwhrctR81jOnL1j53jqMSOLV4hybI0v7qpshJTsLZj7H6A7dfyiH/QSDSd
         Y8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RgbnIS9AKrRaPFQYJtarv1kU/7Xst0Oqsl7PZWP/nEM=;
        b=Yk4pVf6GOeM3+eGVoC99L6XQ2fruUBh5ZG8DSwlY5nOxxytNRTGt8rbrJRI7STK5iq
         UlRR9Fo8Y8u1tDunbvRKfY1onliXUdNrjfCZS0W5AOVTZdxocdDJ5VT5WEup/GPdUflJ
         KagervXtJ0+WoH8I8b0wYwOsZ8+JM904CKuigXhL/BxqQi6LTrVD2qdq+l95Q9cjJKQx
         Q1GKEktQ7Yj3FEphzlQIZqd/XIetELy3isDKoF/9OOxyBY4ixbzhaojpedoWvkthbwAK
         3sm++8Z+K1PIK1mZOfbISyril721CHG9QWR9QMEOvAggf6blCo3QmMdnmV7uHYj9MDpz
         VTkA==
X-Gm-Message-State: AKGB3mI2etMB+Djbg8jIfLLs+DNXu466iD8QBNyU6J9utDyDS4exImrw
        msO7DdiLZiYS+beqBATfTshF0fiWfwCHtFYfSXE=
X-Google-Smtp-Source: AGs4zMbOa7mc3H29167sNu5PjgXAXosMTIBjeVp9yBhjCEKXO5LN3na2DwdsWRZtiI0sYNKnuItNfHc3f/pFlOdfD0U=
X-Received: by 10.55.42.75 with SMTP id q72mr37966660qkh.57.1512767965753;
 Fri, 08 Dec 2017 13:19:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 13:19:25 -0800 (PST)
In-Reply-To: <CAPig+cRrVRJ+H7c5Q3zLj6gjPegLFQmngGtiezgxTBTDqWSj0g@mail.gmail.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
 <20171208172324.GB14261@aiede.mtv.corp.google.com> <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRrVRJ+H7c5Q3zLj6gjPegLFQmngGtiezgxTBTDqWSj0g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 16:19:25 -0500
X-Google-Sender-Auth: 1INjX5pXhvHzwMEx2J3PtuRk_fY
Message-ID: <CAPig+cTq1LgRK_jXgLn+VY_qtDAJ27Ja-Uf-NwdG2g=tv9c=Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build
 platform, too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Adric Norris <landstander668@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 4:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Dec 8, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>> @@ -413,6 +414,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>>>>
>>>>      if (build_options) {
>>>>              printf("sizeof-long: %d\n", (int)sizeof(long));
>>>> +            printf("machine: %s\n", build_platform);
>>>
>>> Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
>>> of a mutable static string?  That is, something like
>>>
>>>               printf("machine: %s\n", GIT_BUILD_PLATFORM);
>>
>> Good point.  And if this is externally identified as "machine",
>> probably the macro should also use the same word, not "platform".
>> We can go either way, as long as we are consistent, though.
>
> In Autoconf parlance, this would be called "host architecture" (GIT_HOST_ARCH).

My bad: "host cpu", rather (GIT_HOST_CPU).
