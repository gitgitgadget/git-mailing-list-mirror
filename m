From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Sun, 14 Dec 2008 19:06:45 +0300
Message-ID: <20081214160645.GA21358@myhost>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com> <20081214145518.GA26380@mail.local.tull.net> <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Andrew <nick@nick-andrew.net>, git@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Lew <lukasz.lew@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 17:08:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBtVs-0003AX-3C
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYLNQGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2008 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYLNQGs
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:06:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:45505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYLNQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:06:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1003246fgg.17
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lnR7J8U6+VEI9jpD9OnfpyoNl7OcgCesgONjiMlD34w=;
        b=b56t6hNKxtE+WpRiHERxOBrBsL5g25UHpjflIKxUOxwXWseWX6vHFuoTJKS+duZ70F
         DCTED1vZ2i3Ob6vghFsLQ7nF5IlFHEWkPk6CxMYd/85ZG/+qwEkch8Ceqf/jUj6EPFFN
         BJYnNVDy4rVqpOA6ZtBOG+XNPScQJetG9TAgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kiXG6gEE4vPVuCRL1OyGJeE00oEJgg4SpTju6ZLUyBZnGq/3yoHP8bMnkxT+FKAbHQ
         dDkZWFSxU098sVTlZVGk8pMYigv8MVgxyhDflzwEb5DpY2JAQFIRZn/mEQfczUGh1Qrt
         2FmefwzpDR5Xt3WjEpbYbUmsTMlT1jxIcsjiI=
Received: by 10.86.95.8 with SMTP id s8mr3169349fgb.79.1229270805712;
        Sun, 14 Dec 2008 08:06:45 -0800 (PST)
Received: from smtp.gmail.com (ppp91-78-101-148.pppoe.mtu-net.ru [91.78.101.148])
        by mx.google.com with ESMTPS id l19sm4171524fgb.16.2008.12.14.08.06.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 08:06:44 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sun, 14 Dec 2008 19:06:45 +0300
Content-Disposition: inline
In-Reply-To: <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103088>

Hello, =C5=81ukasz!

On 16:38 Sun 14 Dec     , =C5=81ukasz Lew wrote:
> Thanks Nick, thats really helpful (and surprisingly simple).
> I have a couple more questions:
>=20
> On Sun, Dec 14, 2008 at 15:55, Nick Andrew <nick@nick-andrew.net> wro=
te:
> > On Sun, Dec 14, 2008 at 02:49:50PM +0100, =C5=81ukasz Lew wrote:
> >> I don't know how to make such a scenario work:
> >> - two repositories: pub, priv
> >> - priv is clone/branch of pub
> >> - there is some constant developement both in pub and priv
> >> - there are regular syncs with pub in priv
> >>
> >> Problem:
> >> Occasionally I want to push some changes from priv to pub.
> >> Then after syncing with pub I want to get as few conflicts as poss=
ible.
> >>
> >> Is it possible to do with git?
> >
> > Git can do almost anything. One should instead ask "How to do this
> > with git?" :-)
>=20
> So I've heard, but not yet experienced it myself. I'm thrilled to try=
=2E
>=20
> >
> > If I understand your problem, you could solve it with git cherry-pi=
ck
> > and rebase. On priv, make a for-public branch from a pub branch. Th=
en
> > cherry-pick the commits you want from your private branch into the
> > for-public branch.
>=20
> That almost works. Can I somehow split existing commits just like in =
git-add -p?
It's, however, better to make more commits to not experience the need o=
f
commit splitting.

But you can use '--no-commit' option of 'git cherry-pick' and 'git merg=
e'
(and 'git pull' as well as 'git merge'). For example:

	git cherry-pick --no-commit <sha1>    # cherry-pick without commiting
	git reset --                          # unstage all changes
	git add -p                            # patch update

You can also use 'git add -i' (interative mode) instead of 'git add -p'=
=2E

>=20
> > Push your for-public branch to pub,
> > then rebase your private branch.
>=20
> Rebase to the tip of master? Is it needed? Ie. cherry-pick does not
> remove the patch from
> the master in priv.
>=20
> If I now pull from pub, I will get the same change and it mereges nic=
ely :D
>=20
> Can I get away without creating for_pub branch? maybe cherry pick in
> pub from priv somehow?
>=20
> >
> > Nick.
> >

					Alexander
