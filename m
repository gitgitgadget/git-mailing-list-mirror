Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66A31F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfJIPNT (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 11:13:19 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37227 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIPNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 11:13:18 -0400
Received: by mail-wr1-f51.google.com with SMTP id p14so3502215wro.4
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZid4oY/BzleYz7Mnq5PClLUIgKOfJCgUPvg2CI0aVM=;
        b=gX4YfknJS5lKdsRmr9fd8mxR5BIdF33IY/zYX+T+BBte7sL8jIEtndewfoNoz9mvet
         gcczFRO/kmNcesFOP2KODobKoPH5VxHarKHUOrme1csURnqcoTWuPgxYiLajDN3n5QMO
         15y3N9Q/vzGQkbKTTG0DnbSn9QETtnCvnVErLemD7yZ7IsGeJdfup4/7ndpi1X1i1+oE
         +xervL7onJ2LohU7U/XzDKYsjMLbir848p2ncAFWN4+iq9ZSn9flBrOc5/uR8cuPaapX
         I4LW6m5FFnd/4aAitPxlElCMPjXNZjSoHqzNfxMH+617qw8zowLYpuBJJu88bVCJZUrQ
         tZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zZid4oY/BzleYz7Mnq5PClLUIgKOfJCgUPvg2CI0aVM=;
        b=USXwwRiCh4bS1hs195FnpaR8dSb0X1xfmHMOJyGa4JCxjaRa3i+l9f89yPdvSctV3M
         Idt8KjEx4LF5faDdCJDSyr5VZ3rQ+5v1+jeJ0Jv29PVJGtQzd/JS4IXR2n1bDgJcNJwf
         7RKfjg4QiAZbC1eKgR6Mx6TrbJasaL8MnEYIms8W27P5AOVhW2Ixt//Lqx752JGwqPib
         8g3eAfZD+7Qkh9D0M7LBV61venB6Pl2CWr9JdMDz6bWDqT6tGagiePDqzo4siwe6JAL5
         o9i4GIXIki2xZmjcA525Syx8byUzM7uH9zPG5PQX+8/YJYtymlPy/FGTXeueAd2+kT1t
         tNwQ==
X-Gm-Message-State: APjAAAVYXql4dTicw6HkWC+j5HZYacfTTmyq1k0KChSwqAH4cUYpkT/f
        +lPEqQrTBr1LninjUAvQwIU=
X-Google-Smtp-Source: APXvYqwBqrcEx+i1oQQ9DAfeVoaFY5nvUx11proXiFM37X8WXdzFYW9KOn7Df6SxVTVhK8vA5EewHg==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr3328294wro.65.1570633996289;
        Wed, 09 Oct 2019 08:13:16 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id o22sm6572983wra.96.2019.10.09.08.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:13:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <df65a710-c92d-f3da-cf4a-0474a7153089@gmail.com>
Date:   Wed, 9 Oct 2019 16:13:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 09/10/2019 01:14, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> In other words, the commit message can be augmented by this:
>>
>> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Acked-by: Derrick Stolee <stolee@gmail.com>
>> Acked-by: Garima Singh <garimasigit@gmail.com>
>> Acked-by: Jonathan Tan <jonathantanmy@google.com>
>> Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
>> Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Acked-by: Elijah Newren <newren@gmail.com>
>>
>> Junio, would you mind picking it up, please?
> 
> I trust you enough that I won't go back to the cited messages to
> double check that these acks are real, but I'd still wait for a few
> days for people who expressed their Acks but your scan missed, or
> those who wanted to give their Acks but forgot to do so, to raise
> their hands on this thread.

I forgot to add

Acked-by: Phillip Wood <phillip.wood@dunelm.org.uk>

to my original reply in this thread, could you add it please

Thanks

Phillip
> Thanks for starting the concluding move on this topic.
> 
> For reference, here is the CoC the patch wants to add (there is no
> such topic yet locally, nor a single patch that can be made into
> such a topic, so there isn't exactly something people can Ack on
> yet. So here is a "preview" of what we would see once such a series
> lands).
> 
>   CODE_OF_CONDUCT.md | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> # Git Code of Conduct
> 
> This code of conduct outlines our expectations for participants within
> the Git community, as well as steps for reporting unacceptable behavior.
> We are committed to providing a welcoming and inspiring community for
> all and expect our code of conduct to be honored. Anyone who violates
> this code of conduct may be banned from the community.
> 
> ## Our Pledge
> 
> In the interest of fostering an open and welcoming environment, we as
> contributors and maintainers pledge to make participation in our project and
> our community a harassment-free experience for everyone, regardless of age,
> body size, disability, ethnicity, sex characteristics, gender identity and
> expression, level of experience, education, socio-economic status,
> nationality, personal appearance, race, religion, or sexual identity and
> orientation.
> 
> ## Our Standards
> 
> Examples of behavior that contributes to creating a positive environment
> include:
> 
> * Using welcoming and inclusive language
> * Being respectful of differing viewpoints and experiences
> * Gracefully accepting constructive criticism
> * Focusing on what is best for the community
> * Showing empathy towards other community members
> 
> Examples of unacceptable behavior by participants include:
> 
> * The use of sexualized language or imagery and unwelcome sexual attention or
>    advances
> * Trolling, insulting/derogatory comments, and personal or political attacks
> * Public or private harassment
> * Publishing others' private information, such as a physical or electronic
>    address, without explicit permission
> * Other conduct which could reasonably be considered inappropriate in a
>    professional setting
> 
> ## Our Responsibilities
> 
> Project maintainers are responsible for clarifying the standards of acceptable
> behavior and are expected to take appropriate and fair corrective action in
> response to any instances of unacceptable behavior.
> 
> Project maintainers have the right and responsibility to remove, edit, or
> reject comments, commits, code, wiki edits, issues, and other contributions
> that are not aligned to this Code of Conduct, or to ban temporarily or
> permanently any contributor for other behaviors that they deem inappropriate,
> threatening, offensive, or harmful.
> 
> ## Scope
> 
> This Code of Conduct applies within all project spaces, and it also applies
> when an individual is representing the project or its community in public
> spaces. Examples of representing a project or community include using an
> official project e-mail address, posting via an official social media account,
> or acting as an appointed representative at an online or offline event.
> Representation of a project may be further defined and clarified by project
> maintainers.
> 
> ## Enforcement
> 
> Instances of abusive, harassing, or otherwise unacceptable behavior may be
> reported by contacting the project team at git@sfconservancy.org. All
> complaints will be reviewed and investigated and will result in a response
> that is deemed necessary and appropriate to the circumstances. The project
> team is obligated to maintain confidentiality with regard to the reporter of
> an incident. Further details of specific enforcement policies may be posted
> separately.
> 
> Project maintainers who do not follow or enforce the Code of Conduct in good
> faith may face temporary or permanent repercussions as determined by other
> members of the project's leadership.
> 
> The project leadership team can be contacted by email as a whole at
> git@sfconservancy.org, or individually:
> 
>    - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>    - Christian Couder <christian.couder@gmail.com>
>    - Jeff King <peff@peff.net>
>    - Junio C Hamano <gitster@pobox.com>
> 
> ## Attribution
> 
> This Code of Conduct is adapted from the [Contributor Covenant][homepage],
> version 1.4, available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> 
> [homepage]: https://www.contributor-covenant.org
> 
> For answers to common questions about this code of conduct, see
> https://www.contributor-covenant.org/faq
> 
