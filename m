Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DD42013A
	for <e@80x24.org>; Tue, 14 Feb 2017 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbdBNH4E (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 02:56:04 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36823 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdBNH4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 02:56:04 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so25055645itd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peakgames.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mMebM44MbibifKy10wEGSMG59CKAzbs9GOW1fk6911M=;
        b=PzvF65ksMeQAn3GDL3WMEeVBZQMsX3+08+OT+MJ4LQFeX+4QmWczVT0esfvuxFk4Td
         fTvJvq5Gqe4whYd1JBuf0RYKha/beG1TtqD2ZEtgaR+68aOp4Ytv0XXJUaGZ0gbdtZrq
         Pxb7FllX1RwHnj0VCylDI2bV9JkwUeQA8ye2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mMebM44MbibifKy10wEGSMG59CKAzbs9GOW1fk6911M=;
        b=axk8/VrPSQQW3QyGdOMJ3RBGpoRYdAx/vFz8NG+eDth39fySyP5sIUKVH4qKizHbr8
         1DKmNodd9X1aqFkW+rHMCmO/IQMtrZxdoM8ZSKnyLNhsnEtKETy8vFQadnF9qOtw1G8b
         LbYE05jBf9JL44mPje0Sg5F2Cvlr6Bd9eyG+sweAXc95Xerhz8iJmnVDhZukT2THfrD+
         StzHBioqFq/estY/h7p2dpM4/wO1Uh/hrdHzFO26Deon3lijPiqWiCgNda/wfcZ+U9jq
         vd3XGkzIRwfN8tYVwK1tFKrAnUq60ugzqL3rG2JmkP9c8GXMPSEGHcNLxYa/+OewjdUW
         P24A==
X-Gm-Message-State: AMke39mLiyBWQDS9Lqru92B4ue4yvx1Lx3GZejn2F+dCjkmw7BeUJEZWOHmdXXHCLKyo5RZMrOIdVpt6wVWm66Pr
X-Received: by 10.36.52.197 with SMTP id z188mr2416999itz.71.1487058962791;
 Mon, 13 Feb 2017 23:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.133.16 with HTTP; Mon, 13 Feb 2017 23:56:02 -0800 (PST)
In-Reply-To: <BE964323A3E644BBB01F8672263419EA@peakgames.net>
References: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
 <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com>
 <CAL7ZE5yXaJQFci+9aF4+cxeycnf71FMyLTV14t_TGDR3cnnfVA@mail.gmail.com>
 <CAP8UFD3uEAuK5SQD8V8f4GC3-jC+ix2sPwiFBw_kW3JhBG6L=g@mail.gmail.com> <BE964323A3E644BBB01F8672263419EA@peakgames.net>
From:   Serdar Sahin <serdar@peakgames.net>
Date:   Tue, 14 Feb 2017 10:56:02 +0300
Message-ID: <CAL7ZE5y5wgJfkwn0sAwVPtHhEXuX7tUc-pNkOor1WzAx_u3WhA@mail.gmail.com>
Subject: Re: Non-zero exit code without error
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I know it is hard to get an idea without being able to
reproduce it. I think there is no alternative without debugging it
with GDB.

I=E2=80=99ve tried your suggestions and nothing has changed.

I=E2=80=99ve also update the GIT as you suggested, but it is still the same=
.

Just to see, if GIT server causes some issues, I=E2=80=99ve pushed to repo =
to
github public as a private repo, and can reproduce the issue there as
well.

Thanks for your support.

On Tue, Feb 14, 2017 at 10:53 AM, Serdar Sahin <serdar@peakgames.net> wrote=
:
> Hi Christian,
>
> Thanks. I know it is hard to get an idea without being able to reproduce =
it.
> I think there is no alternative without debugging it with GDB.
>
> I=E2=80=99ve tried your suggestions and nothing has changed.
>
> I=E2=80=99ve also update the GIT as you suggested, but it is still the sa=
me.
>
> Just to see, if GIT server causes some issues, I=E2=80=99ve pushed to rep=
o to github
> public as a private repo, and can reproduce the issue there as well.
>
> Thanks for your support.
>
> --
> Serdar Sahin
> Peak Games
>
> On Saturday, 11 February 2017 at 15:28, Christian Couder wrote:
>
> On Wed, Feb 8, 2017 at 11:26 AM, Serdar Sahin <serdar@peakgames.net> wrot=
e:
>
> Hi Christian,
>
>
> We are using a private repo (Github Enterprise).
>
>
> Maybe you could try 'git fast-export --anonymize ...' on it.
>
> Let me give you the
> details you requested.
>
>
> On Git Server: git version 2.6.5.1574.g5e6a493
>
> On my client: git version 2.10.1 (Apple Git-78)
>
>
> I=E2=80=99ve tried to reproduce it with public repos, but couldn=E2=80=99=
t do so.
>
>
> You might try using the latest released version (2.11.1).
>
> For example you could install the last version on the client and then
> clone from the server with --bare and use this bare repo as if it was
> the server.
>
> You could also try `git fsck` to see if there are problems on your repo.
>
> Are there submodules or something a bit special?
>
> In the end it's difficult for us to help if we cannot reproduce, so
> your best bet might be to debug yourself using gdb for example.
>
> If I
> could get an error/log output, that would be sufficient.
>
>
> I am also including the full output below. (also git gc)
>
>
> MacOSX:test serdar$ git clone --mirror --depth 50 --no-single-branch
> git@git.privateserver.com:Casual/code_repository.git
>
>
> You could also try with different options above...
>
> Cloning into bare repository 'code_repository.git'...
>
> remote: Counting objects: 3362, done.
>
> remote: Compressing objects: 100% (1214/1214), done.
>
> remote: Total 3362 (delta 2335), reused 2968 (delta 2094), pack-reused 0
>
> Receiving objects: 100% (3362/3362), 56.77 MiB | 1.83 MiB/s, done.
>
> Resolving deltas: 100% (2335/2335), done.
>
> MacOSX:test serdar$ cd code_repository.git/
>
> MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 git
> fetch --depth 50 origin cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee
>
>
> ... and above.
>
> Also it looks like you use ssh so something like GIT_SSH_COMMAND=3D"ssh
> -vv" might help more than GIT_CURL_VERBOSE=3D1
>
> 13:23:15.648337 git.c:350 trace: built-in: git 'fetch'
> '--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'
>
> 13:23:15.651127 run-command.c:336 trace: run_command: 'ssh'
> 'git@git.privateserver.com' 'git-upload-pack
> '\''Casual/code_repository.git'\'''
>
> 13:23:17.750015 run-command.c:336 trace: run_command: 'gc' '--auto'
>
> 13:23:17.750829 exec_cmd.c:189 trace: exec: 'git' 'gc' '--auto'
>
> 13:23:17.753983 git.c:350 trace: built-in: git 'gc' '--auto'
>
> MacOSX:code_repository.git serdar$ echo $?
>
> 1
>
> MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 git=
 gc
> --auto
>
> 13:23:45.899038 git.c:350 trace: built-in: git 'gc' '--auto'
>
> MacOSX:code_repository.git serdar$ echo $?
>
> 0
>
>
