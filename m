Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C5E2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 12:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbcLIMAk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:00:40 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38877 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbcLIMAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:00:39 -0500
Received: by mail-wm0-f53.google.com with SMTP id f82so23749826wmf.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u7EP4SqYIPv7VJpJv40BBL7/Tyv6CZnkW1h1f9hQ9Bw=;
        b=AvvX7bkwKabf26iqov/FPGqGF0XRlA5T7xut/h+zzdeDJ15x0jDeNzdKuVBHySy49C
         qI8ONP5QyY296Vn0VQX3uEz+ncn8Uequn9KxKVtUT3jtZSS4WYmkbamdvbxh+lhSLGhh
         m4zMxIIRD9MCcRocYlOxlSU17LqtbbJVJijuOGWroPBJZ6+eeN6bn2DBGTKXFrdsnfxD
         2EVXUVD+nLqYiQUZ0+5XVbaN1UTRYVp4YDOHGaFLu3HfzrQrbhpiO6WqZl1CurTJuNDa
         f8gaDwI1WHyX92CdEUDvi6OwIVcg2fHTVvqc066vLX7muISNSntBOpZ8H8mT4twGawIw
         qCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u7EP4SqYIPv7VJpJv40BBL7/Tyv6CZnkW1h1f9hQ9Bw=;
        b=dsEh4SUfwgQMtndrWRPgDr6WB8VrODlcdr9gAVulHa1Gf/u+gWs/MN30Nl4EtTXwQi
         4FP+7dEY+sA3SHF475WLSXhFeVQ9WgGPm6PRpahnZBqDr2GasPwyRC+F+JNMOyK2/PUQ
         k8mWnbpJoq65Osr4Ti7Xrnd3XBZNjtwpTvS5Wa4V1cCP4EkHH11mAES61Ehvyd12QLkg
         TWGtrdeW8j5JGjMmuAAi87LFa8AznMki6WPldNM4xiGTCkFlFt9MBpacLZupTVm1bz95
         vpHJqrd0Ye4DqnxNfnVSpNfCxKE3+b2NNfXM6l7TB5w2mblO1P8rBvtx0Ie6dSytkBIT
         VSnw==
X-Gm-Message-State: AKaTC01J7wUFHzNisZ42ZBxw84dgL5Mlb6PPD9yVQZYqWdSSyM82fAgF2B0ndbeioJ+vKp/R6b7U6yaqJHeCHA==
X-Received: by 10.25.27.72 with SMTP id b69mr22265996lfb.160.1481284837417;
 Fri, 09 Dec 2016 04:00:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.170.213 with HTTP; Fri, 9 Dec 2016 04:00:36 -0800 (PST)
From:   Paul Boyle <paulcboyle@gmail.com>
Date:   Fri, 9 Dec 2016 12:00:36 +0000
Message-ID: <CABZ0BffSi6h8Zhg8vjo1dZhxXg3fUt_U6TAtqMvpDShOX6HyyA@mail.gmail.com>
Subject: Bug: git-sh-setup giving no such file or directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

There appears to be an issue with the latest master.

"git submodule init" is producing the following error:

/home/paul.boyle/bin/git/git-sh-setup: line 46:
/home/paul.boyle/libexec/git-core/git-sh-i18n: No such file or
directory

Broken sha: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2

Checking out an older version works fine.

git checkout 'master@{2016-11-01 18:30:00}'

Sha: 3cdd5d19178a54d2e51b5098d43b57571241d0ab

This can be reproduced simply by:

make clean ; make ; git submodule init


I didn't track it down further than to a commit sometime in the last month.

Details of machine that this is happening on:

[paul.boyle@gonzo git]$ cat /etc/redhat-release

Scientific Linux release 6.8 (Carbon)


[paul.boyle@gonzo git]$ env

SSH_AGENT_PID=3D29474

HOSTNAME=3Dgonzo

TERM=3Dxterm

SHELL=3D/bin/bash

HISTSIZE=3D1000

SSH_CLIENT=3D

QTDIR=3D/usr/lib64/qt-3.3

QTINC=3D/usr/lib64/qt-3.3/include

SSH_TTY=3D/dev/pts/135

