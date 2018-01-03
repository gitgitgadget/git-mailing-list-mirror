Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413001F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeACDeW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:34:22 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33130 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeACDeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:34:21 -0500
Received: by mail-ua0-f171.google.com with SMTP id n6so258810uak.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Huw3bKf0+XU6M3xeY+3rQhacF3uTat44jIwer1vCpK0=;
        b=XnHqkRnwvosm1W+GNN08tsdz9huCavk1GLGeCfSmAhuC4H/gyKvkiI12VnHZX+LxMB
         o3csAkfyD0D57TNJFEm9A91DH/BGxpZuUFRyfr82p967Zhu8+o2m85Uv0ZsONd4PYh5y
         ywxkCwDhIGcyK8RlnutgyBvAZruhNX/IecjggPZAQHKSHwC5WL0hH7Wu/eXPkO+mcY/o
         ZIh6REatZ5Cm3gKLtSwy9hxVVEqtUhm51RcLVI4bkY+H+s52WG0AN2vVaAK8aoNM4z6F
         HcaWiI/VSXmYvoUDEdSq1rQyQ1s1KelrXNr2yU9yc4My+s4ByvcDooIpeUf8jQ6Ireb/
         WsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Huw3bKf0+XU6M3xeY+3rQhacF3uTat44jIwer1vCpK0=;
        b=OmRW7KGDIpVwQWXNS0Y18VrRUGCdDkFekLyoUj2zVSz1Vot5Cf1+zMDJ5ZrmwyItjV
         AlczfXGkxeC8m3DjWdTjFJ37Ew+/PwDuSiPwGBGij8KmdMnMyxwVdK71XTPZGYhBg32U
         B79mWTJ7pvQ8+9gunczZSVYs5aNMb0hMt6nQih/ACywXS+pVzv7Zxn95Ja+tr6PRblrA
         s7Cz6qR4rtC+prFxfSAx+/MO9sNmwMkPje09IVaqF1um6bbvFB0RqQwv+934dQhzVXfB
         nxQR3sG9A8huKrT+NPjSUQjb6TJYJQYa7PfXkq3G/hXhde1RSZSVzjdrwUKVzouliWF+
         w+Jw==
X-Gm-Message-State: AKGB3mJHq8aAqzIfAGLPQdE6JEyLBBtQ+tCwGG7TlcS41few8AxHtzxX
        ECsAb/VBXuPJPubt3Si6C4F4EYrATsIhFmB31G3juA==
X-Google-Smtp-Source: ACJfBotdbAGKix6NTiWhUlU0l/ABYs5tgdU2DqOp8E8zDuZVlvohO7tZSujnA7uPsXc719k3bf2lmHGkLulC5i12Sq0=
X-Received: by 10.176.96.13 with SMTP id j13mr125231ual.145.1514950459897;
 Tue, 02 Jan 2018 19:34:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.7.106 with HTTP; Tue, 2 Jan 2018 19:34:04 -0800 (PST)
In-Reply-To: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 Jan 2018 19:34:04 -0800
Message-ID: <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 8:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> An early preview release Git v2.16.0-rc0 is now available for
> testing at the usual places.  It is comprised of 435 non-merge
> commits since v2.15.0, contributed by 76 people, 22 of which are
> new faces.

> Brandon Williams (24):
>       ssh: introduce a 'simple' ssh variant

> Jonathan Nieder (10):
>       ssh test: make copy_ssh_wrapper_as clean up after itself
>       connect: move no_fork fallback to git_tcp_connect
>       connect: split git:// setup into a separate function
>       connect: split ssh command line options into separate function
>       connect: split ssh option computation to its own function
>       ssh: 'auto' variant to select between 'ssh' and 'simple'
>       ssh: 'simple' variant does not support -4/-6
>       ssh: 'simple' variant does not support --port
>       connect: correct style of C-style comment
>       generate-cmdlist: avoid non-deterministic output

Sorry for being late to the party on the "simple" variant for SSH, but
we've been doing some testing with 2.16.0-rc0 and noticed an
unexpected issue.

Our test environment is still on Ubuntu 12.04 LTS (it's a long story,
but one I doubt is unique to us), which means it's using OpenSSH 5.9.
ssh -G was added in OpenSSH 6.8 [1], circa March 2015, which means the
"auto" detection "fails" and chooses "simple" instead of "ssh". But
OpenSSH 5.9 _does_ support -4, -6 and -p. As a result, commands which
have been working without issue on all previous versions of Git start
to fail saying:

git -c gc.auto=0 -c credential.helper= fetch --force --prune
--progress ssh://localhost:64281/repo.git +refs/*:refs/*' exited with
code 128 saying: fatal: ssh variant 'simple' does not support setting
port

I know Ubuntu 12.04 LTS is end-of-life, but 14.04 LTS, which is
running OpenSSH 6.6 [2], has the same issue. The following is from a
fully patched 14.04.5:

bturner@ubuntu:~$ cat /etc/*ease | head -4
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.5 LTS"

bturner@ubuntu:~$ ssh -V
OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.8, OpenSSL 1.0.1f 6 Jan 2014

bturner@ubuntu:~$ ssh -G -p 7999 localhost
unknown option -- G
usage: ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
           [-D [bind_address:]port] [-E log_file] [-e escape_char]
           [-F configfile] [-I pkcs11] [-i identity_file]
           [-L [bind_address:]port:host:hostport] [-l login_name] [-m mac_spec]
           [-O ctl_cmd] [-o option] [-p port]
           [-Q cipher | cipher-auth | mac | kex | key]
           [-R [bind_address:]port:host:hostport] [-S ctl_path] [-W host:port]
           [-w local_tun[:remote_tun]] [user@]hostname [command]

Is it possible to adjust the check, somehow, so it doesn't impact
older OpenSSH versions like this? As it stands, it seems likely a fair
number of users who have an SSH command that does support -4, -6 and
-p are going to end up getting "penalized" because it doesn't also
support -G, and have to manually set their SSH variant to "ssh" (or
something other than "auto") to avoid the automatic detection.

I'd love to say I have a brilliant idea for how to work around this,
oh and here's a patch, but I don't. One option might be trying to
actually review the output, and another might be to run "ssh -V", but
both of those have their own flaws (and the extra process forks aren't
"free").

[1] https://www.openssh.com/txt/release-6.8
[2] https://launchpad.net/ubuntu/+source/openssh

Best regards,
Bryan Turner
