Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F5821841
	for <e@80x24.org>; Wed,  2 May 2018 08:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeEBIyT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 04:54:19 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:55465 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBIyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 04:54:18 -0400
Received: by mail-it0-f45.google.com with SMTP id 144-v6so16591451iti.5
        for <git@vger.kernel.org>; Wed, 02 May 2018 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bLhmqlqfOMyz9vlwgv8WN1T9YdzRd3OllI1fjjXXo7Y=;
        b=lfrtGaoAPS68hvTwUHkUkcxW17Wf5NqMqXGrRtMBdjCymY2DWhNfv8U/RC8Q1C483v
         J4I2WGNOGH8FgVXJsX9pbYg1hJyGfaogXdWqTwcGgKPbq98GlWmscgMZRdAHL09fytu2
         VCrY1omFXo41wF1LImC4RRDm83fgq8hIg/MtCwVwh43BY29hjr/2StuzNSBY78gBagOs
         aZw8p7R5bK/f/JQ5oVUSwHCdHmXqOCP4z6GSzSIgyKh4KsUg4gtVMux+wcYkNdtLdWB0
         QFug2KUsTj7qeJFITY+i5uH2SrtMPcwiqATxcvFAjhK4nJVEWVfReV7sLsUFwKITuPxX
         rQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bLhmqlqfOMyz9vlwgv8WN1T9YdzRd3OllI1fjjXXo7Y=;
        b=CCjXcBcb4gopatEOJnunhupLFxc79jbQGlCQUctARZiHwwRhvxWUWpjIReD/Vaficm
         j34pu4wblj//AfsaXyojytuJFoIvJkCTe5iRDQQ6UTrPG2OLN5Sa/3wKlpMRYMJxGEo9
         8b6R+VH1l3wUAqDXCkoo98lO+B3lEdKS8ax/IcomGAJzaiyy7eZGs/uKi8oHcXWBfoE+
         oV7IONgcaPFeAsyCtIlYgmspoKmd8uC92HNyRCJkvDRR3yNfX7t+iV5mxlKes9kgqcqK
         j+kj+ordJEwCmajcnH7OizEJxCtkKswdG9CG7hB84xeqvGOwmsKTl7BA6/8AROC4mAkV
         wrOA==
X-Gm-Message-State: ALQs6tCKCU/D2aq4KLSszmSTKB/g7H1YgGzUiKWCOTt0VHYGvq/Vsgi8
        62KD/qRCVgYbGt0Q5q1sOJvnTljrmK0iz3V2P4M=
X-Google-Smtp-Source: AB8JxZoYCdjzrT6ntpcX+wFji2Q8woyWOmApj6EBczpD2yf2TWARyxoaJxCrpHwaDV+EfByGXNPevblcnzNjzpLLJrk=
X-Received: by 2002:a24:5fca:: with SMTP id r193-v6mr17952775itb.89.1525251257541;
 Wed, 02 May 2018 01:54:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Wed, 2 May 2018 01:54:17 -0700 (PDT)
In-Reply-To: <xmqqefiuwu4a.fsf@gitster-ct.c.googlers.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502005528.19740-1-kcghost@gmail.com> <xmqqefiuwu4a.fsf@gitster-ct.c.googlers.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Wed, 2 May 2018 04:54:17 -0400
Message-ID: <CAEp-SHVj=EN7tD+s14DrCrXp=0fPFqWFbQNyPHFj_w2RUyBM2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add --progress and --dissociate to git submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks I was not aware of that option.

On Wed, May 2, 2018 at 12:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Casey Fitzpatrick <kcghost@gmail.com> writes:
>
>> These patches add --progress and --dissociate options to git submodule.
>>
>> The --progress option existed beforehand, but only for the update command and
>> it was left undocumented.
>>
>> Both add and update submodule commands supported --reference, but not its pair
>> option --dissociate which allows for independent clones rather than depending
>> on the reference.
>>
>> This is a resubmission with comments from Stefan Beller and Eric Sunshine
>> addressed.
>
> Readers would really appreciate it if these are prepared with
> format-patch with -v$N option.  Unless they read faster than you
> post patches, they will find a few messages identically titled, all
> unread in their mailbox, and it is not always easy to tell which
> ones are the latest.
>
> Thanks.
