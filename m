Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA3AC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A4246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W22Lhh69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1WxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:53:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:58707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgB1WxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 17:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582930394;
        bh=cae/hpnjSDSOCzqMEGfug9IXHw0o7Kn7wGOB8iSIXOo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W22Lhh690t6pgosbq8FocIQbGy+rMQok1Pm4YCnkh/y6F33wVjWF787NM5jWbmvkS
         TgpQYdbq03qQnCfgHIAPfNJhlnUDhyC9SkpL59KB83j+pQ0s03mbmd/kkHQl4eq4qX
         WRFA/2iMPeqYfIMkozI54Yo/C7XsSMkPU14SDwaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1iq0VP04g5-00HuYZ; Fri, 28
 Feb 2020 23:53:14 +0100
Date:   Fri, 28 Feb 2020 23:53:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     lyle.ziegelmiller@gmail.com
cc:     'Jeff King' <peff@peff.net>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: RE: ! [remote rejected] master -> master (unpacker error)
In-Reply-To: <004201d5edb4$3dc34040$b949c0c0$@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002282352470.11433@tvgsbejvaqbjf.bet>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com> <20200216211604.GE6134@camp.crustytoothpaste.net> <20200218051956.GA1641086@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002272204150.46@tvgsbejvaqbjf.bet> <004201d5edb4$3dc34040$b949c0c0$@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:giIRILuAtEPBF37MPBaQ2M75PMkLMoKAaHdw2+KmAXbOER3zXh5
 DNxvkNo5ABOpEdDSLALB0YpJEnLFKHF7cjV6IsscTVkXOoru9dHgLm7c8fLrHqD/Lb/VaM1
 y8s4zuW8EAzBxMmYZjAkUwyvhwvi1Sw4ZGt9Jrc4/fFSR5omX36rhmpDNFhbTb00tl7C7Cu
 fnQRSZ1dvyPxMgMmahsqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S+FLBuiFAP8=:30qzyme5uroSOfi98GQWXN
 0MqeSj7JJfmwqYZcZn7wbfa/u5tawDtH9OqNb/L7b3sI4RoF93gd8svCrkHKSOAmIhBh1o4w6
 tsR/1r3+5DMuwYwueKbLGMDYEHKhhaDR1foqOILCLIVy5rWBhPi07rilnWl09xunvx4XtYA1W
 rRDDBq2dbhKlAaiPuePMEC/SWhO8tX8mKF8Sfh0Jq31ZzN3hRqdyYObtLabgYcjXtRFcFxaax
 R2C2sFhWKC/IBndbzf5L8sfVQQX+CqKENjnbqiL6cRgLHIN3RZCceh83nvxs+YuQDkRJPZwJX
 DECYtCUnzMwT8iy/XuKpGM8XeA6Ea4m5KNZczHj3XAFmbsizZgsMF9iTC89j7xjAgMUfZNV+O
 uJ3vNKPTn+dL3ACoR+Zq7dJOAUW9YWOi5HHqeqPM1h8Vg8upnuIjNhdD6CnFpjrKT7XpxD5mr
 HkvfEdQxFbQvJEl5+8BuWVWuFzYOpw9BIN2ACe7ihh0ckaey08orCsXX9t6D6jSZKhAJGnHV/
 qu0dKVrCSk2i4ZRkDAkfJ6nvQJ0decJSh/pWYEeoO9zr0rx8m1uHHkb6cQKWFEVBpLCgNTe+9
 gPKx6ScyQSUZYP4U89N0ZgDhyjyFW19q8qefkNanY16MO0M61V9QXMqkRGSPvBKj+2f9t6bIP
 IckrawGdun2sBVjyxks8iUACQMvC0GONWbXcwTAHgWQ6HEoKRcF9N24/5mL7D0EHTMVOx1ekU
 HoHvh5Bp9n2rSTQcrQPRLxxhEzO8uF1reqMUNMtk/leQcuSoBkMmid1nwZJ8KPs2vVOk1n8IQ
 f/yqDS7jkIT5WeFWXMKKM3tuL3QlGAhXFbV5SNUiw/yZ5A3v6ARvvsAVkPwlndNsLpOHfs+CY
 vLvW2QOROBue59d3bSI1NBSbtQ3fFO9VQIbmuPwqkXwbKxoagFuHE5QmvZq7MBQ/esDopGltj
 wz/a9WomrBo72AHmOb3GnhxGFefSxPu4aiCObVxmU0Tgct/IonGyzEcJksZ86eFnV/MiY3QHZ
 bdHFIyqwtb91G/mCImfBnwq6cPELGDQRJaxjZy7MUxJzKv86tRikNEygACLQfGFh1ocWQfwm7
 j5ExEL3Uyh0grwJix1An088DTYEt9oajFfwl/1/nL+UhwP5ERbWWeBNPXq5wEQb2Wg+TLY8kI
 LLYnTKnILhzXPFo+Y0pq0ihdg2QO14gVAIQgfjBlx9UDkczoeOeH9z9Ueoar4p8rvvawubzhp
 Boepas4hg+Qe15QjW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lyle,

