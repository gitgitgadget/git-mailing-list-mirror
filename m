Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE20420899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbdHQVmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:42:19 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:37137 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753663AbdHQVmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:42:17 -0400
Received: by mail-ua0-f175.google.com with SMTP id f9so29461098uaf.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fb55PKUUk99SHtNuEflWv/4EmoJqpxTS4qX6dEADxEg=;
        b=wxB1UbErgNCv6TcDsaZqIS0g09fb/cVDA8bea3z08FwiHF2TZdGeBGbIKNABcasYio
         zcBUuA7Hcd7MCv6Ryv+cjt/8oVKK6/lP0zpJPtE8k4RQ5NWIrJXUBaMX3EeUuhLzBW0P
         lAOtDOlMvL8ArNMrQh8R3EsaRFv0zAjTvXg6HBGeI4V72UbZKJquWsJf8BV3U0kf54O9
         gHbh/uqPLH924UBn4B6nnsg2Cg88xMh9hLMZEWzuKfZE1fA9bfqTW3xHQmRWk/dTzUTc
         EA1G3oh1Z1b8BCwelzjZkjQ2srSy2uFcF7g26bapWru4UJ1RDLfyEOfpt9zYKgIpc9XE
         Gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fb55PKUUk99SHtNuEflWv/4EmoJqpxTS4qX6dEADxEg=;
        b=st7k/63s0uUl/KbStdBw+pDIkMppVl74y0b+RH7f51sJ2tyJIontM5NAoNYgGUmcVE
         VT1bKMycEXQgJf3gFAFuFY/j7av1uubNjCjBUp+TxRczzMTXVKPSHyAF55TiLSwr1Kwt
         Nn1l++6xrMxgE7EMLMFOfCT4pC/duAbFP5044/v2k8/GaIDSuVBFpmisQXZrWMXNEtN0
         oHyNdJZ+2hlQjqYrpdn4wZpCeISmQsVW9ZpE3T7Ww29PEXbldTyOPGsgHMrclMwTTzg1
         oCTyRzI/9flWns53Nf3ZQZL7xLPkimbnHYUzb/kI4tzZZanWAUYw/gkKUl7HOdkEXpf2
         Thyg==
X-Gm-Message-State: AHYfb5icQ3qknI9C9HzUlJGFhnhD4KZIP3Okqav272p6nFc1q03FCHgM
        vbtCAyR86go9p+2wPl26gg0btgxdiyrk
X-Received: by 10.159.41.102 with SMTP id t93mr4358552uat.10.1503006136593;
 Thu, 17 Aug 2017 14:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.175 with HTTP; Thu, 17 Aug 2017 14:42:15 -0700 (PDT)
In-Reply-To: <f5d92196d19a4029bb4e282837c53a46@statseeker.com>
References: <9a2576ed8b7146459585af4238613286@statseeker.com>
 <871sonzlar.fsf@gmail.com> <20170807170745.GG25542@zaya.teonanacatl.net> <f5d92196d19a4029bb4e282837c53a46@statseeker.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 17 Aug 2017 14:42:15 -0700
Message-ID: <CAGyf7-GkLj-kSiLJJYA4HkYpnMWLubXdL+h_Auo4jw9R=4_XLQ@mail.gmail.com>
Subject: Re: upgarding GIT
To:     James Wells <james.wells@statseeker.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2017 at 4:20 PM, James Wells <james.wells@statseeker.com> wr=
ote:
>
> As you can see my version of git is not supported with the current versio=
n of bitbucket. I will have to perform a two stage upgrade anyway as the ve=
rsion of STASH I am running cannot be upgraded directly to bitbucket 5.2 as=
 well.
>
> Is there an easy way just to install a higher support version of git like=
 2.9 on the same server and then move all the repos and basically everythin=
g across. Can you install another TAR ball later version on top of another =
git , so it's like overwriting it.

Hey James, Bitbucket Server developer here. Sorry for not responding
sooner. I just wanted to check in with you and see if you'd gotten
this all resolved? If not, feel free to message me directly; I'm happy
to help you off the list. (Or on list, for that matter; I just figure
the general Git list isn't interested in this issue.)

Best regards,
Bryan Turner
