Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7611209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdFFWBB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:01:01 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36338 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdFFWBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:01:00 -0400
Received: by mail-wr0-f182.google.com with SMTP id v111so53346877wrc.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CLJW0OxZfuczfEPpzZB/8qjySNsPxylLZDYKClXtdCs=;
        b=qvv5G3/7u4yIOovLh6vWPFzDuNQ2wQKcK56SfOB/fOawirFP6lN3keirb5fsU2M59h
         XdzViyyx9HciPtX5j5IdQpZ+/C3jX0/tywrA57cnDSuzcxZaFHXxPaU6MjncQ0LieXgR
         qvsGiecP5gIbFuT9ZZ3+iS1X522VGQ5GmVQCAebnxTypIKK8Zr5C3J/wvtRL7fm3PJeE
         em4q6VZctwCD+dL/URg5XvLJXlmwQtVe0Uzjau4QITgkF1av6i1HZfZHcwSJu7M0NSCb
         4fd76boyrVdmiy1l7JZ/xhVAfHrzotXJORKO0OrAbcOEdB8+UGvegrzIzfIJW/B75oA3
         76dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CLJW0OxZfuczfEPpzZB/8qjySNsPxylLZDYKClXtdCs=;
        b=VfiHcr58l0e7kN/wm3X+SSq/PwF2U8zGEm6e6DnLXNSfFh7L5BV56KDuqtApyf4kTv
         1LQj2/0JJ6cEZ63Tx7oKDrGrzxx/BKglh4VOqGx77e7HiVhXCJdD7VooJrNh5jW07yyH
         0eAiDvbUxVjdlCW482SGtP0VN8gXKvBeotP1XC2A7A7SgcPd2sI7fRmsn3qUpHtNNHdg
         cl8jt6tVrXKKaFJY5p2XXfNvpTiYlt3eYVHImNHME2LmGXNuk/0dFseK2Dr7CsBWd3J8
         DouElGACfMx5N5dVnsGbjp0p78GDje1KU9s88qhnM9GYxFNz3NontRRwNWkWyEyZiFG2
         N29Q==
X-Gm-Message-State: AODbwcDaR5g4KbH+hj25GeIS/pcpcK0mRXuh1S22lUV8b6uctrDA/ab5
        8lkM0m01CpUzgHU3BpvMLy+cxwDWmw==
X-Received: by 10.223.165.4 with SMTP id i4mr17425943wrb.148.1496786456832;
 Tue, 06 Jun 2017 15:00:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.214.143 with HTTP; Tue, 6 Jun 2017 15:00:36 -0700 (PDT)
In-Reply-To: <20170606210318.e2ey4pwxhxsuvizi@glandium.org>
References: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
 <002801d2dec9$2cd49dd0$867dd970$@nexbridge.com> <CACkx65CRfZ-Se6oPzy6fHtC7R19UWc-EDopudHQY3JiwV-hAAw@mail.gmail.com>
 <20170606210318.e2ey4pwxhxsuvizi@glandium.org>
From:   rajdeep mondal <justrajdeep@gmail.com>
Date:   Tue, 6 Jun 2017 18:00:36 -0400
Message-ID: <CACkx65BrZv3bVmYZ1s03GGe-eqfzvgKQbzoLN0WD6by3Zn16og@mail.gmail.com>
Subject: Re: Feature request: Please add support to stash specific files
To:     Mike Hommey <mh@glandium.org>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Mike.

On Tue, Jun 6, 2017 at 5:03 PM, Mike Hommey <mh@glandium.org> wrote:
> On Tue, Jun 06, 2017 at 02:38:08PM -0400, rajdeep mondal wrote:
>> Hi Randall,
>>
>> I completely agree to what you are saying, but sometimes it just so
>> happens that in the middle of a change, i feel like if some portion of
>> the changes are fine I can commit them.  Stashing some of the files
>> and being able to check the compile/tests at this point would be a
>> really awesome change.
>>
>> Stash supports a -p option to deal with this, it becomes cumbersome
>> when the number of files are many.  Maybe it is something which would
>> be a good to have feature. People need not use it if they dont want
>> to.
>
> Git 2.13.0 has that already.
>
> git stash -- file1 file2
>
> Mike



-- 
==============================
Rajdeep
==============================
