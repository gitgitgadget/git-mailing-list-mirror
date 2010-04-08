From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git pull suggestion
Date: Fri, 9 Apr 2010 01:11:54 +0200
Message-ID: <20100408231154.GB13704@vidovic>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> <201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 01:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O00tO-00039S-S2
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 01:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933795Ab0DHXMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 19:12:06 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:57084 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933780Ab0DHXMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 19:12:01 -0400
Received: by bwz1 with SMTP id 1so2175614bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2XKVi02cApKK4zl2m941eXZW5Rn4qdze7ge0kOfbmL8=;
        b=bF+DENSNHbPnobjhOzmqsj1cgtgbutRkmeEn5Xnh/j9zQKAQIUcLXy/uD7W5wi9bFH
         7PZfaJYkGae4glEBOrYmydoiOMpMqKKegA2afeL8Nvqa7GDCnVl3hVrp1L4bQk9+k/cx
         8Jh2JyNDOZ8ztKG3VE+Jfu1BfcQ8GGIe3Syyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NjgUlPoWlSLnVomnKvRdZPvM2iR5xIPGGB1CduZR+eRhUS4VFARf33pGk9W9jVD9QH
         /wYagJBOjbrB9qOtI3BalRC9UeT7+ilnGM2Je+WVYuKLTDraDgclQiZu80QHM1Y4mWuh
         3Myc31U6t3RXiaTndry9U5gv+Wh2uM/3TKsUM=
Received: by 10.204.34.81 with SMTP id k17mr905361bkd.78.1270768317617;
        Thu, 08 Apr 2010 16:11:57 -0700 (PDT)
Received: from @ (88-121-119-67.rev.libertysurf.net [88.121.119.67])
        by mx.google.com with ESMTPS id x16sm4220867bku.11.2010.04.08.16.11.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 16:11:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144387>

The 08/04/10, Aghiles wrote:
> >>
> >> It would be nice to have _all_ the WIP conflicts listed when pulli=
ng.
> >> As of now, one has to fix the currently showed conflict to see the=
 next one.
> >
> > Are you using 'git pull --rebase' or the equivalent
> > branch.<name>.rebase setting?
> >
> > If so, note that git-rebase (which does all the hard work) can't kn=
ow
> > the later conflicts once it hits the first one: your resolution of =
the
> > first conflict constitutes the base onto which the further patches =
are
> > applied. =A0So depending on what changes you make during the resolu=
tion,
> > there may be more or fewer conflicts in the rest of the rebase.
> >
> > If not, I can't see how your question makes sense as ordinary 'git
> > pull' does a merge, and during a 'git merge' there can only ever be
> > one conflict resolution phase.
>=20
> Sorry, my explanation was not clear. I am talking about changes in th=
e
> working directory that are not in the index. So my working directory =
is
> "dirty" and I just issue a 'git pull'. Because some files are not "up=
 to date"
> git would abort the pull, saying that a certain file is not "up to da=
te".
> So I was suggesting to list all the "problematic" files in one go ins=
tead.

Doesn't 'git status' ouput what you want ? Or am I out of the scope ?

--=20
Nicolas Sebrecht
