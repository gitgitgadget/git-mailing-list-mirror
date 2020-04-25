Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524BC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6062071E
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Uptr6WAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYMYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:24:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:46533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYMYj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587817474;
        bh=roAPEHSZTsW/K7pGuoick6JYJuYE3WdjzaGT9b25yEI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Uptr6WAzb+XnM39lww3Rn6oDYeEtnNGi85wBftwUfhaDBiiOZdg+ckHLYSjD3TV3C
         yzYHR1z4GOHGegSY82BoNwDZyOCssnjT1gUjA9tFdbDtxGsDtyhkv53LQl/5VLBFBH
         sqr1MNF/mODKlaCPQ9u2ZTGvmE+bwQv4vQemGSPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1McpNo-1itoO01imw-00ZzSY; Sat, 25 Apr 2020 14:24:34 +0200
Date:   Sat, 25 Apr 2020 14:24:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <xmqq8sikblv2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>        <xmqqv9lod85m.fsf@gitster.c.googlers.com>        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k9lSqgbeUsShysGHu4FcaabvM1RarrUDlFaxMBQD+ahTQYmmFZj
 NNpWF/O0p2+7N3l6ipwuhjOnHc252RQVmFcPG6gKWz0wCtqX/+6m4bGMbK6oWprtG051f7R
 UwzCv6jgWa/tMM+AVuYeFFEr8rS9FFdzqVCpXW3ryUEp5ep5OVoC4cvA5N/uU8epNI9zXZA
 /x63IcdK0/IQ4VDLn979A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHThH1+V5zo=:g+GrfxzX2i/344G7EtkoGv
 2tl42migd7/HCkT4vCKYZkfnzTZr3qN49NWRSlVdi5dvPdkaSQzOf/yi0IdvMFNKIiGdQARUh
 4ZLM5C/OJ4BiczcomD7cfLnNwQozMtD1EeRtBpLhPdQDBLHI10UlkI4fbYYIYDAFHAyTOOfSN
 KSplEx8sU17PRWsg538uSi8l739Jy58Uxo+9IOoOih0lF0M2TPGUvXIQtGQgiA0fiQBL4ifhS
 HtjDtbAogdRB+qWbF+YrUVphEKVYpwhsaL8hj3IXrR9WaXZd/bRs3//5L2pFqJDsBcERDKHXH
 IEOigP/YUmjuQSfzTPpX5DUcroDVEdx6Pn5yXfwWizWPw17YrxffE1/HQSngAup0/hN5xk1xh
 EGzZFlFpgDj5F8DEE00EcMgGFLG47Mx1p/E/X8WNCnQi2TlBuoEJSNw5WKjn+LXBWKa7g3p7t
 qQ4wVG0wHKW7Yq1Kr+XB3V2pntnT1cPHkf4wfenkUTcWNnhcamUXjQdO0LWTQA6iwDQzJ1zsG
 yTSWZZ8Q7O8aB5FBlzBIqU6WzBhRpv2d+MK+oh0a2WqNiq/ywQ1/40DKkX04/mD/Mr9hRH/Tf
 s13HhzoyECkJumufHoEsEK/PbrIwAHfJDR4ShuLkYCwIMOGNbISQ6KN8Ad+bg9J4fYiJJVx+G
 fS2VCAnA3tWziUFhc+4DzT4l24BZn2yM+Hqe57z3me7KYEZSkZT3+hZrJ8LvorEDQ5gHevPve
 tjdjV06Jx5jM2WdEJy4hp/eNSFD/KzI6FhtKtWsCmKBD3EuCZIGIzDJOsDAanQ/wuHztoAA5p
 pkIVy9O/CuCpMFt4mkWRgQ2bzNI5PrsW67v6B4fS6lgJc3jEbnC6k5hl512QoMArRraWr127v
 f9ITLfUdsQuY0dWfT2rYCMGSQd49zTdzHBUEEdh/9FIvwwpZkuXcOQMDkNUAftEbU5cxg5j8h
 +GE9Vbj7ZNHMuG5msjZ5MSjoqHB3qtJb1WGMIF67/7kXPRAQReR9uyNEk8ToEPkWMTyCM7sN8
 GKoUsemUKmzKu/PgsB51P9gm/+zZJGVduGPPk6QD9BYls9tO8C8oHwdr+UAO9YAhx5v6ixKlE
 p6rwWpPKXQVt/zBUj1zVIB4GIk/BhTrRF4E8Ue7BgBiAurKK/R6QGx3iczMP/fp1D2zSQWoN/
 RdClhVgZ7SDTDdwPfpY8NT8I8BE5JEUthK1Lm2bu8MsEuMs+JyreBvRTJxsnKTQwGQvwyCNZM
 SLK/0MdjAaL+Gg+MA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 24 Apr 2020, Junio C Hamano wrote:

> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > The goal would be to maintain a CMake build for Git keeping it in sync
> > with the Makefile. The Makefile is not going to be replaced at all.
> > The CMake script for now only supports Linux and Windows. It does not
> > support BSD, Solaris and others, whereas the Makefile does support
> > them.
>
> So you are doing (1).  I already said that I feel that engineering
> burden to divert resources for CMake support would be unacceptably
> high.

