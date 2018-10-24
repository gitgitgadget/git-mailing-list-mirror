Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83E11F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeJXQEs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:04:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbeJXQEr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:04:47 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1fzLXf0Fvy-00JNk5; Wed, 24
 Oct 2018 09:37:41 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1fzLXf0Fvy-00JNk5; Wed, 24
 Oct 2018 09:37:41 +0200
Date:   Wed, 24 Oct 2018 09:37:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 2/3] mingw: replace MSVCRT's fstat() with a Win32-based
 implementation
In-Reply-To: <20181024022024.GE6119@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1810240927520.4546@tvgsbejvaqbjf.bet>
References: <pull.53.git.gitgitgadget@gmail.com> <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com> <20181024022024.GE6119@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ST9p6BaEW6k6C60RgOU+pKPetO7mzUAM0RWSqlRFGpEmtJzaks0
 ctvgEqxvwgBkZx18QF4GtdL/uwbQ0HwwKHz7oGUkP8ehTqFzm8CLcgX2K7Ubk5fwTewV5zj
 GuD2SGwWuhcvoiF9acW1k2q3hMRuI+crE3Vxb8Cjoj8vhc76uoZKQB17WSUys/KuJyw9YxR
 4VrNSU6s39WoqDKGQ8YjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pog9nar9XGg=:qBvRA2COtTnFxbKEEcSUlN
 VAbXvcCaPplPJWJ/QClsQ3oYKlRkz10gHJc5jpWF0YgLPYOd/9NRhWyxeNVRNb/5EaTHyANo2
 G+6epTeHHwiH0upHQlWj04txhARrdCRhir8unBDc6kVy3jSxvFDIh4FII1G2TwRq3T5nqLEWS
 FYC0mZa0aD6bERET9lqSWoaN9d/hhU2M9Xxc7KAKvKkFFEZmYriT00SU/JoJp7s9gCoP6AvTu
 aItm43GW/MeOkRqlnkxzQmtCgcSQcwXig72ZlU/d4cy6A5U0MnnF3tWYDy2OCWV7jV+m2+X6I
 Bzp3bhJyAm8CA6qku6UFl9eJVaLi4vaCL5MtHevYE9fEjMYISDAtBjP4BC8Op72Qc8eZOeXn7
 QYFmdkSsAvPTkmjEjgZP44FFjltyzQF2Zg/covm+XwP8KwIGXkp7O3W2YmD/ev38vQ8+XEnT1
 W4DW66ZKIp7s58SA44yr4h9VlXcwqme4RL8PLOLKCzDbrU8jKqJQGf+4pgDbQ+B9sLzzSiZx2
 OllKvVa1A08fvSZ8FITkrpTCU2vtQECRp3yMBP0E4vGOkf+BRLVJ3vX5Hv+9MXD048L8iJgnE
 Ehv4a7seu9YjSt6xjwSI49L4SMhC6NNijOCvDtQkzyqEA8aB9b+z8mXTsByKcuGw6ICMImlZp
 bPkfInB4N+vOumeEPzMM4FH2bXo+1XxPqBQQen7U12SNZkSjHHOXVAwK+wHcKgRJd5vpmptVM
 VTta4xr5TO4yvmUL/1es/xPMn61eOxgRT99bEcov1x2ZdBCnyL4lXv9S+Po/6UuyNTryfcA9F
 Mpn8oRhVPUG8ad0Kv+ggBnAATNUZFouEPRjrP2RSq7frcn/6kY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 24 Oct 2018, brian m. carlson wrote:

> On Tue, Oct 23, 2018 at 03:23:21AM -0700, Karsten Blees via GitGitGadget wrote:
> > -	if (!get_file_info_by_handle(fh, buf))
> > +	case FILE_TYPE_CHAR:
> > +	case FILE_TYPE_PIPE:
> > +		/* initialize stat fields */
> > +		memset(buf, 0, sizeof(*buf));
> > +		buf->st_nlink = 1;
> > +
> > +		if (type == FILE_TYPE_CHAR) {
> > +			buf->st_mode = _S_IFCHR;
> > +		} else {
> > +			buf->st_mode = _S_IFIFO;
> > +			if (PeekNamedPipe(fh, NULL, 0, NULL, &avail, NULL))
> > +				buf->st_size = avail;
> 
> These lines strike me as a bit odd.  As far as I'm aware, Unix systems
> don't return anything useful in this field when calling fstat on a pipe.
> Is there a reason we fill this in on Windows?  If so, could the commit
> message explain what that is?

AFAICT the idea was to imitate MSVCRT's fstat() in these cases.

But a quick web search suggests that you are right:
https://bugzilla.redhat.com/show_bug.cgi?id=58768#c4 (I could not find any
official documentation talking about fstat() and pipes, but I trust Alan
to know their stuff).

Do note, please, that according to the issue described in that link, at
least *some* glibc/Linux combinations behave in exactly the way this patch
implements it.

At this point, I am wary of changing this, too, as the code in question
has been in production (read: tested thoroughly) in the current form for
*years*, and I am really loathe to introduce a bug where even
Windows-specific code in compat/ might rely on this behavior. (And no, I
do not trust our test suite to find all of those use cases.)

Ciao,
Dscho
