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
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B8F1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfFLUC0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 16:02:26 -0400
Received: from mout.web.de ([212.227.17.11]:36487 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfFLUC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 16:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560369743;
        bh=0jZVRrGzAhwyl2hcvV7qXGcYWBtNyv8iZdwKxi2HKBU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ekjG8hV2DIJniMzHpIHK4d/VsaTWR5VZ8z6W79ZlJivm1Q7zMIyjvxc+vKJDgaxNh
         wbFNgD8hqfQ6F/mR5iJ0wIY+p+9cbXkVflQh+ck9XiJJKxQDeZpntqRS60diQ33SaA
         LdCOCp+ewkEsD00gLomgxduzoR3nZa1LHiJLM3zU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhFJ-1htVmM2MfF-00Iz3m; Wed, 12
 Jun 2019 22:02:23 +0200
Date:   Wed, 12 Jun 2019 22:02:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexander <alexander.samoylov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: Git checkout on Linux sets always CRLF regardless of
 core.eol
Message-ID: <20190612200222.odtht5uq2fzqpsmz@tb-raspi4>
References: <CABcYkASFxTe7Sq278EqCT1hBQq4Sh47-emNPJcnhA6YWZf+uQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABcYkASFxTe7Sq278EqCT1hBQq4Sh47-emNPJcnhA6YWZf+uQg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:h05MBJu1oU9zWDtuhlYpO1VuwlxiQrzJSye/EJGaIKg+Vm7FQ87
 a+/DfFKoApgM5hOdjCdo5lLMyC3CQQW1nUWZWHCnTjnEqyb3GjoxPcu4SlnjzxwbD0mX5wW
 ESaKlAMaU9alkPpV6hvRdFdWWj3apnK4EC8j73iQ3JCMXfbvaf7SpSusHaALVeQh5i76tta
 73VvV6lFD82eSIzyiM8Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UQr15KCTA+k=:DkE2IjCoVt2YLYlPwyZ3Nm
 Dz8S7BxLbbz7WmvfGLA8jv7WvpICvQq5uhxwVDK2OxkRexHctcwGcZ7adxT94GZkiKZ4VqgZX
 Cv3CqezjlKwF8JTDFkUhRUPOcQlywq5hiBHoOd0F8Jdt+IvTefc6oXU5af+qKsTJ8IHXfOZPa
 KlAXALLPwbnzdE9ftNp1wjoDtd0ydHV+QC9oqxZDEM/P9jzDy+0Aj/g0S+nQHDtc29AU/9Hfb
 Iz0SmoXSqHqqlyu/iPj+0AxoTOOsk1QGHXWazSKOlMI4Tbf8/wHH5r6lJsN7mJzC1jzvoTMRs
 UlS6Os88++3N+51tHLT7RPGGbqHJqUP+4HoaPKubaVZ7meWFZe0ud7HZ/H64xufTNv0evFOCg
 51f7FNlnBSqeGsmfPWSvumCoKIeWf/FSV7CFI3fZ/VvpswXFmwppmRmV0hdpH30AN4LAY+YnB
 7v4/FGOz8XMYkrdCgOENnwsDCOupNS+1SFViQ08kQjhAbujzf9urpi/qTYxU1EjOlN0A248kK
 BgehDtGCorbqZgr5KvT8zfL/q5CdUTGXfHPW+JDh9i4Yy6XB3/hw/SUBBnDiTZ0zX8DbNuoDs
 dnOQi3Sg5IuwjOH1EtaE63y26BzTKRpuj6Dh+Ja0t9UN4O9zXoiz6w0UvnZlMr6L0WdfXVJnt
 bpyxLP50PrmKcS8Eryh7YmUu/C6YgiLQll9w4VOtkwM4gt308xh1fHKk2MyvmaFZqf6FuTwPN
 7E5n9IYIIYa4Tr+t7oYdndkyQSVmaHRts/bGvZ/y3hKUzhp3d2dMfh/8gC38ikK5/L5v42dQ0
 kuDz8OEaU18x7yFPPDfZ4+3aTqxtvpkcrbvt8jytdS36WhetU1x53dNzATR8IDBn1I0O4gaM3
 4H6uqyou88yfQ50cE0SkUKfOyxuA3i+FyqAshyVz38Zkjje/rIq61oCgImeLzu22COWwFYsg/
 /VKgk+CMfiozrimxQlk/tyLKbcCFMJ5k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 12:48:00PM +0200, Alexander wrote:
> Hello,
>
> I am trying to checkout out various 3rd party Git projects on Linux
> and build them.
> Some of them have text files created under Windows with CRLF endings
> and it is not under my responsibility to change it.
>
> Thus I have to force LF line ending for Git checkout (regardless of
> which line endings the files have in the repo). I use the following
> settings for that:
>
> $ git config --system -l | grep core
> core.eol=3Dlf
> $ git config --global -l | grep core
> core.eol=3Dlf
>
> However it does not work. The issue is reproduced pretty fine on
> https://github.com/winlibs/libjpeg project. This project does not have
> .gitattributes file, therefore I expect that global settings must be
> enough to force LF, but I observe different behavior:
>
> $ git clone https://github.com/winlibs/libjpeg; file libjpeg/libjpeg.map
> Cloning into 'libjpeg'...
> ...
> libjpeg/libjpeg.map: ASCII text, with CRLF line terminators
> (not only libjpeg.map, but a lot of *.c files also have CRLF if you chec=
k it)
>
> libjpeg is an opensource project, so anyone can reproduce this issue
> on a Linux host.
>
> This makes me think that this it is either a bug or not documented behav=
ior.
> I tried various combinations with core.eol, core.autocrlf and even
> global /etc/gitattributes file - nothing can force checkout with LF!
>
> Could you please confirm whether it is a bug and provide the clear way
> to bypass it.

I can do neither-nor, so to say.

Whenever there are CRLF in the repo,
there is no way for Git to change those into LF in the working tree.

The correct way is to normalize the repo:
user@linux:/tmp/libjpeg> git checkout -b normalize_EOL
user@linux:/tmp/libjpeg> echo "* text=3Dauto" >.gitattributes
user@linux:/tmp/libjpeg> git add --renormalize .
user@linux:/tmp/libjpeg> git add .
user@linux:/tmp/libjpeg> git commit -m "Normalize the repo; add .gitattrib=
utes"

After that, send a pull request to the original author.

HTH
>
> My Git client version: 2.17.1. Please, see also
> stackoverflow.com/questions/56546220/git-checks-out-crlf-instead-of-lf-o=
n-linux.
>
> --
> Best Regards,
> Aleksandr Samoilov
> Build & Integration Ingenieur
> Compart AG, 71034 B=F6blingen