USER=3Dpaul.boyle

LS_COLORS=3Drs=3D0:di=3D01;34:ln=3D01;36:mh=3D00:pi=3D40;33:so=3D01;35:do=
=3D01;35:bd=3D40;33;01:cd=3D40;33;01:or=3D40;31;01:mi=3D01;05;37;41:su=3D37=
;41:sg=3D30;43:ca=3D30;41:tw=3D30;42:ow=3D34;42:st=3D37;44:ex=3D01;32:*.tar=
=3D01;31:*.tgz=3D01;31:*.arj=3D01;31:*.taz=3D01;31:*.lzh=3D01;31:*.lzma=3D0=
1;31:*.tlz=3D01;31:*.txz=3D01;31:*.zip=3D01;31:*.z=3D01;31:*.Z=3D01;31:*.dz=
=3D01;31:*.gz=3D01;31:*.lz=3D01;31:*.xz=3D01;31:*.bz2=3D01;31:*.tbz=3D01;31=
:*.tbz2=3D01;31:*.bz=3D01;31:*.tz=3D01;31:*.deb=3D01;31:*.rpm=3D01;31:*.jar=
=3D01;31:*.rar=3D01;31:*.ace=3D01;31:*.zoo=3D01;31:*.cpio=3D01;31:*.7z=3D01=
;31:*.rz=3D01;31:*.jpg=3D01;35:*.jpeg=3D01;35:*.gif=3D01;35:*.bmp=3D01;35:*=
.pbm=3D01;35:*.pgm=3D01;35:*.ppm=3D01;35:*.tga=3D01;35:*.xbm=3D01;35:*.xpm=
=3D01;35:*.tif=3D01;35:*.tiff=3D01;35:*.png=3D01;35:*.svg=3D01;35:*.svgz=3D=
01;35:*.mng=3D01;35:*.pcx=3D01;35:*.mov=3D01;35:*.mpg=3D01;35:*.mpeg=3D01;3=
5:*.m2v=3D01;35:*.mkv=3D01;35:*.ogm=3D01;35:*.mp4=3D01;35:*.m4v=3D01;35:*.m=
p4v=3D01;35:*.vob=3D01;35:*.qt=3D01;35:*.nuv=3D01;35:*.wmv=3D01;35:*.asf=3D=
01;35:*.rm=3D01;35:*.rmvb=3D01;35:*.flc=3D01;35:*.avi=3D01;35:*.fli=3D01;35=
:*.flv=3D01;35:*.gl=3D01;35:*.dl=3D01;35:*.xcf=3D01;35:*.xwd=3D01;35:*.yuv=
=3D01;35:*.cgm=3D01;35:*.emf=3D01;35:*.axv=3D01;35:*.anx=3D01;35:*.ogv=3D01=
;35:*.ogx=3D01;35:*.aac=3D01;36:*.au=3D01;36:*.flac=3D01;36:*.mid=3D01;36:*=
.midi=3D01;36:*.mka=3D01;36:*.mp3=3D01;36:*.mpc=3D01;36:*.ogg=3D01;36:*.ra=
=3D01;36:*.wav=3D01;36:*.axa=3D01;36:*.oga=3D01;36:*.spx=3D01;36:*.xspf=3D0=
1;36:

SSH_AUTH_SOCK=3D/tmp/ssh-oXONs29470/agent.29470

MAIL=3D/var/spool/mail/paul.boyle

PATH=3D/home/paul.boyle/bin/git:/home/paul.boyle/bin/tig:/home/paul.boyle/b=
in:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/=
sbin:/sbin:/home/paul.boyle/bin

PWD=3D/home/paul.boyle/bin/git

LANG=3Den_IE.UTF-8

HISTCONTROL=3Dignoredups

SHLVL=3D1

HOME=3D/home/paul.boyle

LOGNAME=3Dpaul.boyle

QTLIB=3D/usr/lib64/qt-3.3/lib

CVS_RSH=3Dssh

SSH_CONNECTION=3D

LESSOPEN=3D||/usr/bin/lesspipe.sh %s

G_BROKEN_FILENAMES=3D1

OLDPWD=3D/home/paul.boyle/

_=3D/bin/env
