Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC53920899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdHNScV (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:32:21 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33850 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdHNScU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:32:20 -0400
Received: by mail-ua0-f178.google.com with SMTP id q25so39945953uah.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BZmwjMYuW8aiHfuQ+zkVlDQKt8hij3M6/77IXl1SAgQ=;
        b=GLD3VoOiLECX5KnJITMw7LwwcnDs6K1WX1W7SOv1dTRymkrW+BGNnU6dsVzHOgY1Ti
         IEek4sBrXbCfiNG0log8/olfUDlm89/+sySKH54wCcMSgSngil4YNQm0AznenjEQv6eb
         ZYKBlO2036oH07ZiXoTZ1nP2chjDkmR9+BWXBPiLTmPfmxmhXpBkC2QyAuq1pKWfQtF9
         GJG2WYjpyVKp2ONgtTz42pizDQHtgEm5/6AaH97xO3ybIr3dH4av30QBi/YfPXQxA3Fw
         Td3vFD2Pvk27pmnvlEp8VlJmrS+/ThqpYSE5bO47d6PvJ4Pl2eQJ26J3YPMipIYhKbJ3
         NqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BZmwjMYuW8aiHfuQ+zkVlDQKt8hij3M6/77IXl1SAgQ=;
        b=GLc5UYQcdP3bHYUhgOPpVwn/AvxRK5thHomPbgsSs+2Hx8iszk4t2LhIZUN5fUtLQ6
         hID74r/deA08X/EzjuK3/5bVAlYqcRhwJ2vojh7dP6xz+EHXRl9KE3AOEEN61TWnH7Rq
         pc9u95LM23BWd/GzKHt+BFRyVYhvL+T9s8SctO15iv6b0jb+FRvDIC27qHkb8GZT1nrF
         29RQJ+uwVzdyyIv4uR40TjzxOF502er0F3QBX4/hG3Lz8Tovb4OjRyGA8bTqGWvdxFC/
         2H4kAtiokRn+8xwfcKxWj+uqbbph8uSKQHgyEx3zvWHnegUl9XkDADn1VK+gQDMPPfbq
         lV/Q==
X-Gm-Message-State: AHYfb5hhX70AiEt+X5rTe2L5vImfW7DQs2U/LHoSxyOi5/vySdoXJC4T
        GUSpmevNM9CmvkNRp6/5U87WYw6WsKiI
X-Received: by 10.176.84.221 with SMTP id q29mr15615982uaa.173.1502735539646;
 Mon, 14 Aug 2017 11:32:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.123.82 with HTTP; Mon, 14 Aug 2017 11:32:19 -0700 (PDT)
In-Reply-To: <6d6b4dedba7147b6bd585956db368c8b@UUSALE0M.utcmail.com>
References: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
 <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com> <605cecc7f196495fa3d25113f28915e0@UUSALE0M.utcmail.com>
 <CANidDKbad2rYK0Cm=VejSp0FU7MRvCzo5Sxfzr-XTLYjbtfWtg@mail.gmail.com> <6d6b4dedba7147b6bd585956db368c8b@UUSALE0M.utcmail.com>
From:   =?UTF-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
Date:   Mon, 14 Aug 2017 20:32:19 +0200
Message-ID: <CANidDKbrt32oYjsgTuC7ji99TV0_cjbZoH2Un9UZzEicj7YtFQ@mail.gmail.com>
Subject: Re: [External] Re: gitk -m ?
To:     "Burkhardt, Glenn B UTAS" <Glenn.Burkhardt@utas.utc.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe there is a chance that combining `gitk `git log -m --follow
--pretty=3Dformat:%h PATHSPEC`` with typing in _Enter files and directories=
 to
include, one per line:_ any (or maybe all) of the paths the doc had through
history, would do; but /me more pessimistic now.
Ux=C3=ADo Prego



Madiva Soluciones
CL / SERRANO GALVACHE 56
BLOQUE ABEDUL PLANTA 4
28033 MADRID
+34 917 56 84 94
www.madiva.com
www.bbva.com

The activity of email inboxes can be systematically tracked by
colleagues, business partners and third parties. Turn off automatic
loading of images to hamper it.


2017-08-14 19:54 GMT+02:00 Burkhardt, Glenn B        UTAS
<Glenn.Burkhardt@utas.utc.com>:
> Neither of those two work for me.  They don't limit the view to the singl=
e file of interest.
>
> Also, I tried "additional arguments to git log", using "-m --follow".  I =
filled in the single file of interest in the 'Enter files' section.  The er=
ror message was:
>
>         Can't parse git log output:  {commit 9cc8be... faab99... }
>
> -----Original Message-----
> From: Ux=C3=ADo Prego [mailto:uprego@madiva.com]
> Sent: Monday, August 14, 2017 12:47
> To: Burkhardt, Glenn B UTAS
> Cc: git@vger.kernel.org
> Subject: Re: [External] Re: gitk -m ?
>
> I do not know if you can do what you want, mostly if you can do what you =
want as simply as you might be wanting that you want it, but I guess you co=
uld use this gitk boot command as a _simple_ work around somehow aliased wi=
thin your command line configuration:
>
>     $ gitk (--all)? $(git log -m --follow --pretty=3Dformat:%h PATHSPEC)
>
> Alternatively, there is a _view configuration_ menu (_new view_, _edit vi=
ew_) where there is a text box labeled _Command to generate more commits to=
 include_. If you type here:
>
>     git log -m --follow --pretty=3Dformat:%h PATHSPEC
>
> I do not know what will happen and I can not test that now (I eventually =
will), but chances are it could do what you wanted. Maybe you can even use =
custom aliases in there that text box.
>
> I guess you are receiving a more authorized answer soonish, in the meanwh=
ile, hope that helped.
>
> Regards,
>
>
> On 14 Aug 2017, at 15:20, Burkhardt, Glenn B UTAS <Glenn.Burkhardt@utas.u=
tc.com> wrote:
>
> They don't.  In particular, information about commits that are parts of m=
erges is missing.
>
> Here's an example.  There are only two entries listed in 'gitk --all'
> for a particular file (sorry, I'd prefer to include a screen sho, but the=
 mailing list doesn't allow HTML messages).
>
> gitk --all MANIFEST.MF
>
> Parent: f7462684ae78720aac05c929256d770118cf01fa (initial clone from Clea=
rcase integ3 branch)
> Branches: master, remotes/origin/master, remotes/origin/ww, ww
> Follows:
> Precedes:
>
>    require java 1.8
>
> Child:  240f151d61fd4fd06f377bc52970b3574e5f9031 (require java 1.8)
> Branches: master, remotes/origin/master, remotes/origin/ww, ww
> Follows:
> Precedes:
>
>    initial clone from Clearcase integ3 branch
>
>
> git log with '-m' and '-follow' shows:
>
> $ git log -m --follow --oneline MANIFEST.MF
> 9cc8be4 (from 1222d7c) Merge branch 'master' into ww; strategy "ours"
> a423f2d (from f869950) merge from ww branch; remove Bundle-NativeCode
> 51f0628 (from 2c6478c) Merge branch 'ww' of coverity:rmps into ww
> 240f151 require java 1.8
> f746268 initial clone from Clearcase integ3 branch
>
>
> -----Original Message-----
> From: Ux=C3=ADo Prego [mailto:uprego@madiva.com]
> Sent: Monday, August 14, 2017 01:12
> To: Burkhardt, Glenn B UTAS
> Cc: git@vger.kernel.org
> Subject: [External] Re: gitk -m ?
>
> Not sure what you are wanting to achieve, but please make sure neither `g=
itk PATHSPEC` nor `gitk --all PATHSPEC` are presenting you enough informati=
on.
>
> On 3 Aug 2017, at 19:37, Burkhardt, Glenn B UTAS <Glenn.Burkhardt@utas.ut=
c.com> wrote:
>
> I've been looking in 'gitk' for an option that does what 'git log -m'
> does.  Did I miss something?  In particular, I'd like to get information =
about a file that's currently available with "git log -m --all --follow", b=
ut presented in 'gitk'.  If it's not there, please consider this a feature =
request.
>
> Thanks.
