From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Introducing vcsh - manage config files in $HOME via fake bare git repositories
Date: Tue, 20 Dec 2011 12:05:22 +0100
Message-ID: <CAD77+gSGeE=nKy=LFAHMv3r0=Lpab8T+0vou_OWXN=ir8C55Vg@mail.gmail.com>
References: <CAD77+gTO35ZFdcOjTEEcymgDKMq4Uh3JZcqgXWR07kGksfkBqg@mail.gmail.com>
 <CAMK1S_hc4H7rUSY=SSR0EZwgBLy9CGa7b5H44eP6=fw+YC-inw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 12:06:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcxW3-0001Pk-Kx
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 12:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab1LTLFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 06:05:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55324 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1LTLFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 06:05:45 -0500
Received: by wgbdr13 with SMTP id dr13so12309117wgb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 03:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1kEVZ0aEAV9SdVpZGkNKO6pKJ4sTCHyLhSmdrN47b+w=;
        b=o3cqrzIXnnx1jesgvh87nky6jGrzqSML6c8W0tkgmvwqrLKKpCCQMQuA85XL3bllI4
         5+2pC/DWYA09fgns75TyS65gi8DagTBPR7f5/Qnkgk7bXpdteCeoXZLRrPABI8jps4K1
         3cWVjbRzPt0ht7GSnqUNC58NH0QLZ/ExzsJa8=
Received: by 10.227.207.134 with SMTP id fy6mr1572899wbb.13.1324379144244;
 Tue, 20 Dec 2011 03:05:44 -0800 (PST)
Received: by 10.216.10.208 with HTTP; Tue, 20 Dec 2011 03:05:22 -0800 (PST)
In-Reply-To: <CAMK1S_hc4H7rUSY=SSR0EZwgBLy9CGa7b5H44eP6=fw+YC-inw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187507>

On Tue, Dec 20, 2011 at 03:25, Sitaram Chamarty <sitaramc@gmail.com> wr=
ote:

> My reasoning is that nothing is an island. =C2=A0I am a heavy user of=
 vim,
> fugitive (git plugin for vim), tig, and ranger, and at least these 4
> are linked to each other. =C2=A0You could argue that I should use
> submodules or gitslave or something but I keep it simple.

Or mr[1]. That's _exactly_ what mr is for.


> =C2=A0Even my
> "irssi" settings are tied into that, because of certain macros I use
> to reply quickly to queries.

I doubt you want to keep your IRC passwords on a work machine, for
example. If you need repos to be together, check them out together.
But I doubt you want _everything_ _everywhere_.


> There's a piece of my ".additional.bashrc" that automatically symlink=
s
> everything that are best left in $HOME (like ~/.gitconfig) and sets u=
p
> environment variables for everything else (like TIGRC_USER) that can
> get along without.

Symlinks are unclean, imo.

Personally, I like to use .zshrc.$HOSTNAME for local stuff. This sorts
more nicely than .$HOSTNAME.zshrc .


> There are 2 helper scripts. =C2=A0One packs all of this into a tarbal=
l so I
> can easily untar it on any machine on which I have to work
> temporarily, and the other cleans up the unpacked directory and
> symlinks when I leave.

Cloning from public repos seems to make more sense, especially if you
make local changes.


> Just offering a different perspective.

Appreciated. It's always great to know how others are approaching this.


Richard