Would your position change if Sibi was interested in maintaining this, and
helping with keeping CMake support in shape?

If you have a look at https://github.com/git-for-windows/git/pull/2580 and
at https://github.com/gitgitgadget/git/pull/614, you will probably get the
same impression as I: in contrast to earlier contributors who just talked
about adding CMake support, Sibi went ahead and did it, and then polished
the heck out of the patches, was very responsive and active.

I have a pretty good feeling about this.

> Whenever any of our developers need to add source files, Makefile
> configuration knobs that people can add to config.mak, etc., you are
> forcing them to figure out where in the CMakefile to add them or devise
> ways to allow builders who do not use config.mak (because they use
> CMake) to do similar tweaks.

To be honest, I don't think that that happens all that often, and quite
honestly, I think anybody who has had a look at the Makefile and at
CMakeLists.txt will have a pretty good idea where new files should go.

> Any patch that is acceptable to the current project would become
> unacceptable because they lack updates to CMake part, but I suspect
> we do not have enough people who are so much devoted to give a good
> review if updates to CMake part are added.  And it is unclear why it
> would be beneficial to slow our existing developers down by forcing
> them to become familiar with CMake.

When it comes to new Makefile knobs, I do agree that it would place an
unacceptable burden on contributors if we expected them to add the same
knob to CMakeLists.txt. But we already don't do that for our autoconf
support, so why would we expect it for CMake?

When it comes to adding new, and/or removing, files, I fail to see the
problem. It is dead easy to keep the Makefile and CMakeLists.txt in sync
when it comes to lists of files.

Another thing that strikes me as much more favorable this time as compared
to earlier attempts at adding CMake support is that we now have pretty
good automated builds that will definitely help with keeping CMake support
up to date.

So now that I have covered the "it's not all that bad to maintain this"
angle, let's cover the much more important part: "why would we even bother
with this?". And that's pretty easy to answer for me: first-class Visual
Studio support.

It is totally unacceptable to expect a contributor to download three
quarters of a gigabyte and then let the Git for Windows SDK occupy around
two full gigabytes on disk, just to get going. This is an upfront cost we
currently expect from any developer on Windows, whether someone familiar
with Visual Studio or more familiar with the command-line and GCC or not.

And guess what? Whenever I try to encourage a developer who uses Git and
who is pretty good with C to "just check out the Git for Windows SDK, run
`make vcxproj`, then load the generated Visual Studio solution and then
start developing", the odds are really, really, really high that that's
the last of it.

This is frustrating. And not only for me: Why should a contributor fight
so hard just to get started, when all they want to do is to tinker with
the code in order to see whether there is a chance that they can easily
make it do what they want?

For some time now, I have an automated build which auto-generates the
`vs/master` branch from Git for Windows' `master` branch, which has all of
this preconfigured. But it is too hard to find, and it is definitely too
hard to go from there to contributing the patches back to the Git project,
so I think that maybe one contributor used that venue in the last years.
One. Just one. That's very little return for the effort spent on getting
Visual Studio support back to functional ever after it was broken with
Visual Studio 2010's release. And it demonstrates a level of being
uninviting that I am simply uncomfortable with.

There's more.

If you are a developer who feels at home in IDEs, running `make` in the
command-line, and finding out about options in the Makefile and how to
specify them on the command-line, is just very awkward. CMake recognizes
this, and offers GUIs to configure the builds. So that's nice.

But there's more.

It would appear that in recent years, ARM64-based Windows laptops have
made great progress. They are affordable, they are fast, and they have
long battery life. If I could use and develop Git for Windows on one of
these beauties, I would.

But I can't, because the obstacles to building Git on ARM64 Windows are
just too high. The mingw-w64 version of GCC "does not really support"
that. We have literally no ARM64 support whatsoever from MSYS2's side,
i.e. no Bash, no Perl, no OpenSSH.

And then Sibi comes along and offers CMake support for Git.

CMake can target Visual Studio and clang. Both have pretty good support
for ARM64 Windows.

So while this is not a complete solution for the ARM64 Windows problem, it
is at least the most exciting opportunity in that regard that I have seen
in _years_.

Given all these benefits, I would like to believe that the cost is rather
minimal in comparison.

And that's coming from me, who is not a fan of CMake at all.

> So..., I am not just "still not convinced", but I am even more
> convinced that we do not want this series, after thinking about it
> longer.

Of course, I do hope that I have convinced you above that it might not
look all that bleak.

But even if I haven't, I would like to propose to run with Sibi's patches
and merge them first to `pu`, and then to `next`, and let that cook for a
while (I will merge them into Git for Windows early so that there is also
some support stream from that side).

I know you think that the maintenance cost is too high, but I think it
might be more than just manageable. And I don't think that the risk is too
high to give the patches a try, at least inside `next`, for a couple of
weeks or even months.

If it turns out that they _do_ add too much of a maintenance burden, big
deal: we just drop the patches, and that's that. No hard feelings, we gave
it a try, a scientific test, if you want, and we now have evidence to back
up your initial suspicion.

If it turns out that they _do_ add value _and_ are easy to maintain, then
that's good, right? And then, at your leisurely leisure, you can merge
them down to `master` and eventually into an official release.

What do you think? Doesn't that sound like a good plan?

Ciao,
Dscho
