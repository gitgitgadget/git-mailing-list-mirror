Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A691F597
	for <e@80x24.org>; Sun,  5 Aug 2018 02:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeHEEWp (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 00:22:45 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34218 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeHEEWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 00:22:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id 13-v6so16472655ois.1
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JU9kEqiBDTOlwpW6Orw3OG1kvVNaIj6pzCesg/Nc2dY=;
        b=eFrkjwpL67nKwi/O+z58RmiqbFx25LOKgMDEmrbhodJiEqan29frkDFNOogL0lRX+H
         AVGAXR1ICPiUW6EiwP/NJicrSoO+900+Z5CN2+Sx5p7GWwQ4r+vMtf4ZxMC5QKK0JNOG
         Oek/Tn1kRrfuOQ0U6IlqwYMp9/PdQpd3qTr2fQk4b17tGEs2JFpwah5WGFZKSQPdvEnJ
         Uar7mnx9IbhKY7MamKndJDpYNrx/IOcPg3+MZfzxDRQN38Zr7oxksBEAAgL88Z5oOLEF
         n9K9XX0ICIpw6TOp8uh4EgqAgFvRbw4C/0lK268vBFAilQ1esqlwYdQihZUr9CPNFeGj
         xyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=JU9kEqiBDTOlwpW6Orw3OG1kvVNaIj6pzCesg/Nc2dY=;
        b=gb0wyhR09gTp+AWl7DTPpL6rNyaP5qC7LEGbER/xbvV/SyxJgQb5vXEjzG5/xGvoiM
         6iUjEE2mXEHABcRvEM1mM5n+xrWmKyki0FsAVTiVfUz5SuKJeBJ93cY81OHavXgsLTUW
         vDetODkJL+QhLTTVLFZ+g0ktl5ywDzLeZLGm9ayNBipdb+EuR9rq1/pzChOO632T9cAp
         QrJ+ZugTe90t1u29o4CY7RWQK9ijWL2oFfAH5NL7E5hxgDhsFzXMvFz+QHQ1xPLEtk7I
         MpKQwC4OWWeITa3CttZz/hJIrMhzIwfiK2qlUFM3oQ+pLf0+kyUrZxmEAuZHGxA40rGO
         C6oA==
X-Gm-Message-State: AOUpUlEa0uPV3wlgOrEbPLib97rDyLQJPRPg1Eg66Lj/CIsF+/v0e2Pn
        1C60R+Hmf2KRSIPZvJmmyGZhoaaEnbnd+x632tI=
X-Google-Smtp-Source: AAOMgpdyhZrY+qOjScKcV2RaKrRpTkUmVM7JiW1ppBm9oo/iXCPRYIN1zejalsJ06rBiuUgW1Vgzv+l7ZcSZoUVU66o=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr8441064oia.154.1533435596180;
 Sat, 04 Aug 2018 19:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c712:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 19:19:55 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180805012602.GB258270@aiede.svl.corp.google.com>
References: <CAH8yC8mXaNDmLBpDmtVTP+6Yc8_fCz8YCadOL41fOvb2J6j=8Q@mail.gmail.com>
 <20180805012602.GB258270@aiede.svl.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 4 Aug 2018 22:19:55 -0400
Message-ID: <CAH8yC8nagnHtEosS0zNuHyh04GZYqfmL_5eR_R2qkWEBpxcM=w@mail.gmail.com>
Subject: Re: How to push using SSH and pull using HTTPS for all repos on GitHub?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 9:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jeffrey Walton wrote:
>
>> I'm having trouble setting up my ~/.gitconfig to push using SSH and
>> pull using HTTPS for all repos on GitHub. The idea is, no passwords on
>> pulls and only use the password for push.
>>
>> I've got the first part of the equation using the following in my
>> ~/.gitconfig (the ellipses are user info):
>>
>>    $ cat ~/.gitconfig
>>    ...
>>    # Enforce SSH
>>    [url "ssh://git@github.com/"]
>>        insteadOf = https://github.com/
>
> Does putting pushInsteadOf here work?

Yes, that was the trick.

Thank you very much.
