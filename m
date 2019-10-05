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
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CC31F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 19:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfJET4v (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 15:56:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:52975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfJET4v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 15:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570305407;
        bh=VuUbn3Jngrm0NJiQ93nxrE2dO8nETYPfjobnIZjX1tM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BqCLJ7E44TZIWtw1R8j9TrNpnGbGkDTq5NllKlDr781PLhzPmXZ5kvYglio283NBh
         Sa/no/96E7pGlS12Q0bXQL0fsypk2mAqcMsD4DkfZXSqcxeaXDYaKo1jCjCGsbkQLN
         o7fo4idKrAw4qa6OFA5rCWFAl/b08mHgRQUH5pRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1hmPDp20BO-00nBeR; Sat, 05
 Oct 2019 21:56:47 +0200
Date:   Sat, 5 Oct 2019 21:56:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: add a readme
In-Reply-To: <20191004221052.23313-1-me@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910052149490.46@tvgsbejvaqbjf.bet>
References: <20191004221052.23313-1-me@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u+KqGw008xL0+neh6wSN9ywlVXn8VffZ4uEXrx2ahH3RLQRczBm
 c9jpi37u4OyU4of0RPzu4iktkGH7lNSsRoG3iuPHVT5jvDIG5DqqbhEKYapOSx5i7nlV5fy
 ItKDiqXB/f+zWiH1pJHTnErE4vWe3xpa9DRhN6Ek1jQhhP+UZGrYI3L+DVj22yL6ZVoIONM
 0I9OqaFfkO1lgLswVFtmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sEFSvWHjBJ8=:jIt+t9VcIZAWWC9jTpmGZU
 pmOKmDeneyKP7ZJz+jTTaKLwcv2C32E1b9nwe8w7hNnCsqiu2Ji1vt0FuIK0LljL8BJnpOnp/
 KBryZ0pX6DqtJ64kYwbqbdhBOae0/A+zPngxpWeB4RG7EIgZHyneY0KvvviBWsAADOAcvIfeg
 jXl/3s3FW4If6OFXPEQrsXi0EWhl9vrs9flQhrjpIP0zJYh11zEiDKhgIg7t6dm7Mi0qSqFRi
 j9PSSKPpLZa6MNFcAdcRJiytIZldf9o4fiNym2Q2J3MmADYUcOgFEoL237AnH+Nki+XP0I7Xr
 n8UYYhFY8mVBbonnTQyRMIkRQJzK/ygUzsYTkwBi2/J80F+np9AAVDzF7aYx3NxI9LEtdPtwL
 BEKHMGBUA2nbNEUJkCIISScW0V8Xz842Tu4x962qm8aX/XieAlKE/19PuUV5xuN1rdX1OYtww
 nje4dSqMN/1L7yIgGyuI4l9rA/UDWDtCQQust92+3MUBqPHYYnZF32cYMbMoMq3CsE3Obo2Os
 qF1Micf0pSo+KmuSu85cf2NDSdDl+P0qpjmqQRU9/j+2FR83XyqKo9qlkk4zCXeAHymT16yt9
 2xVU6hUJQNegLcX6zvSqQ3rGCZ8ReLaeAlGKMv70LbTYYWYx2C/kCC9viHeG7E4K7clvCdM5d
 0AJy6VGx9wIi2VUnAj0XsurqVmNdcNBsc1t7ZEej/sVsUzQBdO58AKMPh6cWoPBavM+apdhfZ
 qOFczqP4Q8T67+kbTOWeDyAlsyCW1i0+eCUYtMIWIKBfW/uvskr6tw6oorQo7iLQCqKoN4nnN
 yy0tqUz28CSv9rpnHeHBRkTFAMBTFNR2IwFV2dVlRhtQxWxaxJM4UMBoCRZCmcJOVKax+1R5l
 IJv1loqctfNj6iTn+D4UulAxgoGh/DgMNSKNZeFANFle6Un1VBxEPss6ZCI/9X0AoK4wLELEt
 L0Dfi8UO4MPefZe72AfGgpNKZt7o4OqDu4TvteFlOdEQe6h5XRvdGGI9wLIhXXEixtVFbUy/O
 aFucleY7ue/ifGrYehE+80PfIoloTI64eaZ6p3yO4nplTbGG+hG+aPfyJ0nAjojO/871qtMMf
 eRIqZBZzDgSSr8Yssu4f97v6+mQHLMjA1U/rFj+oHDSBJTUzNxSOOi89o0eWlsGKiFUJaXPsb
 Zcsok4YUKRKep+Rb5/jfQ+oillCptq+XV4dZy+orvT4VaJ3OQiYoP5t+8+pdL3lYZ1yT/0kxE
 7R14MTgnduQ16rdMWF5QJRpcgpH9O7adtYqqh1h6LZwgYqtAt72Qbi379eM4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Sat, 5 Oct 2019, Pratyush Yadav wrote:

> It is a good idea to have a readme so people finding the project can
> know more about it, and know how they can get involved.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>
> I don't have much experience writing this kind of readme or
> documentation, so comments are appreciated. Please feel free to chime in
> with suggestions and things that can also be added.
>
>  README.md | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 README.md
>
> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000..d76122d
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,128 @@
> +# Git Gui - A graphical user interface for Git

Why not Git GUI? "Git" is a name, "GUI" is an abbreviation, and the
convention is (at least as far as I can tell) to upcase abbreviations.

> +
> +Git Gui is a GUI for [git](https://git-scm.com/) written in Tcl/Tk. It =
allows
> +you to use the git source control management tools via a GUI. This incl=
udes
                  ^^^

I prefer to spell it as "Git", i.e. with an upper-case "G" because "Git"
is a name. Lower-case "git" would suggest the command-line executable to
me.

> +staging, commiting, adding, pushing, etc. It can also be used as a blam=
e
> +viewer, a tree browser, and a citool (make exactly one commit before ex=
iting
> +and returning to shell). More details about git-gui can be found in its=
 manual
> +page by either running `man git-gui`, or by visiting the [online manual
> +page](https://git-scm.com/docs/git-gui).
> +
> +Git Gui was initially written by Shawn O. Pearce, and is distributed wi=
th the
> +standard git installation.
> +
> +# Building and installing
> +
> +Most of Git Gui is written in Tcl, so there is not much compilation inv=
olved.

"Most"? Are there parts that are not written in Tcl?

As far as I can tell, _no_ compilation is involved. Just a couple of
substitutions, e.g. the version number.

> +Still, some things do need to be done, so you do need to "build" it.
> +
> +You can build Git Gui using:
> +
> +```
> +make
> +```
> +
> +And then install it using:
> +
> +```
> +make install
> +```
> +
> +You probably need to have root/admin permissions to install.
> +
> +# Contributing
> +
> +The project is currently maintained by Pratyush Yadav over at
> +https://github.com/prati0100/git-gui. Even though the project is hosted=
 at
> +GitHub, the development does not happen over GitHub Issues and Pull Req=
uests.
> +Instead, an email based workflow is used. The git mailing list
> +[git@vger.kernel.org](mailto:git@vger.kernel.org) is where the patches =
are
> +discussed and reviewed.

You might want to accompany this `README.md` with a
`.github/PULL_REQUEST_TEMPLATE.md` that explains this, and discourages
contributors from opening PRs (mind, some contributors will not even
read this, let alone delete it nor refrain from opening PRs, but most
contributors will read it and avoid unnecessary work).

Ciao,
Johannes

> +
> +More information about the git mailing list and instructions to subscri=
be can
> +be found [here](https://git.wiki.kernel.org/index.php/GitCommunity).
> +
> +## Sending your changes
> +
> +Since the development happens over email, you need to send in your comm=
its in
> +text format. Commits can be converted to emails via the two tools provi=
ded by
> +git: `git-send-email` and `git-format-patch`.
> +
> +If you are sending multiple patches, it is recommended to include a cov=
er
> +letter. A cover letter is an email explaining in brief what the series =
is
> +supposed to do. A cover letter template can be generated by passing
> +`--cover-letter` to `git-format-patch`.
> +
> +After you send your patches, you might get a review suggesting some cha=
nges.
> +Make those changes, and re-send your patch(es) in reply to the first pa=
tch of
> +your initial version. Also please mention the version of the patch. Thi=
s can be
> +done by passing `-v X` to `git-format-patch`, where 'X' is the version =
number
> +of the patch(es).
> +
> +### Using git-send-email
> +
> +You can use `git-send-email` to send patches via email. A pretty good g=
uide to
> +configuring and using `git-send-email` can be found
> +[here](https://www.freedesktop.org/wiki/Software/PulseAudio/HowToUseGit=
SendEmail/)
> +
> +### Using your email client
> +
> +If your email client supports sending mbox format emails, you can use
> +`git-format-patch` to get an mbox file for each commit, and then send t=
hem. If
> +there is more than one patch in the series, then all patches after the =
first
> +patch (or the cover letter) need to be sent as replies to the first.
> +`git-send-email` does this by default.
> +
> +### Using GitGitGadget
> +
> +Since some people prefer a GitHub pull request based workflow, they can=
 use
> +[GitGitGadget](https://gitgitgadget.github.io/) to send in patches. The=
 tool
> +was originally written for sending patches to the Git project, but it n=
ow also
> +supports sending patches for git-gui.
> +
> +Instructions for using GitGitGadget to send git-gui patches, courtesy o=
f
> +Johannes Schindelin:
> +
> +If you don't already have a fork of the [git/git](https://github.com/gi=
t/git)
> +repo, you need to make one. Then clone your fork:
> +
> +```
> +git clone https://github.com/<your-username>/git
> +```
> +
> +Then add GitGitGadget as a remote:
> +
> +```
> +git remote add gitgitgadget https://github.com/gitgitgadget/git
> +```
> +
> +Then fetch the git-gui branch:
> +
> +```
> +git fetch gitgitgadget git-gui/master
> +```
> +
> +Then create a new branch based on git-gui/master:
> +
> +```
> +git checkout -b <your-branch-name> git-gui/master
> +```
> +
> +Make whatever commits you need to, push them to your fork, and then hea=
d over
> +to https://github.com/gitgitgadget/git/pulls and open a Pull Request ta=
rgeting
> +git-gui/master.
> +
> +GitGitGadget will welcome you with a (hopefully) helpful message.
> +
> +## Signing off
> +
> +You need to sign off your commits before sending them to the list. You =
can do
> +that by passing the `-s` option to `git-commit`. You can also use the "=
Sign
> +Off" option in Git Gui.
> +
> +A sign-off is a simple 'Signed-off-by: A U Thor \<author@example.com\>'=
 line at
> +the end of the commit message, after your explanation of the commit.
> +
> +A sign-off means that you are legally allowed to send the code, and it =
serves
> +as a certificate of origin. More information can be found at
> +[developercertificate.org](https://developercertificate.org/).
> --
> 2.21.0
>
>
