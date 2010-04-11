From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Sun, 11 Apr 2010 02:01:18 -0400
Message-ID: <m2v3abd05a91004102301i95bf7091ib2bd9da5e8a208c1@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com> 
	<20100408231154.GB13704@vidovic> <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com> 
	<20100409034911.GA4020@coredump.intra.peff.net> <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com> 
	<20100410043535.GA22481@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 08:02:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0qF5-0002Mu-KV
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 08:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0DKGBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 02:01:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43673 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab0DKGBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 02:01:41 -0400
Received: by wyb39 with SMTP id 39so909571wyb.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0XnRJ4TqeT6jKPwLUIBxuGT9jU7v/3xB+Eh/QbYAMj8=;
        b=xNNMe681ShQj+v5DGVp1W0uIb3RhPdgxsIOzYX/aJOYZlAlLO4oGead1p2ss1Dngq6
         4LG7RUh1bKWZ3wPXxGTVZT2Ua4peQlbLwzqTaPKvp2XHlWeQkcDpMrUF6WDk389zU1rI
         enqtK9h1X/3FGhAJIFYRYZ5BUHzzL/RcdN59w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZgHTnpBSpW4OVyfxcoXxi05xt9on9+aF8lc9e3jmd7GrXEwqCeJHj4Mt8SJ/kFZyqx
         Vp7cKpSjNUwXTRFWrobajW094Idrv/rJF23RgE9Vms3PgC9efr884g3jWtJ6957x1j7I
         CQt4VW0qsUS87nFZIl6aAe1/tcEI4vimdovcs=
Received: by 10.216.157.212 with HTTP; Sat, 10 Apr 2010 23:01:18 -0700 (PDT)
In-Reply-To: <20100410043535.GA22481@coredump.intra.peff.net>
Received: by 10.216.162.198 with SMTP id y48mr1329480wek.49.1270965698107; 
	Sat, 10 Apr 2010 23:01:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144630>

King <peff@peff.net> writes:
> I think we would do better to tell the user about stash there, so the=
y
> can do it themselves. Then they know where their changes went and how=
 to
> get them back. Since v1.6.5.5, this error message now says:
>
> =A0Your local changes to '%s' would be overwritten by merge. =A0Abort=
ing.
> =A0Please, commit your changes or stash them before you can merge.
>
> What version of git are you using? If you (or others you are helping)
> saw that message and it wasn't helpful, do you have any suggestions f=
or
> how to improve it?

Yes we have the latest version and we do see this message. This helps
a bit. Although for people used to CVS/CVN the "stash" is yet another t=
hing
to learn. There is also a high probability for new users to see this me=
ssage
very early when using git and the question is always the same: why can'=
t git
just merge with my files and show me the conflict?

(There was also some usability issues with the "stash", I remember peop=
le
loosing _untracked_ files but I am not sure if that was PEBKAC. First v=
ersions
of stash had a very friendly syntax that punished you by obliterating y=
our files
if you made a typo and some are still traumatized.)

Simply put: in git, your working directory is a second class citizen an=
d git
doesn't want to deal with it. Fundamentally, this is in a collision cou=
rse with
what some users think about their work in progress.

I started a similar discussion had a couple years ago:
http://lists-archives.org/git/635926-git-pull-opinion.html

Back then, I was certain that 'git pull' should have an option to mix w=
ith a
dirty tree but now, after a couple years of using the tool, I am not ce=
rtain
anymore. I am just reporting the biggest frustrations I see with new us=
ers.

Thanks,

  -- aghiles
