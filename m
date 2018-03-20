Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4866B1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 21:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeCTVYE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 17:24:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46595 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCTVYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 17:24:04 -0400
Received: by mail-lf0-f68.google.com with SMTP id j68-v6so4775567lfg.13
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bf+/JcN+bJfgQZXk54Ligocr9u+O0G1ho9V3hZBqdSM=;
        b=DhzS/bHiAfntP/5moirNuxZGUgixxr7GyZkoXmPDOntSvEjGC5mLzUmcfBLAd2G2Ug
         7OjxnGlizHUHiMwMupqM0hIAY+Rh9M0bsGCaMEk+GQziHkOh4ugW9NCcyjMN+InB41mJ
         iRDMTY9/wZ4QOxVB8YI05Orh+EasoJxf6yjINQZot6eXXBNFP6LSK0BcLPA2UUOzPbwF
         +H8uh5jhubLDD2KhellbIrUqto4aaS1TRLysCbQLq9Aw8lh5bn6oCudOfoVMRNh0TbGK
         siJVWSnyb7E8A8GSqzLSDA5kDNvoQEXxRj3zAiEj8GeYNdHdcOuTlfYx+cwx+j1kxKzK
         B3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bf+/JcN+bJfgQZXk54Ligocr9u+O0G1ho9V3hZBqdSM=;
        b=U9+Kz05hQr3BtW0EM1GO/wEtMEaKDb3eKboU6UkOlPySFLSaOIdWqKzep6Tc8lnj+v
         gTRwlA3Rh53ifK1mzoLSMLfOMQdOx8cmCFIKwUZVI5sV6Sr1lJsmuZAJXkWtOrZwGdNe
         Os6LWIRFjbU7YikOe1h9e/EZT+1Gno7k/V3CrgPHwuNpSGyD/ZVQW6qDLy85W6tKykFb
         0hCeexVo2lYHmL2+iysxvNndh1liZsUB4YihxhO6mOfcMZBrFlACs/52aLp+ZgL32EyF
         gRzAw2Il78VL9rThvXzf4x2ambFQo+NMVRhInyh80EBhZ+AVdeMldxsDxJtQgV8/QTGA
         5LGw==
X-Gm-Message-State: AElRT7F2zekXaPZuCFkZWq7AaQJ8oDYSyXFbn/BXSSRy5FlsuTzZYVz+
        ieEdwnVMAD5tAmqprvsUq8WEbCbN0Iy/JJ0zkGpgAA==
X-Google-Smtp-Source: AG47ELs2NDjyh3/EMvrRlVm+rMlA9obQcL7Wu7hxls/lGisUJjBn/mMZqpX34M1awxEOpn3fqglNvuTyKlh0hbspeu0=
X-Received: by 2002:a19:9502:: with SMTP id x2-v6mr12602200lfd.119.1521581042375;
 Tue, 20 Mar 2018 14:24:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d591:0:0:0:0:0 with HTTP; Tue, 20 Mar 2018 14:23:41
 -0700 (PDT)
In-Reply-To: <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
References: <20180320204507.12623-1-wink@saville.com> <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 20 Mar 2018 14:23:41 -0700
Message-ID: <CAKk8ispSvaAr3iRhC4X+gufeKm20AQzw9_mvuysT7SiDsZQYJw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] rebase-interactive
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 2:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 20, 2018 at 4:45 PM, Wink Saville <wink@saville.com> wrote:
>> Patch 0001 creates a library of functions which can be
>> used by git-rebase--interactive and
>> git-rebase--interactive--preserve-merges. The functions are
>> those that exist in git-rebase--interactive.sh plus new
>> functions created from the body of git_rebase_interactive
>> that will be used git_rebase_interactive in the third patch
>> and git_rebase_interactive_preserve_merges in the second
>> patch. None of the functions are invoked so there is no
>> logic changes and the system builds and passes all tests
>> on travis-ci.org.
>>
>> Patch 0002 creates git-rebase--interactive--preserve-merges.sh
>> with the function git_rebase_interactive_preserve_merges. The contents
>> of the function are refactored from git_rebase_interactive and
>> uses existing and new functions in the library. A small modification
>> of git-rebase is also done to invoke the new function when the -p
>> switch is used with git-rebase. When this is applied on top of
>> 0001 the system builds and passes all tests on travis-ci.org.
>>
>> The final patch, 0003, removes all unused code from
>> git_rebase_interactive and uses the functions from the library
>> where appropriate. And, of course, when applied on top of 0002
>> the system builds and passes all tests on travis-ci.org.
>
> A problem with this approach is that it loses "blame" information. A
> git-blame of git-rebase--interactive--lib.sh shows all code in that
> file as having arisen spontaneously from thin air; it is unable to
> trace its real history. It would be much better to actually _move_
> code to the new file (and update callers if necessary), which would
> preserve provenance.
>
> Ideally, patches which move code around should do so verbatim (or at
> least as close to verbatim as possible) to ease review burden.
> Sometimes changes to code are needed to make it relocatable before
> movement, in which case those changes should be made as separate
> preparatory patches, again to ease review.
>
> As it is, without detailed spelunking, it is not immediately clear to
> a reviewer which functions in git-rebase--interactive--lib.sh are
> newly written, and which are merely moved (or moved and edited) from
> git-rebase--interactive.sh. This shortcoming suggests that the patch
> series could be re-worked to do the refactoring in a more piecemeal
> fashion which more clearly holds the hands of those trying to
> understand the changes. (For instance, one or more preparatory patches
> may be needed to make the code relocatable, followed by verbatim code
> relocation, possibly iterating these steps if some changes depend upon
> earlier changes, etc.)
>
> Thanks.

Must all intermediate commits continue build and pass tests?
