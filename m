Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCE61FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdEPU1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:27:01 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35741 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbdEPU1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:27:00 -0400
Received: by mail-yw0-f172.google.com with SMTP id l74so44240943ywe.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r7VAXxAwMAwGAKDsCjHuf+V+dJMEdPmXwNfeKNiG5vE=;
        b=stvU4Gu59shiMof0KY/Q0cJJRaylEVZ+/DFnOsZaeMYnB0YVlBvdT2YIv9ggYDwv5c
         q3HlxL53tX0tTjP0XZdb/GrztljbXF5kbY9BJFzh1NxFBkCtkhAMYya80rz5x/JtL4w9
         l2vcXMBRAr14Jb+WozxgFUWwEOW2uew7fwn6ABdHO+bBAJ7IVU25KtwfoJLBALzfJbbt
         d6fl8v/yB6b9MuRDEa8+2PPwzVdlWOInnd+a23mX0dKAnCWY1JMYkChK5j3xm1T+F1l5
         f2yzFg6JTYLuH1968yUIXupflM+zoxqPbJ8txJedAe0FfLH1TpFv1o203ZQAOzUEeVac
         ogEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r7VAXxAwMAwGAKDsCjHuf+V+dJMEdPmXwNfeKNiG5vE=;
        b=NcHcpvx9SIPw+A14DuUmMjnyyCM7GXAQLGHCyV0Wh81kl+P7tIDvunT/Zqj2N6JmDm
         uT0avAgAzPcMILrdFAVlux0wcjBpUjx3qMN/FJcvODOrmba1dR3tYV6fBA6YV2erpRr3
         VvQwKPs5nbk2JVNHL7iNpp9PgHSvnGwLlwkuUcQkz8xwFTIkjoGuUexO3z03r4jEJJck
         VunMowdeL0lPcGA7OU7joLZLfsKfUMH1I4no4A9FK9m3bOO647X0KJMN3UWn4binw2RK
         UU0zt/IvgG7bvFLCb4dSZYGkA00rpJsPyHoSazG2dLqIa0y0Hlch2ywK0sNkZyTXf63D
         t7Vg==
X-Gm-Message-State: AODbwcD/D9FHJTzrHCqGC50s45godSZAh1SRGxV2GInsS9bZHqMZFrC2
        w8+aYSMKH6YNr4AKP8Mv2lbkVqR6xJXG
X-Received: by 10.129.163.67 with SMTP id a64mr8819513ywh.138.1494966414550;
 Tue, 16 May 2017 13:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.44.70 with HTTP; Tue, 16 May 2017 13:26:53 -0700 (PDT)
In-Reply-To: <20170516103836.GB2169@alpha.vpn.ikke.info>
References: <cf9ce8e9-a358-4fdf-aa7c-a8ab76b6429a@gmail.com> <20170516103836.GB2169@alpha.vpn.ikke.info>
From:   Thomas Schweikle <tschweikle@gmail.com>
Date:   Tue, 16 May 2017 22:26:53 +0200
Message-ID: <CA+rGx5ctrWps8JTvxL9Pn=o=QfmD+JbJU0QHBoJ9JJYt1A0Lgw@mail.gmail.com>
Subject: Re: Cant clone/pull/fetch because of "Unable to create temporary file '$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_'
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-16 12:38 GMT+02:00 Kevin Daudt <me@ikke.info>:
> On Mon, May 15, 2017 at 12:28:58AM +0200, Thomas Schweikle wrote:
>> $ git clone
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>> linux-stable
>> Cloning into 'linux-stable'...
>> remote: Counting objects: 5932092, done.
>> remote: Compressing objects: 100% (154131/154131), done.
>> fatal: Unable to create temporary file
>> '$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX': Permission
>> denied
>> fatal: index-pack failed
>>
>> Since no file/directory created by git I cant tell why git isn't
>> able to create
>> "$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX".
>>
>> If I try to create this file and directory I can create it:
>> $ mkdir -p $HOME/Dev/linux-stable/.git/objects/pack
>> $ touch $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
>> $ ll $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
>> -rw-rw-r-x+ 1 tps tps 0 May 15 00:18
>> /home/tps/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
>> $
>>
>> $ git --version
>> git version 2.11.0
>>
>> --
>> Thomas
>
> Note the '+' at the end of the permission list. This means an acl has
> been applied to this directory.
>
> What does getfacl
> '$HOME/Dev/linux-stable/.git/objects/pack/' return?

since non of "linux-stable/.git/objects/pack" is created, I can only
have a look at what acl the directories have if I create them:

$ mkdir -p $HOME/Dev/linux-stable/.git/objects/pack
$ LANG=3DC getfacl $HOME/Dev/linux-stable/.git
getfacl: Removing leading '/' from absolute path names
# file: home/tps/Dev/linux-stable/.git
# owner: tps
# group: tps
user::rwx
user:root:rwx
user:500:rwx
user:nobody:---
group::rwx
group:uuidd:rwx
group:crontab:r-x
mask::rwx
other::rwx
default:user::rwx
default:user:root:rwx
default:user:500:rwx
default:user:nobody:---
default:group::rwx
default:group:uuidd:rwx
default:group:crontab:r-x
default:mask::rwx
default:other::rwx

$ LANG=3DC getfacl /home/tps/Dev/linux-stable/.git/objects/
getfacl: Removing leading '/' from absolute path names
# file: home/tps/Dev/linux-stable/.git/objects/
# owner: tps
# group: tps
user::rwx
user:root:rwx
user:500:rwx
user:nobody:---
group::rwx
group:uuidd:rwx
group:crontab:r-x
mask::rwx
other::rwx
default:user::rwx
default:user:root:rwx
default:user:500:rwx
default:user:nobody:---
default:group::rwx
default:group:uuidd:rwx
default:group:crontab:r-x
default:mask::rwx
default:other::rwx

$ LANG=3DC getfacl /home/tps/Dev/linux-stable/.git/objects/pack/
getfacl: Removing leading '/' from absolute path names
# file: home/tps/Dev/linux-stable/.git/objects/pack/
# owner: tps
# group: tps
user::rwx
user:root:rwx
user:500:rwx
user:nobody:---
group::rwx
group:uuidd:rwx
group:crontab:r-x
mask::rwx
other::rwx
default:user::rwx
default:user:root:rwx
default:user:500:rwx
default:user:nobody:---
default:group::rwx
default:group:uuidd:rwx
default:group:crontab:r-x
default:mask::rwx
default:other::rwx

git should not have any problems creating files and folders =E2=80=A6
but git wont even create linux-stable!

--=20
Thomas
