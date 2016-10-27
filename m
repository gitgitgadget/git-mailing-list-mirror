Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC0720193
	for <e@80x24.org>; Thu, 27 Oct 2016 19:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936059AbcJ0Ts7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 15:48:59 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33210 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJ0Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 15:48:56 -0400
Received: by mail-yw0-f181.google.com with SMTP id p22so42491576ywe.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MwkVxp1EE2+ZCTNcjLEtc+mTuQi+3eOyxI6I5zOL0TQ=;
        b=pVsyapZnf1MUhalRxGyOT7MHe1WVXhDJL0uTKKiVi7J6tu5fhzLMMuUxBEXpSlhXsm
         Yy7RDQzbbWDHxCebolDeYUGfNwz4mieIwAayXZH0KwWvlK5HHFR1N/qrrVbqHzN3l/dg
         mTF8lrKEj8fXrcPd3KJTtx8zxPPcGdggXTcademH4f7GMK8WD9KQc91S8wdW5MrF3+5Y
         KH7div87RNn6fsWDldkKD5J2BZy2dgt1DUer7TbOkCAWnFOU8EbjaJ060CoazleuB8/j
         BrelXV+WRir5Ll5nEcLkkRXRTI1SV1GvPeEcwpsjBCQ51luGVOWDTeq/Wue5C4oRtM/q
         webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MwkVxp1EE2+ZCTNcjLEtc+mTuQi+3eOyxI6I5zOL0TQ=;
        b=h0zQPfZdMDn8ViQEkTH80dLEJCYYJZKJIUSXFtnaKyZC/BS+Qe0iJaErveoKGR8RgX
         hTP8QI469B53BZg30h/+qxY1NXNbXLb6oECh2JcvAWvT7QnNSSg1itfSgPmy7GUxefR3
         mUg/FHC3rxqHD6y8PPToiHOWqTnuA/GVwR2g5b6NMRrJtzoT3qyp5ENsNXD8KBaGXHId
         eYEDsqxFoK73vbqIP/bB9MYK8Ff43aEeiaszHMIIR0YU1VZY5EMAVi50nLL/vIeQeLpb
         cdM3XY0feE1vatjo9bw53Nb0c6ppKwD4GD3V7h1+Q7Zo8+Ses5XsRT17xzXxgTEjFTCw
         dNqQ==
X-Gm-Message-State: ABUngvePXStn6I3FDpMigNN7nX7y6rKFa1lxlA6FbRKbnnj3fla3Z4qbNk2P4xztHMLziBePS76n6TMqq6Va8w==
X-Received: by 10.13.231.131 with SMTP id q125mr8389816ywe.122.1477597735244;
 Thu, 27 Oct 2016 12:48:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 27 Oct 2016 12:48:34 -0700 (PDT)
In-Reply-To: <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co> <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 27 Oct 2016 12:48:34 -0700
Message-ID: <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
Cc:     Aaron Pelly <aaron@pelly.co>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 3:50 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 27, 2016 at 01:22:43PM +1300, Aaron Pelly wrote:
>
>> The use case for this is where I did not write my own rules, but I want
>> to keep them updated. https://github.com/github/gitignore is a damn good
>> resource, but I want to pull it and include relevant bits project by
>> project and/or system wide. I don't want to have to update many projects
>> manually if that, or any other, repo changes.
>
> That seems like a reasonable thing to want.
>

Agreed, this seems useful to me.

>> A very brief look at dir.c would indicate that a recursive call from
>> add_excludes to itself when it parses some sort of include tag would do
>> it within a file. I'm sure it'd be pretty straight forward to hook into
>> something in dir.c to parse directories too.
>>
>> I'm thinking something like ". path/to/include/file" in an ignore file,
>> and/or creating .gitignore.d and/or allowing $HOME/.config/git/ignore
>> and $GIT_DIR/info/exclude to be directories. Or some sane and consistent
>> mixture of these things.
>
> I'd shy away from an actual include directive, as it raises a lot of
> complications:
>
>   - as you noted, cycles in the include graph need to be detected and
>     broken
>
>   - we parse possibly-hostile .gitignore files from cloned repositories.
>     What happens when I include ask to include /etc/passwd? Probably
>     nothing, but there are setups where it might matter (e.g., something
>     like Travis that auto-builds untrusted repositories, and you could
>     potentially leak the contents of files via error messages). It's
>     nice to avoid the issue entirely.
>
>   - finding a backwards-compatible syntax
>
> Whereas letting any of the user- or repo-level exclude files be a
> directory, and simply reading all of the files inside, seems simple and
> obvious. If you go that route, it probably makes sense to teach
> gitattributes the same trick.

Yep that would be easier and simpler.

>
>> In the case of a directory the plan would be to add links to files
>> stored/sourced elsewhere. This does pose a precedence question which I
>> haven't thought about yet, but probably makes it too hard for the
>> limited value it brings.
>
> I think the normal behavior in such "foo.d" directory is to just sort
> the contents lexically and read them in order, as if they were all
> concatenated together, and with no recursion. I.e., behave "as if" the
> user had run "cat $dir/*".

Yea, this is the normal behavior, and the user is expected to order
their files lexically such as "00-name", "50-name" and so on. Pretty
traditional for a lot of newer configurations.

>
> That lets you handle precedence via the filenames (or symlink names). It
> can't handle all cases (some items in "00foo" want precedence over "01bar"
> and vice versa), but I don't think there's an easy solution. That's a
> good sign that one or more of the files should be broken up.
>

Yea if you have these inter-dependent relationships it can't be
expressed, but then neither can it really be expressed in the simple
"include" case above.

I would strongly prefer rc.d style directories either with a "if the
.gitignore is a directory treat it like rc.d" or even "add support for
.gitignore.d as well as .gitignore"

One thing to keep in mind would be that we should make sure we can
handle the .gitignore being a submodule or a git repository, so that
users could just do something like

"git submodule add <repo> .gitignore and then track git ignore
contents from a repository in a nice way.

By this I mean that the reading of files in .gitignore directory
should exclude reading .git or other hidden files in some documented
manor so as to avoid problems when linking to a git directory for its
contents.

Thanks,
Jake

> -Peff
