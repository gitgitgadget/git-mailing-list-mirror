Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA7D211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeK3CYi (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:24:38 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41937 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeK3CYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:24:38 -0500
Received: by mail-ed1-f50.google.com with SMTP id z28so2191494edi.8
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gXWvsCTG0uzngV+tFE9leOsb91MfSHuSxnAC5PJgalc=;
        b=VORda+I4EmYM9VupKfiaJb2xxBqkBhT3w6Z0HTWsmPHZPUB5l3q70B3tsVk1Sa9rxX
         nPM4B6uIhIsIRtUZCGu2WNCOeyTWXitYMmgTwufI8iLq3wotksNsSc+S9p5Fmvp0hKXm
         AHhpAe6hUfUiMbnLQJR/TzZ/YvDvQxedca0D/cJi2oBV2um6OW9ZYMSp+2Nss7OcwZxj
         SknYXJ391JvhLUHCyOPVDklaoIvDf4hvy46VfR2qhsW7/VZDLYiTw14ObabQ7habm5DF
         BZoJ4i9TlsxQqgvZy5G6BOHx1pcrMpnjlvg56j8Ez4hW5OZ6dO2SvkTwBLR5aYo8AIoD
         R3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=gXWvsCTG0uzngV+tFE9leOsb91MfSHuSxnAC5PJgalc=;
        b=eB2rCThOMI+jSVggHsPF7XChM7I4t1CApPhiLd/WM/fNqW5Cp5teb6Hl/HIMsE+wli
         8o4hHbOKLYH4oFMhtNugmEYnzCaxwJsMyuXJ2yvX8o+9XZdQnPG9bTkqDjBaKZT5vJA0
         suYEzJ1w51PYTeowz1C0EYqT4tK4vsLYqk5+snRXu7zU+FyqHTvCO8gmcaPad3xWeXlO
         Bii75PjUc1zvtBGGmhPxsICVMqeOupKyl53t8kNd2j/j2Weear3S5hDnpKkhNzvq0Xvf
         GqovWYlKlzDQSqlwFUbcxECW4Colu5Ui4cFIi1pmkFBdrL00jVIWRaVH5/EMlClTrQ2g
         qCBg==
X-Gm-Message-State: AA+aEWZnb4WQWAb2aYTR8gJBIAr9FDUC62TSPQv2E5noGDT7Kv9cgX+e
        Ysz9gwooyOZX/R1RE/53+5aCnIN0+irLy5M/dndqYvUj2Kr2lgv5
X-Google-Smtp-Source: AFSGD/XymR8QCsjE20EPXVCzO3q0dZlQaFu800ovxj735dPMJ+yFjP2LIsplh80TSvNVK/lr+sxWYoRPVQIHSEbveR8=
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr1995721eds.91.1543504733907;
 Thu, 29 Nov 2018 07:18:53 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
 <87y39cx6wt.fsf@evledraar.gmail.com>
In-Reply-To: <87y39cx6wt.fsf@evledraar.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 29 Nov 2018 16:18:27 +0100
Message-ID: <CABUeae_VVtbj0JCRyUuqf=uaPFXkmHwHpYyapH4H5A_cQSQsdA@mail.gmail.com>
Subject: Re: Simple git push --tags deleted all branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Nov 2018 at 16:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> On Wed, Nov 28 2018, Mateusz Loskot wrote:
> >
> > (using git version 2.19.2.windows.1)
> >
> > I've just encountered one of those WTH moments.
> >
> > I have a bare repository
> >
> > core.git (BARE:master) $ git branch
> >   1.0
> >   2.0
> > * master
> >
> > core.git (BARE:master) $ git tag
> > 1.0.1651
> > 1.0.766
> > 2.0.1103
> > 2.0.1200
> >
> > I published the repo using: git push --all --follow-tags
> >
> > This succeeded, but there seem to be no tags pushed, just branches.
> > So, I followed with
> >
> > core.git (BARE:master) $ git push --tags
> > To XXX
> >  - [deleted]               1.0
> >  - [deleted]               2.0
> >  ! [remote rejected]       master (refusing to delete the current
> > branch: refs/heads/master)
> > error: failed to push some refs to 'XXX'
> >
> > And, I've found out that all branches and tags have been
> > wiped in both, local repo and remote :)
> >
> > I restored the repo and tried out
> >
> > git push origin 1.0
> > git push origin --tags
> >
> > and this time both succeeded, without wiping out any refs.
> >
> > Could anyone help me to understand why remote-less
> >
> > git push --tags
> >
> > is/was so dangerous and unforgiving?!
>
> Since nobody's replied yet, I can't see what's going on here from the
> info you've provided. My guess is that you have something "mirror" set
> on the remote.

Thank you for responding.

The git push --tags hugely surprised me, and here is genuine screenshot
https://twitter.com/mloskot/status/1068072285846859776

> It seems you can't share the repo or its URL, but could you share the
> scrubbed output of 'git config -l --show-origin' when run inside this
> repository?

Here is complete output. I have not stripped the basics like aliases,
just in case.

