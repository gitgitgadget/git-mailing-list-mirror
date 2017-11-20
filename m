Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94353202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbdKTSMg (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:12:36 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:44725 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdKTSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:12:35 -0500
Received: by mail-io0-f169.google.com with SMTP id w127so16652404iow.11
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKvqFE7PT3YUr7PzTfrNsEAJzz75j2HUvgAFBxMwOQU=;
        b=upSggObpO0BcvIgcbSg7Be8Rg7myif2D/xkbU+fCKcHS6/KeBoiZnTzQTA/LKTkffa
         QQ+NbmKUJVOw3j3NQ6LnEZ/TPKDKVaOR2HkS7GmW03zLGG8BZ/cCyYNFzhjMOPK4CCDM
         8A8D+TuVXWohl2ax6YhVEYHG1X/q+fqQ4Xvr1ByxoBRwgRhtnvLlDA1DJZAK4chGHusT
         km6Zw+y1X2NA4MiLMyt+ldpDKgLly6amz9lNasntPtoXVtgwbjbXxK8BWQ2blzawwSXb
         jlqmzviSoEkH3Z32/Oz01qFyhOWrwSOPBVmPp6spXaPXHpL2MCqT60dac00F+uzPMmqt
         VYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKvqFE7PT3YUr7PzTfrNsEAJzz75j2HUvgAFBxMwOQU=;
        b=AI7CJ9oaKWhCXYSPDHjL/HP8rzIDgMQCoqjGFvtaPA3ATT77sBTKyFQhpgsKheW84N
         M/3SCZ3jp/nn1rIofe5PYDTAZ8E4oW07SIGGgfl1q1ZTNlsKu1slKI0/fy+JdC4M23kr
         BTvTAlpFucDVMspesuaasBRDl10AsbiXNW7m+qGOVTqGUGJ89kCKaMu3ZIk0g6+A6vYJ
         op/QIvaYPbtu05a/tIx/0IXVM+HLacdZDrDEAYPQy7m20iaQKvKzA7FYSsGW+KzawE7H
         pd+mzsy5AYIB9gVY84iQ+TBbTqsYGvrBl3fhx1/847R/TU0A/ScwkEvHcGbnNGLlk3hk
         Jh2g==
X-Gm-Message-State: AJaThX7TojfrULqRwOwB5O2rUFLrm1IoEwAdD3QotqWTk+yRkHXyB03p
        liP+LnJu/hD0yMJas2VES74Uk/oJQ9eXeWgp3BY=
X-Google-Smtp-Source: AGs4zMaPYef2Ydrql6X2zPX63/mqjxHsotNYiCJRB/GhL8QBBf6yA09Eh2TLOMTnAllY4MTGyiBj2J4RXfEu5XdSHQ0=
X-Received: by 10.107.20.21 with SMTP id 21mr15363998iou.116.1511201554058;
 Mon, 20 Nov 2017 10:12:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 20 Nov 2017 10:12:33 -0800 (PST)
In-Reply-To: <20171117174258.GP3693@zaya.teonanacatl.net>
References: <20171115125200.17006-1-chriscool@tuxfamily.org>
 <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com> <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
 <20171117174258.GP3693@zaya.teonanacatl.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Nov 2017 19:12:33 +0100
Message-ID: <CAP8UFD23ALBQO=kfeKrf4YXFigtC79mLtnBuXtTgjbeqPFE76Q@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 6:42 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Christian Couder wrote:
>>
>> On Thu, Nov 16, 2017 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>
>>> I suspect that this change will hurt those who package Git for other
>>> people.
>>
>>
>> Maybe a little bit, but in my opinion it should not be a big problem for
>> them to install Tcl/Tk and its dependencies on the build machine.
>
> It's not a big burden, but it is a seemingly unnecessary build-time
> dependency.
>
>>> It used to be that, as long as they have msgfmt installed, they only
>>> needed to _know_ what the path on the users' box to "wish" is, and set =
it to
>>> TCLTK_PATH, and if they are distro packagers, most likely they already =
have
>>> such an automated set-up working.  Now with this change, they are force=
d to
>>> install tcl/tk on their possibly headless box where tcl/tk is useless, =
and
>>> worse yet, an attempt to install it may bring in tons of unwanted stuff
>>> related to X that is irrelevant on such a headless development environm=
ent.
>>
>> Yeah, but if they build gitk and git-gui, there is a significant chance
>> that they build other graphical software too, and that this will require
>> installing stuff related to X anyway.
>
> Most distributions build packages in individual container or chroots, to
> increase the stability and reproducibility of the builds.  So package bui=
lds
> don't run on systems where any deps have already been installed.
>
> To be fair, it looks like pulling in tcl/tk would add only around 8MB to =
the
> Fedora build root for git.  That's not egregious, to be sure.  But it rea=
lly
> isn't a necessary build-time dependency either.  I don't know if there ar=
e
> other distros who would strongly object to pulling in tcl/tk.  Some are m=
uch
> more sensitive to build root sizes and unnecessary dependencies.

Yeah, I still think that when packaging graphical tools, packagers
should be used to managing builds that need a lot of dependencies
(especially X related dependencies). I used to be a KDE developer in a
previous life and the amount of dependencies to build KDE was much
larger than what is required for everything in the git repo (git,
gitk, git-gui, git-svn, etc).

>> In general I think packagers are much more able to deal with those kinds
>> of problems than most regular developers who want to hack on Git.
>
> I agree.  Packagers also provide git builds to the vast majority of
> end-users, so we should make their task easier whenever possible. :)

