Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B64320281
	for <e@80x24.org>; Fri, 15 Sep 2017 13:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdIONTL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 09:19:11 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:48237 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIONTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 09:19:10 -0400
Received: by mail-lf0-f53.google.com with SMTP id q132so2386325lfe.5
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wLCFqGX12CSeJThydYVPoQDY7si8UTYWL2ae1kluv7s=;
        b=b1HWGB2lZgFzvckodMmeo1VqQQGPTpHJaA59Bu5zUkfLyA90lAAG07hV1DMtjA/R5o
         Xpu3hJFKlubR8GBvv5VbhzvKsotr5t+KrR+hOr3thZKJbfdQd+PAf3121KXxnDpH4xQ6
         6Zb+Fs8dkPukG8G1qOX99/pYwuCOHz+OcO5Fd66ZTUu5wojS/BUFkeKs/nYmWbMFps9P
         F4BbHPmOFerjz5onpRawH9DxvI0kw96EOaOSeRy8cOsJxT0wGU9ueElUomb0THgNWoe6
         7OMXqy/cCq0ujTGhl5aDyVC9fdAIkAR9WpH2dzOPfJ1crnjeZ234eO98PqE+wx8pqb1P
         FfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wLCFqGX12CSeJThydYVPoQDY7si8UTYWL2ae1kluv7s=;
        b=cSJUawB1iYMLf78iyuM376lHdftIJVbsP2R7tldfHOyqgFEnwO7lYW3QG0VcsghDkD
         ErMhDDApQRQXrN6IkskYd/+82T3j+k/uKagkMneBGe/fRc8BFgp4hSsWa9T7pyN2PyA5
         rTV409rmS+t2HaZbDmTvh23JF7z32m2Gz0hbIIRZMJX+AUy7KTUqqmDKdBgK0Zmndc4x
         Goe5NZeoKAvNBVUp2pceX3dCv9ZoJs1dSdqBwqvklLybO9j8mWn2QxPOWcqB8Adlo8L5
         AcgWKKohNF0XsGyvILUn0h935SEBMe8JtJV37rp7ksrKdXUjFRtljxxC6caLn9TFHTy+
         YX7w==
X-Gm-Message-State: AHPjjUj6vTKbnHiPxc7inVhhNSlj0WpmPQ8q1ftp95hI57FR8kMTglvJ
        ngtwdN9UrsYECM7BevNONxxFdqp3h1THXJSr7QE=
X-Google-Smtp-Source: AOwi7QAE94q8gPlGtVGw+A5oZXTnFBt9cOz40yMaJOeueBBbRnFSoRYq6IGQXTosbTojo9yysc0LDXMUnA3aMtn3tfI=
X-Received: by 10.46.89.210 with SMTP id g79mr1844946ljf.161.1505481549480;
 Fri, 15 Sep 2017 06:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.209.85 with HTTP; Fri, 15 Sep 2017 06:19:08 -0700 (PDT)
In-Reply-To: <1505440235.1862.9.camel@gmail.com>
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
 <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
 <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com> <1505440235.1862.9.camel@gmail.com>
From:   Joseph Dunne <jdunne525@gmail.com>
Date:   Fri, 15 Sep 2017 08:19:08 -0500
Message-ID: <CAC7pkbREUZxG0drWVpV43TFv7AVi2agJkRtXZgNsLErk3iBc-w@mail.gmail.com>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Valid point.  The way my project is set up I always get a conflict on
merge operations, so technically all my merges (except fast forward
merges) end with a git-commit, which of course runs the commit-msg
hook.  It seems everything is working as designed.  Shame there isn't
a merge-msg hook.

It seems I have no choice but to work around this issue.  Thanks for your help.

On Thu, Sep 14, 2017 at 8:50 PM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> On Tue, 2017-09-12 at 13:24 -0500, Joseph Dunne wrote:
>> Sorry I don't understand your question.  The commit-msg hook runs
>> properly in all cases except when I perform a merge with the --no-ff
>> option enabled.
>>
>
> It's working just as the documentation says it does (emphasis mine),
>
>
>     This hook is invoked by **git commit**, and can be bypassed with the --no-verify option.
>     It takes a single parameter, the name of the file that holds the proposed commit log
>     message. Exiting with a non-zero status causes the git commit to abort.
>
>
>     It says that 'commit-msg' hook is invoked only for a "commit" (it's not
>     a MERGE-msg hook you see, it doesn't exist anyway). In case you see the
>     hook getting invoked for a merge then that's an issue, I guess. For
>     what kind of merges do you see the 'commit-msg' hook getting invoked?
>
>         --
>         Kaartic
