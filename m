Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140251F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 23:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbeKNJof (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 04:44:35 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46278 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbeKNJoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 04:44:34 -0500
Received: by mail-pl1-f169.google.com with SMTP id t13so3835320ply.13
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7MumKRCDLOpHmOkXWhOO1FTu/r2pQZ3r6K3ogMZF0SY=;
        b=JgPxJUJGO0Hqipj0e7NuHhwoj+4i6KSp1xMJIsBaZfUKsj/1S+OCKCKIx7RVAfGge/
         lfCn3dM036jclAsWPh58TdIRY4i3h6rYzqGG/qRjdcDYep8avPEIUor55gPxqb8PVfnc
         DcN5+E77G7aKyMZI3lqpyJE36PcAYl4mmaYmCvmPHbIAVPgtcft6nS3lzgdb1AoWnnAp
         6WeprBMjq09VuNTPutkMgEp7H280BE61IhHBbz/2OA/3ebJi949oz6HHgQnftHwQpsf1
         rO1fgxEjTiDqCdXyodSpbossoJZ6fOIIAdWb/T9PfRoB/k3EG0PW2Gsz9jZd7BEX+M6v
         qazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7MumKRCDLOpHmOkXWhOO1FTu/r2pQZ3r6K3ogMZF0SY=;
        b=swGx/tecM/sz1gPXNl1AIVAzGg8QuNWZOqRvGHcxBva+YPe7ck1Am66/S5X4D8X0sk
         TbHjsICITh7W4Xs07E/Js2pmKqX6BG8X8klrvgMfF9NI0a7e/uRO5aaeq6ZH5H2xpr6y
         1/AXELUn6sSW7r2qERjY77gdlR8Z8Qvs3hQryjG3Nc4ViJheILxLp3FrVXSxF/fiX8ZR
         HMC+5XAOv8vR8fvplXyQmln8eMPAaeIVAPhrNHlvY6GfGKRO86fnenKN7T6gePgeNq5Y
         RMU2cpmArsE+WYLs3KP23dEfINbf0we6e+heFQAHLacydHKPTFkqgNpEzPAzQ7JwRijX
         SSVg==
X-Gm-Message-State: AGRZ1gKfHotVRUwUTNA+7+49seog1jswh6sGegmWm4fEZdJyfRFHSehk
        OgBAzOd0SOThcl3AtluBEAE=
X-Google-Smtp-Source: AJdET5dgiKs5tDcu9FYNWxrjmVMpJMtMJzSNrUiZd93MpoNvIR0qk+PXPgON8qXMKOqzcZ7A/UHleA==
X-Received: by 2002:a17:902:703:: with SMTP id 3-v6mr7239900pli.38.1542152636792;
        Tue, 13 Nov 2018 15:43:56 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id y88-v6sm27350463pfd.104.2018.11.13.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 15:43:56 -0800 (PST)
Date:   Tue, 13 Nov 2018 15:43:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Paul J Sanchez <pjs@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: git-scm.com GUI client links
Message-ID: <20181113234354.GD226088@google.com>
References: <784B3DBC-BE5B-4E7A-A94F-80E5E135195B@alum.mit.edu>
 <CAGZ79kZgO=71Ue1f+d2ZagL=9G-ZZ63y7jA-PFULaJCbK+15ow@mail.gmail.com>
 <8D300E52-77C8-462C-BCF2-E1E3BBE261D9@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8D300E52-77C8-462C-BCF2-E1E3BBE261D9@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git@vger.kernel.org, git-security@googlegroups.com -> bcc
Paul J Sanchez wrote:
> On Nov 13, 2018, at 2:25 PM, Stefan Beller <sbeller@google.com> wrote:

>> The link seems to be https://aurees.com/ ?
>>
>> They seem to have
>> https://aurees.com/legal/license-agreement
>> which is a hilarious read:
>>
>> You agree that each and every e-mail address, which You use during
>> registration or to commit changes into a Git repository, is
>> automatically sent to and stored by Nezaboodka for verification
>> purposes;
>> You agree with Nezaboodka's and their partners' advertising to be
>> shown by the Software and to be sent to Your registration e-mail;
>> You may neither disable nor block automatic updates of the Software;
>> You may neither disable nor block sending of anonymous usage
>> statistics to Nezaboodka;
>> You may download, install and any number of copies of the Software
>> registered under Free License;
>>
>> Further:
>>   The Agreement is a public agreement (offer) as defined by the law
>> of Republic of Belarus (article 396 of Civil Code of Republic of
>> Belarus). This Agreement is governed by the laws of Republic of
>> Belarus
>>
>> ... I did not know English is an official language in Belarus.
>
> I saw the link on git-scm.com.com.  You’re correct, the site is
> https://aurees.com.com/>.
>
> And no, I hadn’t yet gotten as far as the license-agreement.  Egad!
> Total show-stopper.
>
> After seeing the licensing terms, I’d agree with Sophos.  Software
> which harvests my e-mail addresses and usage data and has
> autoupdates which cannot be disabled or blocked qualifies as malware
> in my opinion.
