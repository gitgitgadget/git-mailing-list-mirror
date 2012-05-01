From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 09:14:24 +0530
Message-ID: <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 05:44:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP40u-0000YD-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 05:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab2EADoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 23:44:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63382 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab2EADoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 23:44:25 -0400
Received: by obbtb18 with SMTP id tb18so376717obb.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Nf0/KiI4BqHoy6vd2SvXR8yVe6U4j7Bm/XivFSaS/HU=;
        b=XDcT2XsTsKuKlYUdz6H8Lsix+J3E8187f29JN/buY8mE+c7Kx3eVKd6h9NiY/RiMG9
         4WJ07K5jReUHE2vVWTN/O+WgGF+KwOnhwtr+/E+4TjqRt8qgHW8WQuq3IjVF2hN6gplC
         SBY6hPprUrRQQgXPfwKckoMZlOgeQDfeZAdDhYnqkmduzuzeX7uH/p+wjS9bKvDCjndD
         dWnilYAhuxNdkUqPKQU8EBBGSfPM1UptGWe4+juPlvKTdzla0tIj6Q5tYsKHac9yhmpr
         o5dOPXAfJYZdIO53CvxAdjcLf1QVuyt5JkG9yioKusZoZ3+nUopiCFQ2zlPymjm0irXK
         nUTA==
Received: by 10.182.44.74 with SMTP id c10mr6429974obm.43.1335843864654; Mon,
 30 Apr 2012 20:44:24 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Mon, 30 Apr 2012 20:44:24 -0700 (PDT)
In-Reply-To: <4F9F3919.6060805@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196652>

I've been reading the thread with interest.

People who know far more than I do about git, its innards, and its
design have been responding in this thread so consider this a git
*user*'s point of view:

On Tue, May 1, 2012 at 6:45 AM, Rich Pixley <rich.pixley@palm.com> wrot=
e:

> Multiple heads are the idea that a single commit can "branch" in the
> repository and that both commits can be HEADS of the same branch at o=
nce in
> a single repository. =C2=A0This allows a potential collision to exist=
 in the
> repository and to be pushed and pulled through multiple repositories.=
 =C2=A0It

That is bizarre; I have no other word for it.

I teach git (occasionally), and if this feature existed I would
totally ignore it in my teaching material because I wouldn't know how
to defend or explain the need for "hydra branches".

It's like having two people with the same first name *and* last name
(a situation that is not impossible in real life, but is rare and
almost always requires special handling).

Does Hg do this?  That would explain why my (admittedly half-hearted)
attempts to learn it have failed -- whatever tutorial I used must have
been written with the idea that hydra branches are intuitive and
logical and sane, but did not express the concept as clearly and
succinctly as you did.

Thanks for this insight; my next attempt to understand Hg, should I
ever be forced into it, might actually succeed!
