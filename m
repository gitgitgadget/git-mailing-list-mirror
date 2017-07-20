Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1070A1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbdGTStr (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:49:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35823 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936021AbdGTStq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:49:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id w126so31837035wme.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VIebTdH/VQcczE221jwlwI0kBSo/Kv6Y+TTu3+dM+xw=;
        b=P5/wsDGyZAJJuwuRclQZcHXvTPu6MenLF3vuh4H+XOiY5KPTrzeC0n/ii5Gvtz23OO
         YscoCd83sbPonxTCmRBPVTkAmIcaW30UB5FrK8aakCT80QfX4BBr9ju74vFoB7fMbP8H
         JCt6biswlJLHJWdn/gGuFzEq2YLC+WbihZyqXE+PYXCJBd/8PfvIFMnOvfUfTVN7Pkxd
         iMWo7O7OVUx8bQoBkFBnljGhBVNV1jQx2vncq5tqcsmLf1bNEpnvYPe18YlRgTRFICRE
         Nnn0J7WeFzVz8vdTP9FIAN04o8ADYiJDDja9uu/m4p5fFke7yHlUPmV2uOWzuX7I6zAL
         ScZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIebTdH/VQcczE221jwlwI0kBSo/Kv6Y+TTu3+dM+xw=;
        b=X4W1msR6q+TeOTPfuG4AeUuiaitFSDrQW1WkitrsiQpRSeIsb8m4HHBSE7ncBHA5eR
         WjKcwq3kVMCMuhtvaVJJfvwpxclYFSmQcM/JW0uWmY/B6SHZQ2KnDRlBRcgbU/546qzi
         V/XVh3Qj5//Z37VgcOjQjVeDt3DitmGjUOR48AmIAwOtF01DbivkTR7M9RaWhr2vYi5i
         abtPQPeDFR6HjcpeoSLZ5DBS0OOa+GlinPgc4DSnge+FjSRys5ONmGb8qUHc+Ak1Pafh
         4+r97aDE3NFKso9znVfb616xK/MJLnmxvYqm4mHrm4vk2HEjJJNy8B/XHvyI6rB9aphN
         h8+A==
X-Gm-Message-State: AIVw112N/M6r3z24rq193+nQB02BCrRQ8krdOHpwwL9anxgcCfrEOcc7
        hvNt0/fAvqCEXkuuy0E=
X-Received: by 10.28.209.137 with SMTP id i131mr2947105wmg.14.1500576584897;
        Thu, 20 Jul 2017 11:49:44 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id 46sm8977076wrz.8.2017.07.20.11.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 11:49:43 -0700 (PDT)
Subject: Re: Binary files
To:     Volodymyr Sendetskyi <volodymyrse@devcom.com>, git@vger.kernel.org
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
 <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d4b1b92d-6ab1-7e6f-4afd-6194a5ba8e40@gmail.com>
Date:   Thu, 20 Jul 2017 20:49:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Volodymyr,

On 20/07/2017 09:41, Volodymyr Sendetskyi wrote:
> It is known, that git handles badly storing binary files in its
> repositories at all.
> This is especially about large files: even without any changes to
> these files, their copies are snapshotted on each commit. So even
> repositories with a small amount of code can grove very fast in size
> if they contain some great binary files. Alongside this, the SVN is
> much better about that, because it make changes to the server version
> of file only if some changes were done.

You already got some proposals on what you could try for making large 
binary files handling easier, but I just wanted to comment on this 
part of your message, as it doesn`t seem to be correct.

Even though each repository file is included in each commit (being a 
full repository state snapshot), meaning big binary files as well, 
that`s just from an end-user`s perspective.

Actual implementation side is smarter than that - if file hasn`t 
changed between commits, it won`t get copied/written to Git object 
database again.

Under the hood, many different commits can point to the same 
(unchanged) file, thus repository size _does not_ grow very fast with 
each commit if large binary file is without any changes.

Usually, the biggest concern with Git and large files[1], in 
comparison to SVN, for example, is something else - Git model 
assuming each repository clone holding the complete repository 
history with all the different file versions included, so you can`t 
get just some of them, or the last snapshot only, keeping your local 
repository small in size.

If the repository you`re cloning from is a big one, your locally 
cloned repository will be as well, even if you may not really be 
interested in the big files at all... but you got some suggestions 
for handling that already, as pointed out :)

Just note that it`s not really Git vs SVN here, but more distributed 
vs centralized approach in general, as you can`t both have everything 
and yet skip something at the same time. Different systems may have 
different workarounds for a specific workflow, though.

[1] Besides taking each file version as a full-sized snapshot (at the 
beginning, at least, until the delta compression packing occurs).

Regards,
Buga
