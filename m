Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8516320899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdHNQrU (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:47:20 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:37818 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbdHNQrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:47:18 -0400
Received: by mail-ua0-f181.google.com with SMTP id f9so38759406uaf.4
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nKIndRziTfV5EJinY4mkWHbbubc7NLLbvwnpM83YcAE=;
        b=Q1J1YQ+meO3pXxBYjwq05kerlqBifPXCxCfzAUUXNhRuGacDXwExbUFB1Sgc7R0NYG
         4bNSuvALD+dWqRLUlxtaZe3oLl1rAZQz7AQm0s7d3IJILXKUIy29q/ZDReFx2y6KLSfx
         7zvDty0HcjFIwDEQW+TwCUvyVou8f88vt47Kc5FpMXs59LMHg0Ypc18Nb6sgkrugbAv4
         HPfSesF73pw7CpXIzOPm/JF0hklR63snQmq63ACNutpHB90ROa2fHZaYUaSDJN2j/xGA
         inkDeGnOTwqVMRlEDOsY1pe1KWRFH5S2F/nj99pAwxd24xdAeNJDAPpULNsIeAHjMhDl
         KvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nKIndRziTfV5EJinY4mkWHbbubc7NLLbvwnpM83YcAE=;
        b=MyONsxx/gNraSmWhX1jWjVd2vy97HXjdsMygbUFWA229O+dkXFW97l5LXCVtdoncKN
         zO/vdDhOXCgf1cP+vF9FUgcsBfG2Ujvirldqgi2s9kCbPT4xz11ZBmT5Si3BV4GIs9oo
         hYnd5drCWhPTt9yo8ZLeXkU/4CowmfYziuljoVBiKliJw0JauzxenQ4ypFz5ApEJSlrz
         ldpKVN6KX+RPc1qEXOGe/bp+a826wQ9PM1NnnAwn5ZVzccaF+AMqatLn0Rt5Ge2WpZBe
         eqZZkbM7boHjVDzbnceIoAGRs/yqnARGRpzU/SRpxlpDz+wxiwHPpOogDI1Hc33oMKYq
         WbxA==
X-Gm-Message-State: AHYfb5hpoQhOsjPmCajRVdnttAIUdcl1QMrgGs1mEM6CgVqWoTaaujn3
        287EeSILJFdQYLSta7P8x1jzIRlOmaTt
X-Received: by 10.176.23.204 with SMTP id p12mr17723757uaf.156.1502729237918;
 Mon, 14 Aug 2017 09:47:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.123.82 with HTTP; Mon, 14 Aug 2017 09:47:17 -0700 (PDT)
In-Reply-To: <605cecc7f196495fa3d25113f28915e0@UUSALE0M.utcmail.com>
References: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
 <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com> <605cecc7f196495fa3d25113f28915e0@UUSALE0M.utcmail.com>
From:   =?UTF-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
Date:   Mon, 14 Aug 2017 18:47:17 +0200
Message-ID: <CANidDKbad2rYK0Cm=VejSp0FU7MRvCzo5Sxfzr-XTLYjbtfWtg@mail.gmail.com>
Subject: Re: [External] Re: gitk -m ?
To:     "Burkhardt, Glenn B UTAS" <Glenn.Burkhardt@utas.utc.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do not know if you can do what you want, mostly if you can do what you wa=
nt
as simply as you might be wanting that you want it, but I guess you could u=
se
this gitk boot command as a _simple_ work around somehow aliased within you=
r
command line configuration:

    $ gitk (--all)? $(git log -m --follow --pretty=3Dformat:%h PATHSPEC)

Alternatively, there is a _view configuration_ menu (_new view_, _edit view=
_)
where there is a text box labeled _Command to generate more commits to
include_. If you type here:

    git log -m --follow --pretty=3Dformat:%h PATHSPEC

I do not know what will happen and I can not test that now (I eventually wi=
ll),
but chances are it could do what you wanted. Maybe you can even use custom
aliases in there that text box.

I guess you are receiving a more authorized answer soonish, in the meanwhil=
e,
hope that helped.

Regards,


On 14 Aug 2017, at 15:20, Burkhardt, Glenn B UTAS
<Glenn.Burkhardt@utas.utc.com> wrote:

They don't.  In particular, information about commits that are parts
of merges is missing.

Here's an example.  There are only two entries listed in 'gitk --all'
for a particular file (sorry, I'd prefer to include a screen sho, but
the mailing list doesn't allow HTML messages).

gitk --all MANIFEST.MF

Parent: f7462684ae78720aac05c929256d770118cf01fa (initial clone from
Clearcase integ3 branch)
Branches: master, remotes/origin/master, remotes/origin/ww, ww
Follows:
Precedes:

   require java 1.8

Child:  240f151d61fd4fd06f377bc52970b3574e5f9031 (require java 1.8)
Branches: master, remotes/origin/master, remotes/origin/ww, ww
Follows:
Precedes:

   initial clone from Clearcase integ3 branch


git log with '-m' and '-follow' shows:

$ git log -m --follow --oneline MANIFEST.MF
9cc8be4 (from 1222d7c) Merge branch 'master' into ww; strategy "ours"
a423f2d (from f869950) merge from ww branch; remove Bundle-NativeCode
51f0628 (from 2c6478c) Merge branch 'ww' of coverity:rmps into ww
240f151 require java 1.8
f746268 initial clone from Clearcase integ3 branch


-----Original Message-----
From: Ux=C3=ADo Prego [mailto:uprego@madiva.com]
Sent: Monday, August 14, 2017 01:12
To: Burkhardt, Glenn B UTAS
Cc: git@vger.kernel.org
Subject: [External] Re: gitk -m ?

Not sure what you are wanting to achieve, but please make sure neither
`gitk PATHSPEC` nor `gitk --all PATHSPEC` are presenting you enough
information.

On 3 Aug 2017, at 19:37, Burkhardt, Glenn B UTAS
<Glenn.Burkhardt@utas.utc.com> wrote:

I've been looking in 'gitk' for an option that does what 'git log -m'
does.  Did I miss something?  In particular, I'd like to get
information about a file that's currently available with "git log -m
--all --follow", but presented in 'gitk'.  If it's not there, please
consider this a feature request.

Thanks.
