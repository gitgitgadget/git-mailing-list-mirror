Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CBF1F731
	for <e@80x24.org>; Sun, 11 Aug 2019 12:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHKMKL (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 08:10:11 -0400
Received: from mout.web.de ([212.227.17.11]:60335 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKMKK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565525405;
        bh=UBTDGh7J6Z12ogU1zbLuatJlB6+l4cgg/V2Byz5Sjeo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KXccP6NrMKymLU5+iNHRB9XjTgHvAYhl1EdSTNFjrdswluppYsHjzuIrIhz2fVVPB
         RZAuqDDytJCSHDhxoFSD7utiEE6DbUc8UXSUbWMkbixNcLHJyYtZ11X3kr0wZrk4DS
         tXwmFkBlw7aC1Zix1mM0EaQD/P9Ves9haOI0i1tw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDgDS-1i55jn22He-00H7ZK; Sun, 11
 Aug 2019 14:10:05 +0200
Date:   Sun, 11 Aug 2019 14:10:04 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190811121004.guygurnopwwggvsp@tb-raspi4>
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
 <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com>
 <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:aZfDRvCDk32B2vSjUQF+vCCCG4kdG0duupfd7xtr/6A9rBJlXeN
 kAzB12ElS1Lqsf2pmncRlar6F370yvQcM9w8sY0VqXM01VeA3w6rzMhIL3WKzJuI0MW4IOK
 OCfDvwvE1Z+vMGsXFLqc2/gtPUy7bUl+tZLP1HzGcmEQ8oIl30QXZOZnfKzoMwWocIlE09U
 7Zj1kR76w2z/tYvqHzNFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+4tmuSsQyo=:J2bTru+2LvDQlcfBx9yBPW
 xhFlHa6YfVXt/l2Gw9QOYvpcJjbVjEq14x9qy8AO2G3LqZ/vjYvcMyNUoNYBNHptjWTc9WS3e
 rAk19BV4velCm+P7N2RH6/rRoRLywUPfq2shWU407x9Fu0IeAqgs8ZhjuUys6XfIf7dSiVioR
 uqVrdVmCHFRZ2MCPLH66+/OG8mNL3XCPUEd2fSxAlJ4bGi8+6Pn1rnu4WtR6BXvZ9dbsvD7g0
 bROaFxdWNLFh/aHnA08YPodyHT5fwrEfDX5Lo218a8maFxWZBkn0BfWEKwkY/pHDW9OJBuybo
 KjwqiGVHpQ1u8lthSLE63VcXZckUWYvMLll1PTfoV6jdDPajpaKPUp0yHvOFjDqqloEOc8RMK
 A6x7KS75/Lot0ovYL5sascdcZcCHmn/yU3ljJS7ctQ94D50nBesWqWaq68V07EBNughZJ1LdE
 UtmRYtnekOcxpvBWh6wBLtYTZMcqR7e66yiysGiKEd6NyoT3FGxcBzHE3F72A7d43BGAHXDPh
 hn/4JfNm+PYakvkWrrcDtOf14WgEDn7svcdMLVKsOG2EBAetRUgGsZ9UM+WGefa7OU2Tc4wH+
 u9LfvR6RPJ+PyDCz3Xz1EkpOTh8Oj06RLzVmX3npVYLhPgMMrFBc2SksemITFYoslbJJFbrt1
 lrTfmxx+QY6tx5PQnwL5s6eUcPUUe+HAeMfFCC5DZa9XtYl1tUmVp3C0wRmQ98yFSjwA5KQNg
 yWhuJtxXSmw9h3n8UYYduUM4cYHjgxfdG/r3ICUzrk2msF39bSOKkkM5dzOJbYRbak7TGT+kZ
 GVVP2knghWRwj7SbU0W9WqfBIjd8ls13bpQWRI1NqwPVL+jdn3NI74H1xWRLzY31c0oKufmPF
 z3n0Q5Dyz5DiAKSrbmS6lwhaJzimyOjCHIbRIgzkoANGk3cADtayiNJAG4TBObFVY4wVhygDE
 pX0ofgJL8KyJJ/sbNVAPZL0FM7xyE98BwaX13PCDcDW7buolW8jcjZ5huvHYAJ3T3XQdcqsTC
 s1h6TC8T81EVAMP3rZkxNGClKvpQ/y2uOv10RnJYl5n5YL4YC05g1DWtGE16d4r709luuChAw
 57Ys5cRC02lGKyfeuISPTIo2W6RXLhK1tNE9+nGRiw9oscI0fs0ld8S3w==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 03:34:05PM +0000, Yagnatinsky, Mark wrote:
> After correcting spelling of renormalize, the end result of the script y=
ou gave is that line endings in working directory are CRLF,
> and in the repo are LF.
> Is that expected?

Yes. "git add" does typically not touch the files on disk at all.

> Surprising?

May be.
Typically the CRLF is done in the .gitattributes file,
which is commited and pushed/pulled between the different
machines.
In opposite, core.autocrlf is just local, and different contributors
may use different settings, leading to all kind of CRLF frustrations.

Having said that, the .gitattributes file is established early in the
lifetime of a project (=3Drepo).
I typically set up the .gitattributes file as the first commit,
before adding any other files.

If, however, the .gitattributes file is added to a repo later
(better late than never), and the developer messes it up for some
reasons, then the original files are still in the working tree on
disk.

Correcttions can be made after looking at 'git ls-files --eol' or
other diagnostics.

>Not sure what you were trying to test there.
There ? I probably lost the script.

>I also fixed my script to use printf, new version is:
> (using copy/paste this time, instead typing from memory like last time; =
learned my lesson).
>
> mkdir empty
> cd empty
> git init
> git config core.autocrlf false
> printf '1\r\n2' > test.txt
> git add .
> git commit -m test
> git config core.autocrlf input
> cp test.txt t2.txt
> printf 'a\r\nb' > test.txt
> git add .
>
> Thank you for ls-files, I've been resorting to deleting from working dir=
ectory and then doing a checkout.
> And also thank you for the gem of "od -c"!
> The output of ls-files after running my script is:
>
> i/lf    w/crlf  attr/                   t2.txt
> i/crlf  w/crlf  attr/                   test.txt
>
> So I'm still confused.  Why didn't test.txt lose its CRs while t2.txt di=
d?

This is because the "auto" feature does not change the line endings, when =
a
file had been commited with CRLF. They may be there on purpose, or not.
Git can not make this decision - the user can.

This is why we have 'git add --renormalize".