```
core-external-metadata.git (BARE:master) $ git config -l --show-origin
file:"C:\\ProgramData/Git/config"       core.symlinks=3Dfalse
file:"C:\\ProgramData/Git/config"       core.autocrlf=3Dtrue
file:"C:\\ProgramData/Git/config"       color.diff=3Dauto
file:"C:\\ProgramData/Git/config"       color.status=3Dauto
file:"C:\\ProgramData/Git/config"       color.branch=3Dauto
file:"C:\\ProgramData/Git/config"       color.interactive=3Dtrue
file:"C:\\ProgramData/Git/config"       help.format=3Dhtml
file:"C:\\ProgramData/Git/config"       http.sslcainfo=3DC:/Program
Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:"C:\\ProgramData/Git/config"       diff.astextplain.textconv=3Dastextp=
lain
file:"C:\\ProgramData/Git/config"       rebase.autosquash=3Dtrue
file:C:/Program Files/Git/mingw64/etc/gitconfig
http.sslcainfo=3DC:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:C:/Program Files/Git/mingw64/etc/gitconfig http.sslbackend=3Dopenssl
file:C:/Program Files/Git/mingw64/etc/gitconfig
diff.astextplain.textconv=3Dastextplain
file:C:/Program Files/Git/mingw64/etc/gitconfig
filter.lfs.clean=3Dgit-lfs clean -- %f
file:C:/Program Files/Git/mingw64/etc/gitconfig
filter.lfs.smudge=3Dgit-lfs smudge -- %f
file:C:/Program Files/Git/mingw64/etc/gitconfig
filter.lfs.process=3Dgit-lfs filter-process
file:C:/Program Files/Git/mingw64/etc/gitconfig filter.lfs.required=3Dtrue
file:C:/Program Files/Git/mingw64/etc/gitconfig credential.helper=3Dmanager
file:C:/Users/mateuszl/.gitconfig       user.name=3DMateusz =C5=81oskot
file:C:/Users/mateuszl/.gitconfig       user.email=3Dmateusz@loskot.net
file:C:/Users/mateuszl/.gitconfig       github.user=3Dmloskot
file:C:/Users/mateuszl/.gitconfig       core.editor=3Dvim
file:C:/Users/mateuszl/.gitconfig       color.branch=3Dauto
file:C:/Users/mateuszl/.gitconfig       color.diff=3Dauto
file:C:/Users/mateuszl/.gitconfig       color.status=3Dauto
file:C:/Users/mateuszl/.gitconfig       color.ui=3Dauto
file:C:/Users/mateuszl/.gitconfig       alias.br=3Dbranch
file:C:/Users/mateuszl/.gitconfig       alias.bv=3Dbranch -vv
file:C:/Users/mateuszl/.gitconfig       alias.brv=3Dbranch -vv
file:C:/Users/mateuszl/.gitconfig       alias.bra=3Dbranch -a
file:C:/Users/mateuszl/.gitconfig       alias.ci=3Dcommit --verbose
file:C:/Users/mateuszl/.gitconfig       alias.cia=3Dcommit --verbose --amen=
d
file:C:/Users/mateuszl/.gitconfig       alias.ciae=3Dcommit --verbose
--amend --no-edit
file:C:/Users/mateuszl/.gitconfig       alias.co=3Dcheckout
file:C:/Users/mateuszl/.gitconfig       alias.dc=3Ddiff --cached
file:C:/Users/mateuszl/.gitconfig       alias.df=3Ddiff
file:C:/Users/mateuszl/.gitconfig       alias.gf=3Dflow
file:C:/Users/mateuszl/.gitconfig       alias.lg=3Dlog --color --graph
--pretty=3Dformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)
%C(bold blue)<%an>%Creset' --abbrev-commit
file:C:/Users/mateuszl/.gitconfig       alias.lol=3Dlog --graph
--decorate --pretty=3Doneline --abbrev-commit
file:C:/Users/mateuszl/.gitconfig       alias.lola=3Dlog --graph
--decorate --pretty=3Doneline --abbrev-commit --all
file:C:/Users/mateuszl/.gitconfig       alias.ls=3Dls-files
file:C:/Users/mateuszl/.gitconfig       alias.lst=3Dlfs status
file:C:/Users/mateuszl/.gitconfig       alias.rt=3Dremote
file:C:/Users/mateuszl/.gitconfig       alias.rtv=3Dremote -v
file:C:/Users/mateuszl/.gitconfig       alias.st=3Dstatus
file:C:/Users/mateuszl/.gitconfig       alias.ghclm=3D!sh -c 'git log
$1...$2  --pretty=3Dformat:"* [view](http://github.com/$3/$4/commit/%H)
- %s"' -
file:C:/Users/mateuszl/.gitconfig       alias.ign=3Dls-files -o -i
--exclude-standard
file:C:/Users/mateuszl/.gitconfig
alias.prune-branches-origin=3D!git remote prune origin && git branch -vv
| grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
file:C:/Users/mateuszl/.gitconfig
alias.prune-branches-mloskot=3D!git remote prune mloskot && git branch
-vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
file:C:/Users/mateuszl/.gitconfig       alias.hist=3Dlog
--pretty=3Dformat:'%h %ad | %s%d [%an]' --graph --date=3Dshort
file:C:/Users/mateuszl/.gitconfig       commit.template=3D~/.gitmessage
file:C:/Users/mateuszl/.gitconfig       credential.helper=3Dmanager
file:C:/Users/mateuszl/.gitconfig       filter.lfs.clean=3Dgit-lfs clean --=
 %f
file:C:/Users/mateuszl/.gitconfig       filter.lfs.smudge=3Dgit-lfs
smudge --skip -- %f
file:C:/Users/mateuszl/.gitconfig       filter.lfs.process=3Dgit-lfs
filter-process --skip
file:C:/Users/mateuszl/.gitconfig       filter.lfs.required=3Dtrue
file:config     core.repositoryformatversion=3D0
file:config     core.filemode=3Dfalse
file:config     core.bare=3Dtrue
file:config     core.symlinks=3Dfalse
file:config     core.ignorecase=3Dtrue
file:config     remote.origin.url=3Dhttps://xxx.com/core-external-metadata.=
git
file:config     remote.origin.fetch=3D+refs/*:refs/*
file:config     remote.origin.mirror=3Dtrue
file:config
lfs.https://xxx.com/core-external-metadata.git/info/lfs.access=3Dbasic
```

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
