Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6437B202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdGFSCI (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 14:02:08 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37159 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdGFSCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 14:02:07 -0400
Received: by mail-it0-f43.google.com with SMTP id m84so11524539ita.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vMdaws/Pk0fIH4dekKckmqNch+bgB1ORMOsMXkdyMiE=;
        b=MaoC6XfCEq+zC5C2MpDP0C4gMSaqgL1AAAIeiX9CfRMLE5iLdXMadlB/iq47oANv/N
         BBY/VgQz/ayALljuV3pkPrlmP27ruq13KyRValNrY/ztMSysKLRIINzqQ2+u+Tkh59Sa
         rbnD1Bx8MNRpti11lPZszFBZWFxJPYaLPbrDghPN85aVicLrbeLKmPiMP7m5LD4UM76y
         1LEIt3uARRqoM12bl1DXyLTvHbPNNEocRTfQIe5h94QtPMwDOKe9z8Gh5LYpR8ff7BPl
         NvkZfpvwlyjfLCB1u5zwZwpsnLMy0wRFTogJIxBk8KS/jUkxw30Zvf9ydDbLjFQYkWlD
         bgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vMdaws/Pk0fIH4dekKckmqNch+bgB1ORMOsMXkdyMiE=;
        b=CqDoRFpudaQI9sI6Lg19NRtiA4r5nZPYuo/JDtLRfwJPQA2h4szsC6MwS7mW8Y+Fp0
         LOgY8ueRPQnpmOdgngjt6+DS6qkz45ckVRTXoNs4BZO1j+qUydgaWsaNH5OTDiFiD2DB
         uOxMN9X01BYBTNFbHGHAhhNN4SfXn1oCPCkrWdJOP/SzqTVciiYp+9JV7Din+GOC+zfK
         1vm3KftSWAcIoMC0JkkbXzmcZ06Gl2nuUssuJ2s95GklS4gOu1URewasf9d/A2Nbjwk8
         HKWDP20RJktUAbe+ipqvhI8In+eeczhR4L6AKE/C8nEUMaoK3ElLHBbL6sqVDxK8YZKy
         6sKg==
X-Gm-Message-State: AKS2vOxHh0ojFxionigRGDrAvBVdTTi+9v3wxvPH7fJN3h/FGOYwrUdJ
        p1nR6EExjwqQfGXdcIs6PaXJQ+OhLo0uaCiG7w==
X-Received: by 10.107.19.168 with SMTP id 40mr48040248iot.51.1499364126480;
 Thu, 06 Jul 2017 11:02:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.196.153 with HTTP; Thu, 6 Jul 2017 11:02:05 -0700 (PDT)
In-Reply-To: <87h8yptr7t.fsf@kyleam.com>
References: <87k23ltsl6.fsf@kyleam.com> <xmqqfue9fqfe.fsf@gitster.mtv.corp.google.com>
 <87h8yptr7t.fsf@kyleam.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 6 Jul 2017 11:02:05 -0700
Message-ID: <CAGyf7-HiwR+CDtDCvQ7q9Dd_TYfvN0133UOYTO65F=4qOHqy9w@mail.gmail.com>
Subject: Re: name-rev: anchor pattern without --exclude?
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2017 at 10:23 AM, Kyle Meyer <kyle@kyleam.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Kyle Meyer <kyle@kyleam.com> writes:
>
>> What is the answer desired by your application when two or more
>> branches point at the same commit you are interested in?  Pick one at
>> random?  An error saying it cannot decide where to place the snapshot?
>
> Our use of name-rev is just to get a friendly name for a hash.  If two
> branches point to the same commit, we're fine with whatever decision
> "git name-rev" makes; we just want to limit it to refs in the
> "refs/heads/" namespace.

If you don't need the ancestor traversals "git name-rev" provides,
"git for-each-ref --count 1 --format "%(refname:short)" --points-at
<hash> refs/heads/" might work. That only goes back to Git 2.7.0,
though; still quite a ways off your 1.9 target. ("git branch
--points-at" does the same thing, I should add, and only for branches,
but you can't directly limit its output like you can with
"for-each-ref".. Perhaps that doesn't matter for your use case.) If
you want names like "master~2", from your example, though,
"--points-at" won't do what you need.

Bryan

>
> --
> Kyle