On Thu, 27 Feb 2020, lyle.ziegelmiller@gmail.com wrote:

> " But I vividly remember that there used to be a problem even with
> `git.exe`, probably still is a problem on older Windows versions. That m=
ight
> be the problem here?"
>
> I'm using the latest version of Windows 10 and Cygwin's version of git -
> version 2.21.0. This is being executed in a Cygwin window, not a DOS
> terminal.

I was talking about Git for Windows, not about Cygwin Git.

Ciao,
Johannes

> All of this stuff used to work.
>
> Regards
>
> Lyle
>
> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Sent: Thursday, February 27, 2020 1:05 PM
> To: Jeff King <peff@peff.net>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>;
> lyle.ziegelmiller@gmail.com; git@vger.kernel.org
> Subject: Re: ! [remote rejected] master -> master (unpacker error)
>
> Hi Peff,
>
> On Tue, 18 Feb 2020, Jeff King wrote:
>
> > On Sun, Feb 16, 2020 at 09:16:04PM +0000, brian m. carlson wrote:
> >
> > > On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> > > >
> > > > Any updates on this error I emailed a while back?
> > > >
> > > > lylez@LJZ-DELLPC ~/python
> > > > $ git push
> > > > Enumerating objects: 5, done.
> > > > Counting objects: 100% (5/5), done.
> > > > Delta compression using up to 4 threads Compressing objects: 100%
> > > > (2/2), done.
> > > > Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> > > > Total 3 (delta 1), reused 0 (delta 0)
> > > > remote: fatal: not a git repository: '.'
> > >
> > > This error is telling you that Git doesn't think the remote location
> > > is a Git repository.  It could be because it really isn't one, or it
> > > could be that the permissions are wrong.
> > >
> > > It could also be that the repository is mostly there but very
> > > slightly corrupt and therefore can't be detected as one.  For
> > > example, it could be missing its HEAD reference.
> >
> > I think it's more subtle than that, though. If it wasn't a git
> > repository at all, then receive-pack would fail to start, and you'd
> > get something like this:
> >
> >   $ git push /foo/bar
> >   fatal: '/foo/bar' does not appear to be a git repository
> >   fatal: Could not read from remote repository.
> >
> >   Please make sure you have the correct access rights
> >   and the repository exists.
> >
> > The output above, plus the:
> >
> >   error: remote unpack failed: unpack-objects abnormal exit
> >
> > makes it looks like receive-pack started just fine, but something
> > about the way it set up the environment made the child unpack-objects
> > unhappy when it tried to initialize its internal repo variables.
> >
> > I have no clue what that "something" is, though. Windows and UNC paths
> > were mentioned elsewhere, which seem plausible. It mentions ".", so
> > presumably we've chdir()'d into the receiving repository and set
> > $GIT_DIR. Which I'd think rules out any weird interpretations of UNC
> > paths in $GIT_DIR.
>
> I thought that I remembered that it is not possible to `chdir()` into a =
UNC
> path. And it would seem that `cmd.exe` still cannot have a UNC path as a
> current directory.
>
> But PowerShell can, and so does `git.exe`, apparently (I tested this usi=
ng
> `wsl bash -lc "cd ~ && git.exe -C . version"`).
>
> But I vividly remember that there used to be a problem even with `git.ex=
e`,
> probably still is a problem on older Windows versions. That might be the
> problem here?
>
> Ciao,
> Dscho
>
> > I'd expect that error if we did a chdir() internally to some other
> > path after setting up $GIT_DIR, but I don't know why we'd do that (I
> > thought at first that the quarantine code in receive-pack might be
> > related, but we don't ever chdir() into the quarantine dir; we just
> > set up GIT_OBJECT_DIRECTORY).
> >
> > -Peff
> >
>
>
