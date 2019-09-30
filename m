Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422981F463
	for <e@80x24.org>; Mon, 30 Sep 2019 10:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfI3K10 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 06:27:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:49189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfI3K10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 06:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569839240;
        bh=t1oIM/vzEY6Io9bbOoiD7GggVou5Zzg0FXkr00H6Hcg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EJCHV4xC6aSDZs//M8Znw+dc+Rg/3+W0jLD3wfC58JQdS2x2jeEWpgPHxj0brQtuQ
         NUbzM2bkWeCiEgeIsLA8nn6O9I1R9qaP39V3nS+hTznL268vzd9VNRaOhlL4zYYslo
         PNmkiJrZsWnJ2L7+R5+bhdSfEcBcQkMqC2XQOGC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1i3ggZ3XhY-016N6J; Mon, 30
 Sep 2019 12:27:20 +0200
Date:   Mon, 30 Sep 2019 12:27:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Thomas Klaeger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Klaeger <thklaeger@gmail.com>
Subject: Re: [PATCH 1/1] git-gui (Windows): use git-bash.exe if it is
 available
In-Reply-To: <20190926215737.aq4z2vhfrl6j634r@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1909301225300.46@tvgsbejvaqbjf.bet>
References: <pull.360.git.gitgitgadget@gmail.com> <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com> <20190926215737.aq4z2vhfrl6j634r@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1187437232-1569839244=:46"
X-Provags-ID: V03:K1:7e+kBwRzxF2YKBP7wd/XLhX86pl8AYGeExfzoOliCDmsiuNwi7n
 XudO+NuXTbcK0s30+ZrDWuqMFMJqYKD3VwBp4yIdQZnjKXIu0+i5FtcRr/ra8y9pLPQ42A2
 Jn/CWwZP6jbmmChggIFwDymPSaRrGsnP2yW/SFsTabGs3SAhAIuj9ZKEVC+w84+xcaFB6Vm
 y07Op3zrMTtVIpi0F1ODA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YTrq8wQA7qc=:JmFYrF1CsSu71ilocAHjpS
 ADFxnVQzCDbxK+ZXTi6OTds2P/4+fgDOO1+U5QJJ+u4k4whopWavNo7RveVVJW2P98f6NSgv/
 LX7CtZ8pCk7CA5hYCsmz+Oj15bs/dRbMTbAd+9WeRg+0Di+KMUZY/c7XeSq6WCr+DVcyIApzC
 VarSlkpCluj/tr3iURfKE020eeFCTwvtCCNVPsblx9HsBHGV/JYlzH1axlfI4P2D5d0/2iO4b
 kw6cm+mMndOssrrmPe2284eqatgVKhNa2WIoM6/lu4IcnsQJueXFdK4wlLrh+ot6Zbf15PDZD
 00jpxHrU510YSeosQoAy8H1bbZj/ecgYmuOxoRVDG6QcWhTSrMxxsWODyMUlgdWDgPtoGu3dT
 KzZru9sK+PROADxPrDkUc52fezHOyOvw0itVFVsd+xIvyDZpfxZKfTNNUAYCOiMxkr/FiqhAP
 5uObyRlyyI86ZrTRcgWWIpias3GUEqKJMW17VKEaxhfqQ0fqhNUiz5yw5ZYf9ZjzuDg1CjVjx
 lHkCbrz2iwtbRu0vzoVSwS1uVaD7X1Eg9elh2Ou4J01zL78jm4Lq2rgZrM8WQdpwQaksKpHdR
 TsELjqYsxQoeKhUWAfpGpMmEJzSpdPYRMFF0R8GQCTtPwretcl4lUjWFgAqhg18Gk/JRudGz/
 bVFgqecuGnMzmaq23Tp8BV0GXhJjt1CJRGPc0bVj2XJ9+8zhMXa3hBlZY5pMuHMzr5tWxhKkf
 i40KMehr1R2Vaj8B/CM9aQH5N4qbczYTeG7aGnC4Z0+tXl1J1GagCLG9dUgix8NgbSeiyeqTx
 L77IsN3ncxaEvwvm96rNTRIti4pq760WywxgrUuYXluwPrN7iYBIt2xcoebgYgZOJ+6cmxo1x
 qwUioahdDUO5ifoqG1ym0irx+Mnl6Fa+SVYZapjs8gZCCQYbt7KLXfITb1hDEylcCssvgNMw2
 EeK+PuoyWFWWW6kzcGTZ3nnTKdWtBZSmlnsB0IYwHX11lmYWQ5NlincxemBi3b2Em0dl1t4EB
 cFW3uD2nXnl3EjbIpUIzTcsZcpVyChvDxiXJQhkuDVHKdlHLClUQb9z390iKsrwrEOWkRKJaB
 sTiJRv4OzXBFGkT7LIjJp7aGjZHzA0SjpV46antpc21pWjpSYGqmeAotNQQXfCX7+pY8HT1RF
 jE/E8DdYt3YsrE/wZUeu5f3PMFUCBdu9KAlkqMbbJGYA2THpfqTOIHKjdgnXUyp2N/w9To04B
 58Y8qgzGqNx+MvL4bDb9di/EpYfCpqVtB2feWVsRJ+UDtPxLXNUDOtJysS1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1187437232-1569839244=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 27 Sep 2019, Pratyush Yadav wrote:

