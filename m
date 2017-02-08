Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DDA1FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbdBHK6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 05:58:49 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35801 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbdBHK6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 05:58:46 -0500
Received: by mail-io0-f178.google.com with SMTP id j18so112596879ioe.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peakgames.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kuXxBDbqUeubLWJlNjb3pSA+Jd+T7p2zokM+b8nfEfE=;
        b=WCBAAPvRDoHmPMDr2Wnkj9hOU3l0b+i2DDMelECl+lX/llw0u53b3mUNL8XPM6f+ex
         vhhOCCp3OO/eG+mqgSx773cMuRZzRrt3+xYiDMUKY6h/VTPWXYc0nIETsb/SkAYSsRIn
         RA2R+U+9GAEv5txMkvKiHpmNhCXk7L3ul0gcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kuXxBDbqUeubLWJlNjb3pSA+Jd+T7p2zokM+b8nfEfE=;
        b=n0CSM8Qt9Lsr39dxNJDyD3sDiyZ/qdFX6n6Wi8P//1OA7CquMGLQOsriP9wK8lBLnh
         5yYh6s80mTgBwVh4ZOM9a2r8Rdew3rjtX6exB5VLd//6o9XdZ0/mu07uT/tvybS/DTfX
         UrJKjN5+qehFRVl4dA54y5WDAwu2LdVp1dGCrU0Htd2E0JSVB+JCqtsJDQaNpQsgWrLj
         xXHlGEyhQU94AhEFplcKCNpOu5F8etIlIWphluCAyfciw5KXkUYY/+yEHcjwe55yq5l4
         vTojkxd0nN1KlcwpbEyQQr4RTfKmeKV6/RfHWSAnEFjgQ41ZWHlolvcO4HwzJ6IlLwEm
         ztTQ==
X-Gm-Message-State: AMke39nE6+VRkSUBDEE1Lv6UEftixwxiatJ1XJpnTFDuDWlVM2xm6H+3JuFU+i0WqSZ9mb+mi8R+LtESaeJjgnMN
X-Received: by 10.107.191.130 with SMTP id p124mr8265673iof.131.1486549618023;
 Wed, 08 Feb 2017 02:26:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.133.16 with HTTP; Wed, 8 Feb 2017 02:26:57 -0800 (PST)
In-Reply-To: <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com>
References: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
 <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com>
From:   Serdar Sahin <serdar@peakgames.net>
Date:   Wed, 8 Feb 2017 13:26:57 +0300
Message-ID: <CAL7ZE5yXaJQFci+9aF4+cxeycnf71FMyLTV14t_TGDR3cnnfVA@mail.gmail.com>
Subject: Re: Non-zero exit code without error
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,


We are using a private repo (Github Enterprise). Let me give you the
details you requested.


On Git Server: git version 2.6.5.1574.g5e6a493

On my client: git version 2.10.1 (Apple Git-78)


I=E2=80=99ve tried to reproduce it with public repos, but couldn=E2=80=99t =
do so. If I
could get an error/log output, that would be sufficient.


I am also including the full output below. (also git gc)


MacOSX:test serdar$ git clone --mirror --depth 50 --no-single-branch
git@git.privateserver.com:Casual/code_repository.git

Cloning into bare repository 'code_repository.git'...

remote: Counting objects: 3362, done.

remote: Compressing objects: 100% (1214/1214), done.

remote: Total 3362 (delta 2335), reused 2968 (delta 2094), pack-reused 0

Receiving objects: 100% (3362/3362), 56.77 MiB | 1.83 MiB/s, done.

Resolving deltas: 100% (2335/2335), done.

MacOSX:test serdar$ cd code_repository.git/

MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1  git
fetch --depth 50 origin cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee

13:23:15.648337 git.c:350               trace: built-in: git 'fetch'
'--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'

13:23:15.651127 run-command.c:336       trace: run_command: 'ssh'
'git@git.privateserver.com' 'git-upload-pack
'\''Casual/code_repository.git'\'''

13:23:17.750015 run-command.c:336       trace: run_command: 'gc' '--auto'

13:23:17.750829 exec_cmd.c:189          trace: exec: 'git' 'gc' '--auto'

13:23:17.753983 git.c:350               trace: built-in: git 'gc' '--auto'

MacOSX:code_repository.git serdar$ echo $?

1

MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 git g=
c --auto

13:23:45.899038 git.c:350               trace: built-in: git 'gc' '--auto'

MacOSX:code_repository.git serdar$ echo $?

0

MacOSX:code_repository.git serdar$

On Wed, Feb 8, 2017 at 1:07 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> On Tue, Feb 7, 2017 at 12:27 PM, Serdar Sahin <serdar@peakgames.net> wrot=
e:
>> Hi,
>>
>> When we execute the following lines, the exit code is 1, but it is
>> unclear what is the reason of this exit code. Do you have any idea?
>>
>> git clone --mirror --depth 50 --no-single-branch
>> git@github.hede.com:Casual/hodo-server.git
>
> First, could you tell us the git version you are using on the client
> and on the server, and if this a new problem with newer versions?
> Also is the repos accessible publicly or is it possible to reproduce
> on another repo?
> And what happens using other protocols like HTTP/S?
>
>> Cloning into bare repository 'hodo-server.git'...
>> remote: Counting objects: 3371, done.
>> remote: Compressing objects: 100% (1219/1219), done.
>> remote: Total 3371 (delta 2344), reused 2971 (delta 2098), pack-reused 0
>> Receiving objects: 100% (3371/3371), 56.77 MiB | 2.18 MiB/s, done.
>> Resolving deltas: 100% (2344/2344), done.
>>
>> echo $?
>> 0
>>
>> cd hodo-server.git/
>>
>> GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1  git fetch --depth 50 origin
>> cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee
>> 14:12:35.215889 git.c:350               trace: built-in: git 'fetch'
>> '--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'
>> 14:12:35.217273 run-command.c:336       trace: run_command: 'ssh'
>> 'git@github.hede.com' 'git-upload-pack '\''Casual/hodo-server.git'\'''
>> 14:12:37.301122 run-command.c:336       trace: run_command: 'gc' '--auto=
'
>> 14:12:37.301866 exec_cmd.c:189          trace: exec: 'git' 'gc' '--auto'
>> 14:12:37.304473 git.c:350               trace: built-in: git 'gc' '--aut=
o'
>>
>> echo $?
>> 1
>
> What happens if you just run 'git gc --auto' after that?
