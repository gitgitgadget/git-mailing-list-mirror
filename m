Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1292C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B8A611ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhDZUzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:55:55 -0400
Received: from mout.web.de ([212.227.15.3]:40779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233483AbhDZUzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619470511;
        bh=CcsaSmiBfAQ8FmnCR1N+ncjrSwpUEvQ1Cyk5wCr1lzE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ut1vYORYeQL+jC6INxGV8asqMRQ1WWaPEi3UOYbgVnM0wC9BQyOG/8acezASKpx0r
         46ql7uhV46EP7aFymYllhX9XUI2Zzcg3CqBJCTL50XfokAYI93wKYpWC5o8+C1YDKn
         FRmAxxP1NS7s3IlWSgKtHJRJLC7CrrHRYCPU+q6o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRA59-1m1q4X44xr-00UcIw; Mon, 26
 Apr 2021 22:55:11 +0200
Date:   Mon, 26 Apr 2021 22:55:10 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     mark.yagnatinsky@barclays.com
Cc:     git@vger.kernel.org
Subject: Re: idea to tweak wording of CRLF warning
Message-ID: <20210426205510.snoqwdipq47fkhbb@tb-raspi4>
References: <AM6PR01MB4166BC567911A05016DE2918F9429@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR01MB4166BC567911A05016DE2918F9429@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:i4vAAutVJftjU8n2UHCv1vvUhdsZOwdtGw61RUHW6pPH2Eackem
 zFPoNJ8CKG3irAjWJG29OK32kKts4NnuaSXz3INb7frvYeng5PVOAirx9FguE22BSVHPamD
 OL6BsNoizrgPkGPJ21AYXKcaC4btRpotq9ZvVBpe53rp5KTkITBh+BD8HoBx6eNU/yf4JGB
 UbOlN8LUsc/9GDlS2EM2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqExCIXmaNA=:LHGHkrZtJV7mIzew+tnKfN
 dSWNtolKnwcxmMQdOi2bJ2srK5bB9KwMtNMQ6TorMkFEKUF0Wgd4I2hpA7WwOPvKUzYY4wjBL
 4e18346pjDmcErvQEDRk4Qk0qHOQd21hvJsmyHjHkDHPeHsKfH5oJzXnr9g0lBDg8/M8ZzioC
 0THgYpmbdvjV4PPdAfD8O5Ovc6u978Vk+/e8ekDo7EKDPu7sZDRIh0b8XM3UVLTMhwMmeTyAV
 hxXdYhkiKEd3MAUHWsgz/Ef1d/t+Mv2yPvoS1BRKavWAxkWjakLn/xt4e4A40leZPmlBx+FBr
 Coj1Ajr/PhCY3Hv44z2mTK7DkJ041O09aoMhkduQx8vgxXX4oNpKGCQEagP4K+7bpliaUAOFj
 r7Tzqbpi2gcCGSEVXH/TDA1bOE1ivLONOS99NsQxomZx9XvbYfn6F8+1Utnj4MbiYqtX8W8J6
 ScelqlC85rYWrkpL6l9KjO2v+VtH/pA1lk+YN0zK2YDnxb13FAQWnYFo3uIN9XsiAA3jzrYV2
 xd4j/qb0B3vlgGr5Moqif4N91rKlhYWoFILtlJ7JMhM47tTOD1BeIlV2DDxSr/p/dZEQ98ljL
 hxVbqjdFHztz4ZPZinuyZcVIP7h+amvLBYpSk0fSWPcojLxBoTBmJEVXFQQ5ugDd2lYfnOvxT
 xdci5Kw2aEshYcowERoY4jBX093DfGdIBYpDPiryHTGT2iLufukNKo1hu+GMp3CsEdLUZCXva
 g2Eez0E+xIwMnEWFGCrIRDmmWyMl5ovloLV6cqcTnNcWXqMwu2l8HCOGwlN/CTAIIuVhWorMo
 VUJrBOsZ6hZlzmUnE+0cwt5hlq9Yj/i2KCEwIKbvmKsiGRJv70PtKaOh+oXVbVpSgTwjo2h9R
 E/EhiNFNtolUWoo5zmWQg6T4eWe40pjPsvTnO/RnG6SngiQZAw0dSHMw0GazJDYCQn9KB9MeV
 Ygtk6YS+Id6aD3cPgu6TMjEAQsltdEEkYNXiVVAhda5qw6lNtzE4X1Qsh9FchHVOVOsQzw+fI
 jZb+kB7plDoHMs7v57+4ibnN29W44ff/cIG0tpMobrT68flIjrVa1uq8clFxr3K2zsjPKCJCi
 aYWeb4Ra8TFoGD0eIEpZ9zGF+VEENjuAIV1+g11JtHTi2IRjGrwDRcMJkXMvxcLepYaXtdTaF
 9LnnDh3ZebjFOrckHDKYy8TD5zH6PGsakc6zJgIbOsl40IxS+0ID37EY2KcITYmut1+QA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 05:31:53PM +0000, mark.yagnatinsky@barclays.com wr=
ote:
> If I'm on Windows and I "git add" a file with LF line endings, I get the=
 following misleading warning:
>
> warning: LF will be replaced by CRLF in t.txt
>
> This makes me think something is about to happen "now" but actually the =
warning is about what will happen "later".
> In particular, the file will be committed with LF, but git may convert t=
o CRLF when it comes time to check out the file.
> Thus, I propose to add the words "on checkout" somewhere in the warning =
message, to emphasize that the conversion will occur later instead of now.
> E.g., "warning, LF will be replaced by CRLF on next checkout of t.txt" o=
r something along those lines.
>
> This suggestion was inspired by the amazingly detailed answer to my ques=
tion on Stack overflow, without which I would have been badly confused:
> https://stackoverflow.com/questions/67199433/git-line-endings-behavior-d=
oes-not-match-documentation
>

Thanks for posting here.

I think/hope that a couple of answers given on stackoverflow could have di=
gged out from here
(or may be they where ?)

About the gitattributes:
https://git-scm.com/docs/gitattributes

Out of curiosity, please allow a question:
Is that material too hard to understand, or too hard do find ?
Or does it take too much time to read ?

Back to the confusing message.
It is confusing even to me.

... I like that message suggestion. You might consider offering it to the =
Git mailing list as a patch to Git ...

It may be, that someone sends a patch.
However, as a very first step: "or something along those lines." needs to =
be defined.

Which short text would have explained the whole story better ?

The attributes with "* text=3Dauto" means different things:
Files with CRLF in the working tree will get LF in the index,
when they are commited/added.

git checkout t.txt (which has LF) in your scenario
will not checkout the file with CRLF rigth now.
It is is not changed in the index.

A checkout will only change the working tree if you checkout t.txt with
different content - checkout a different branch, switch to a tag,
or checkout a commit id.

Or if you delete it in the working tree, and check it out again.

In that sense: Suggestions (the complete new text) of the warning message
are welcome.
