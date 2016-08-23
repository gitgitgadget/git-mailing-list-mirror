Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDA51FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbcHWRu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:50:57 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36815 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbcHWRu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:50:56 -0400
Received: by mail-ua0-f180.google.com with SMTP id 97so257631359uav.3;
        Tue, 23 Aug 2016 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LKv36nKZsYiIIfnMFgjPy1q2T+Woj9rn1xeIkYCxbbc=;
        b=BNAYWUt8iihGZKa+9ZJmc2f7Tx+dhexs2U8R9A9SCaLwEWTrmaWYTKAKKSjFu4hFJI
         /0xjHKj50VJck/k44nTdHDlTYnfv7a0m7T5JD8A+Wjbwt44Cnqnilp8FOQzWM5X6XmAD
         ZV8jChaxyTCdyIREGUWYN+w4HpV+7kj4uQUchnZtG3+Xy1n7sxary1hSrhFd6kiLlg4b
         3xmCUnHUwmATcUAJZbAU6QuWkWRip4lNtXWYqlwAUKv1Ok1cX+E3hY5426pSKNicjsiP
         Hbz/6A6ryz9yc/Lggqhfsu4o1vabUrXRW36JxLgdEopQ43qLGWuJPsXNXGd5RBBzp4k+
         uMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LKv36nKZsYiIIfnMFgjPy1q2T+Woj9rn1xeIkYCxbbc=;
        b=CHjbI+fYvKatPfHnl5Rf5mOkXarf6d2TglPfW9kjonCYy7Sy0olmvRdUlF0L6xdtwt
         SW9i36VxwbRRiaXNbe6quwYJ0EgmPSYhNyaaotDokR+L7nWLb9I3NB2b8EAU0wmYGKbX
         G+y1VcuWq6SR7rPO4SWmLrZYMaNJ9Zy+SBscx5fEEztyNMn2tdufEyFQ8aTW2Y9dS8hx
         SHXFo6ne0gd7yB03baIcG4JQGlZKvp0vNXgGCMqN+6njKOE6nzi3q5EC5NP+WzyYg1OB
         DB3jXh+JhkLEvvOr1UmdnkEwVlLnegnfQKyTgJ9MlFsbrYNXJYhlXyoNbbnxYTlgop/S
         fnnA==
X-Gm-Message-State: AEkoouuku0UQ7J7MVJRBkdD/8q3RaL/ef70InDOFRcVtfWnPnZ3ET99vLufGNGqVz0AXAYPAKpLxnpO8Th/+Fw==
X-Received: by 10.176.80.4 with SMTP id b4mr14255229uaa.17.1471974655557; Tue,
 23 Aug 2016 10:50:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.85.4 with HTTP; Tue, 23 Aug 2016 10:50:52 -0700 (PDT)
In-Reply-To: <501dc45544c5582379df21a758d3be6c@quantumfyre.co.uk>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla> <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
 <20160823055418.GA5990@whir> <CAHLmBr3Yn1tVhijmgRwd8hyxgasdc2VtfNi6pYP5FbEHjjb3Vw@mail.gmail.com>
 <501dc45544c5582379df21a758d3be6c@quantumfyre.co.uk>
From:   Lucian Smith <lucianoelsmitho@gmail.com>
Date:   Tue, 23 Aug 2016 10:50:52 -0700
Message-ID: <CAHLmBr1Cd_JimZEsLUjG=+v4CgsXGGzkyFizZ1U5YSSMqjsEvw@mail.gmail.com>
Subject: Re: git-svn bridge and line endings
To:     Julian Phillips <julian@quantumfyre.co.uk>
Cc:     Eric Wong <e@80x24.org>, Alfred Perlstein <alfred@freebsd.org>,
        git@vger.kernel.org, git-owner@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:36 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On 23/08/2016 17:14, Lucian Smith wrote:
>>
>> Thanks for the quick responses!
>>
>> My situation is that the git side is entirely whatever github.org is
>> running; presumably the latest stable version?  They provide a URL for
>> repositories hosted there that can be accessed by an SVN
>> client--somewhere on github is the 'git-svn bridge' (as I understand
>> it): something that receives SVN requests, translates them to
>> git-speak, and replies with what SVN expects.
>
>
> The ability to use a Subversion client is functionality provided by GitHub,
> and not native to git itself.  So unless someone for the appropriate GitHub
> team happens to read this thread I expect there isn't much we can do to
> help.  I don't know if they've even provided any real detail of how they
> implemented the bridge.

All right, that makes sense.  And yeah, it was hard to find any
information about the bridge, which is why I ended up here...

>> There is indeed a .gitattributes file in the repository, but the SVN
>> client doesn't know what to do with it.  My hope was that something in
>> the bridge code, that translated SVN requests to git and back, could
>> take the SVN request, "Please give me this file; I'm on Windows" look
>> at the .gitattributes file in the repository, and hand out a file with
>> CR/LF's in it.  Conversely, when SVN tells git "Here is the new
>> version of the file to check in," the bridge could look at the file,
>> realize it had CR/LF's in it, look at the .gitattributes file to know
>> if it needed to be converted, and then convert it appropriately.
>>
>> I can imagine a full-blown bridge that could even translate the SVN
>> EOL propset back and forth appropriately, but I'm not sure if going
>> that far is necessary and/or helpful.
>>
>> I don't know if this is the right mailing list for that particular bit
>> of software, but it at least seemed like a good place to start.  Thank
>> you!
>
>
> Supported properties are listed here:
> https://help.github.com/articles/subversion-properties-supported-by-github/
>
> You'll need to ask GitHub to implement support for the svn:eol-style
> property I expect.

Thanks for finding that!  That even has an 'ask a human' button, which
I expect is my next step.

> Might be easier to just use Tortoise Git?

It may be!  But thanks for the responses anyway.

-Lucian
