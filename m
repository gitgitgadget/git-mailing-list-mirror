Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C681F51C
	for <e@80x24.org>; Tue, 22 May 2018 14:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEVOJM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 10:09:12 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35733 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeEVOJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 10:09:08 -0400
Received: by mail-oi0-f43.google.com with SMTP id a6-v6so16308311oia.2
        for <git@vger.kernel.org>; Tue, 22 May 2018 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LS5wbxR8j+um1NpkXfHS9Pkgu7oEIFynOBy99L7DzwM=;
        b=RKdj0rk5OPOaQ1UcMHi6MBE/N1hvk8h0RwOjzcs/Q8PNrPoffnQQOTRCKDv71jYZ01
         8kqi7CI1waugfFvwO5KM2JSTShbXRDqH1Kc4VZPwg3MxPv8t8DkLnvxrV6rjdHebQ9Ym
         RPq9KAJSbIVeuDbRarzzXRFBkDWiPSHaOCmDiVhskrNL1TaM4sTKyG2J7sm3x3LHx0tt
         vIszrBz7NaUWOxtdunymyIPVzv1kWxfmkfrRaVVbhz3cG3pZFSdxTuRUul5H25T51zmy
         TKFAEiwI/uHWuJLeBLHiyAqQXhDyVwpB+9E3imPJsfc5iAsolrE4wwOFQQEkPz5RlqL+
         GiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=LS5wbxR8j+um1NpkXfHS9Pkgu7oEIFynOBy99L7DzwM=;
        b=e+F6ZU8TPnymYGdtDTOGsAfCVPsIH5aBgPOV+3tCUOpa2uENEJO3td8qLtxygxclqW
         IUc+/d6gUuDTKQDf01176icFoyOZXH7+eQM+Qf5wRaO/8bq/zbAz2bpUENHsoNtiEfL4
         o0GZaqf5P6MeE3oeNfMefibU9U+RiXaud+3K1VSpY8+3zfCuB2KVK57pVdjo6+l+mKlW
         SyG9I1ViaFN59Xb+4OqPbnk2InIzCeUbVupZa3PGMRV35AAkkije56zMOsubKy9ptAw7
         Xtoe8Ab9xX18p2RvBm4vx7gxbRSySH20gDxkdpND/9uJMx2vfw86s9bBdyFaHdVT9FEC
         VKnQ==
X-Gm-Message-State: ALKqPwdZp1GZ2n0RAO1lnejyQ9WwAk5Y4TfLUB0OlaJQaTgGSpnv5Whl
        Q99EcPerR61cCqxezg45vS6gX0CEH2Z1kwayH54=
X-Google-Smtp-Source: AB8JxZpUQI0fC4B7Wdm3iXe4DEpz4fpV2D9IWQmBTFQK8+CSyBgEq8iVm62Q1M2vaDrwrYkTwh/I5bejfypafDp/E2I=
X-Received: by 2002:aca:e3cf:: with SMTP id a198-v6mr13395870oih.283.1526998148042;
 Tue, 22 May 2018 07:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.120.203 with HTTP; Tue, 22 May 2018 07:09:07 -0700 (PDT)
Reply-To: dpowless517@pobox.com
In-Reply-To: <CAP8UFD0MDwtTmE=VUcUrGUzryJPLpBsUqeHgun3PwJHU1f2Tiw@mail.gmail.com>
References: <CAGC=61KqsBa1dUqQSSyow5Qksgtspw-4yovkmKohny9SDM5ZMA@mail.gmail.com>
 <CAP8UFD0MDwtTmE=VUcUrGUzryJPLpBsUqeHgun3PwJHU1f2Tiw@mail.gmail.com>
From:   Dennis Powless <claven123@gmail.com>
Date:   Tue, 22 May 2018 10:09:07 -0400
Message-ID: <CAGC=61KTRt9v=RX+o2OWjj30kNG25pTLQW_xqyo5iMXJ4XYUqA@mail.gmail.com>
Subject: Re: user name
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the info, yes your are correct it was for the git config
not github.  I'm brand new to this and wasn't sure if a real name was
required vs just a username.  I know is some cases official names are
required and didn't want to use the wrong one to start out with.  I'm
reading the help files/information currently and one of the first
steps was to set this up.

I'll set up github separately.


Thanks for the info!

Dennis

On Tue, May 22, 2018 at 9:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, May 22, 2018 at 3:06 PM, Dennis Powless <claven123@gmail.com> wrote:
>> Is it customary to use your real name or a user name when registering to GIT?
>
> I guess you are talking about using `git config --global user.name
> "XXX YYY"`. (Though maybe you are talking about github.com
> registration, but in this case you should not have sent this request
> to this mailing list.)
>
> When you use git config as described above, this is not a real
> registration. You just configure Git on your machine (only your
> ~/.gitconfig is changed), so that Git knows what to put in the
> "author" field of the commits you create.
>
> You are free to use whatever you want but some projects might ask
> contributors to put their real name in the author fields of the
> commits (and sometimes in other places too, like in the
> "Signed-off-by" in the commit messages).