> On 26/09/19 10:46AM, Thomas Klaeger via GitGitGadget wrote:
> > From: Thomas Klaeger <thklaeger@gmail.com>
> >
> > Git for Windows 2.x ships with an executable that starts the Git Bash
> > with all the environment variables and what not properly set up. It is
> > also adjusted according to the Terminal emulator option chosen when
> > installing Git for Windows (while `bash.exe --login -i` would always
> > launch with Windows' default console).
> >
> > So let's use that executable (usually C:\Program Files\Git\git-bash.ex=
e)
> > instead of `bash.exe --login -i` if its presence was detected.
> >
> > This fixes https://github.com/git-for-windows/git/issues/490
> >
> > Signed-off-by: Thomas Kl=C3=A4ger <thomas.klaeger@10a.ch>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-gui.sh | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index f9b323abff..5a1bfd736e 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -2700,10 +2700,18 @@ if {![is_bare]} {
> >  }
>
> This hunk is kind of hard to understand. I'm writing what I make of it.
> Please correct me if I read it wrong.
>
> Since this is a 4 year old commit not even authored by you, you might
> not have all the answers. That's OK. But I'd still like to point these
> things out. I do have a question at the end so please read the entire
> thing :)
>
> >  if {[is_Windows]} {
> > +	# Use /git-bash.exe if available
> > +	set normalized [file normalize $::argv0]
>
> argv0 would be the location of git-gui. We get an absolute path for the
> git-gui executable in the variable normalized.
>
> > +	regsub "/mingw../libexec/git-core/git-gui$" \
> > +		$normalized "/git-bash.exe" cmdLine
>
> This finds the install location of git-bash by doing a string
> substitution. I'm assuming the path before /mingw.. is the installation
> directory of git, and so that's where git-bash would reside. We put that
> directory in cmdLine.
>
> Nitpick: most of the code here uses snake case. So s/cmdLine/cmd_line/
>
> > +	if {$cmdLine !=3D $normalized && [file exists $cmdLine]} {
>
> Why the $cmdLine !=3D $normalized? When would they be equal? The string
> substitution should always change $cmdLine.

Except when Git GUI is installed in an unexpected location. This check
is purely defensive programming.

>
> > +		set cmdLine [list "Git Bash" $cmdLine &]
> > +	} else {
> > +		set cmdLine [list "Git Bash" bash --login -l &]
> > +	}
> >  	.mbar.repository add command \
> >  		-label [mc "Git Bash"] \
> > -		-command {eval exec [auto_execok start] \
> > -					  [list "Git Bash" bash --login -l &]}
> > +		-command {eval exec [auto_execok start] $cmdLine}
> >  }
> >
> >  if {[is_Windows] || ![is_bare]} {
>
> The way of finding the path of git-bash is very hacky and would break as
> soon as there are any changes in the install locations. Plus, it is not
> at all easy to understand what's going on at first look.
>
> Is there no better way of finding out git-bash's location? Is there
> something like the PATH environment variable in Windows that we can use
> to locate git-bash's executable? I have never developed in Windows so I
> have no idea how things work there.
>
> On Linux for example, the exec() family of functions look into the PATH
> environment variable for the executable, so it is a pretty clean
> mechanism to execute programs.

That's not an option on Windows. `git-bash.exe` is not intended to be in
the `PATH`, specifically not.

The implemented method is the best approach we found to determine the
location of `git-bash.exe`.

Ciao,
Johannes

--8323328-1187437232-1569839244=:46--