Yeah, but you might have noticed that such checks might be a good
thing for packagers, as it makes the build fail right away with a
clear error message. So in the long run, I think this kind of patches
will make it easier also for packagers.

>> So asking packagers to either set NO_TCLTK or BYPASS_TCLTK_CHECK or to
>> install Tcl/Tk would not burden them much, especially compared to what
>> regular developers have to deal with these days when trying to build Git=
.
>
> Presuming this new BYPASS_TCLTK_CHECK is communicated well and that the
> failure when not using it is clear, this doesn't seem likely to cause
> problems.

Yeah I agree.

> (I'll leave it to others whether there's a better way to solve
> the msgfmt fallthrough issue.  I didn't even know such a fallthrough exis=
ted
> until yesterday.)

I might also send a similar patch for the msgfmt issue, otherwise it
may be a good #leftoverbit for someone starting to hack on Git.
But anyway it is a separate issue.

> I think it's important to ensure that automated package builds of a newer
> git don't simply skip parts of the build which used to work and so packag=
ers
> reading the failed builds logs can easily see what they need to adjust.

I agree and the patch doesn't skip parts of the build that used to
work, and actually it makes logs easier to understand and build
failures easier to fix.

> Just dropping the new variable in the Makefile and waiting for package
> builds to fail or not package gitk & git-gui at the next release would be=
 a
> bit unkind, I think.  Posting this to the git-packagers group[1] which =
=C3=86var
> created would be useful.  It /might/ even be worth asking there if any
> distros have strong opinions on the subject.
>
> [1] https://groups.google.com/forum/#!forum/git-packagers and
>    git-packagers@googlegroups.com

I cc'ed this list when I sent version 2 of the patch.

>>> I think "If I cannot run either wish or msgfmt, then barf and give an
>>> error message" might at least be needed.  Am I misinterpreting the
>>> motivation of the patch?
>>
>> I'd rather add a separate check for msgfmt than mixing the 2 issues,
>> because I think that unless it has been explicitly told to do so, Git sh=
ould
>> not try to build git-gui and gitk in the first place if there is a big
>> chance that those tools will not work.
>
> If that's a motivation, wouldn't a check in the gitk and git-gui scripts
> handle it? That would provide an error at run time to the user.  This
> change is about helping the user who builds their own git and then runs i=
t,
> so if they built git without wish installed and then ran git-gui, they'd =
get
> a clear error that wish is missing and could easily install it.  It's not
> needed for the build, so they wouldn't need to rebuild anything.

This change is not just about people who want to build and run those
tools, but it already helps them by improving build error messages a
lot.
