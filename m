Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26821FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 17:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdAFRzH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 12:55:07 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35668 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937679AbdAFRzF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 12:55:05 -0500
Received: by mail-qk0-f171.google.com with SMTP id u25so466584912qki.2
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZE7hle5DzpFlhj5+c+C++JF8bnU7Gt1KQ3JNp6xVAxc=;
        b=WPlPcYay6kmvB99rSzV3/cEG3I1NmC83+2d5ENdzkb0nJoYCJOdBjem6qoeQUtv6Vn
         p+yveKmswGq3G09Wt9p8ogcnsDpoVvkK2zYWiSklBJgJiQuev7knG3WRu6/2BQKrVGn1
         DXgLPeKG3POAS7r83szkqCQ/h+5F1dvWjVb9Tbol39tys9oxRQ7BKp2CYEvQpgZdYY6d
         HV0Y49a8YVZiHJFn8v4Dlmj3ZpdsQn0kZ8bM5iymoBHx/jy6AHzqcJsQeWWfyJdsH0jG
         oVlAL35mFPqRtaW1VfcTqnUaxTCgoRJhx/ZEBGGCtdb4biZ5TMv3KguNtZZ71AqrhMtl
         je6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZE7hle5DzpFlhj5+c+C++JF8bnU7Gt1KQ3JNp6xVAxc=;
        b=T2KFL+g1EAOqSD68vKmNLFBy1akLcZ1B500OU9s2pGyRAi+rm19DHAjU1mZGxrO2X+
         DJp2IpZ1C4N426Hho50W8gtBeDmjCnxgSl9wmejOK9hW41SQZ0U+FPekM3ooq0iFxHSN
         hmIQH9HmyeeGN4k/d2XTXNlh3dOliWc24cpQMQ7yDqj+pnhIYPJMAIxrWm+YxXnVgoso
         stasyyAvPV0uVjlYgslU/wr+pOmpY0MqgL72G/3nlb1jxAfauqfUXH/taFjMffM68/3d
         K4JNRmMgyqsMEJtB89+uaiTgXB0Djs2Fqs8xsr4S7ypp7enOFJ8/LGhwwXknMvRwMyFf
         qtdg==
X-Gm-Message-State: AIkVDXLHHIv3KSHpU0HGzzsZmYwRyCm4us7AXmbaD+qBcfx4beWfbtjuvIELTI37jEh6PxcLhEIisS9fvOF+ggvk
X-Received: by 10.55.105.129 with SMTP id e123mr81088160qkc.173.1483725303856;
 Fri, 06 Jan 2017 09:55:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Fri, 6 Jan 2017 09:55:03 -0800 (PST)
In-Reply-To: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
References: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Jan 2017 09:55:03 -0800
Message-ID: <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com>
Subject: Re: git branch --editdescription fatal error
To:     Jake Lambert <jake@onahill.co>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 9:25 AM, Jake Lambert <jake@onahill.co> wrote:
> Hello,
>
> When executing "git branch <branch> --edit-description" on a branch with =
no description set, I get "fatal: could not unset 'branch.<branch>.descript=
ion". It would seem that the unsetting piece should occur only after checki=
ng if it was set in the first place.

That seems strange. Is it possible that your config is not writable?
(.git/config, ~/gitconfig, you'd need to find out where the <branch>
is configured already via git config --global/--system/--local --list)

> I am not too familiar with the inner workings of git, but if you accept p=
ull requests, I'm happy to give it a shot if you can give me directions as =
to how to submit one to you.

We rather do email based workflow, see
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
(We use github only as a host, you could also obtain it from one of
https://git-blame.blogspot.com/p/git-public-repositories.html)

>
> While I have you, I would also like to make a feature request for branch =
descriptions to (optionally) be included in the output of git branch <noarg=
s> (or something like git branch --descriptions). This is particularly help=
ful where branch names match JIRA tickets numbers or are simply so old I do=
n't remember what they are but don't want to delete them just in case.

Apparently the branch descriptions are only used for the request-pull
subcommand,
https://github.com/git/git/commit/c0168147831fce00975949213eef3471b7a2b76b
and the merge message
https://github.com/git/git/commit/898eacd8ada2d012f977948350ed60845e238037


If you want to work on both of these issues, have a look at
edit_branch_description
as well as print_ref_list in builtin/branch.c

> Thank you for maintaining this absolutely wonderful program, and have a h=
appy New Year!

Happy new year!
Stefan
