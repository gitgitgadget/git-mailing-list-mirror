From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 19 Oct 2013 23:51:39 +0200
Message-ID: <20131019215139.GX13967@paksenarrion.iveqy.com>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ben Straub <bs@github.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spe
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Oct 19 23:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXeRv-0005ak-Oh
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 23:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3JSVw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Oct 2013 17:52:26 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:57805 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab3JSVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 17:52:25 -0400
Received: by mail-lb0-f178.google.com with SMTP id o14so264179lbi.23
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MtZcnToLLsrL3cCYmZhl21WS/doLpWQpHZdkdF89gyE=;
        b=t9b55w4Ut29BMVLs3B2cBIDmrHuVhFdNUD6blBStehTAo16PILRrSu+iKfwcepfYQk
         zLtABsfgbCPx8/06IPx7xnpTMinbCcwBZV5062+u7uzhOo5ElipXEIwIS/lIiuq9vp7v
         WNkWOIePxzCcKbTaj7Rr//dRzD0SPorNZQbop/MDcPxXs8GF6Cot4vVTzm7GLov+XX0i
         MUSmGTPAl0kk7akDeIwFidPUEHGdshaodLSkIx5RLAXT77aVi7wN/V+jk/UtuRDeqvUh
         T80xi3u0s1IGeZk5Bcfa7M4PdoH34jp4rrEUIUk342m5GPxRnL/PBocBCYWA4iTXEjXz
         7qYg==
X-Received: by 10.152.23.5 with SMTP id i5mr7339952laf.8.1382219543769;
        Sat, 19 Oct 2013 14:52:23 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id ac2sm6563292lbc.10.2013.10.19.14.52.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 14:52:23 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VXeQt-0006O1-Mp; Sat, 19 Oct 2013 23:51:39 +0200
Content-Disposition: inline
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236410>

Hi,
so I was a GSoC:er, I got some (most) of my code merged but didn't full=
y
met my (personal) goals for the project. However I do passed in the eye=
s
of Google.

GSoC is _hard_. You end up feeling completely stupid over and over
again. Git has hard standards. Beeing just a single programmer and/or
just learnt programming in school, there's a lot of difference.

I started with learning git (better), read documentation and looking
at the codebase and still felt lost.

After that I'd to learn communication skills, who to mail, when to mail=
,
how to write a commit message, been real strict with codestyle,
setting up a github account, configuring git in a "git contributor
friendly way", etc.

On Sat, Oct 19, 2013 at 08:09:33AM +0200, Thomas Rast wrote:
> Theories
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> These are the hypotheses that I have heard (mostly in [1] and [2]) as
> to what is bad about Git's prior GSoC participations.
>=20
> * Aiming far too high, focusing on cool/shiny projects with a large
>   impact.  This also affects the students, who tend to cluster around
>   the largest, shiniest project suggestions.
>=20
> * Diminishing returns: Git is too mature, with little low-hanging
>   fruit left, making such projects harder
>=20
> * Projects are too political, progress depending on non-technical
>   arguments
>=20
> * Our mentors suck on various axes, notably not supporting students
>   enough in things that matter:
>   - smooth interaction with community
>   - ensure fast iteration/short cycles
>   - navigating the code base
>=20
> * Scope creep: projects tend to get blocked on some bigger
>   refactoring/restructuring task that was not in the original proposa=
l
>=20
>=20
>=20
> * View GSoC much more as a lot of work than free labor

Totally agree, GSoC is an investment for future labor, not labor.

>=20
> * Break projects into smaller, easier tasks
>   - They should individually be simple, quick things if the mentor di=
d
>     them.
>   - Should be parallelizable so students don't have to block on revie=
ws.

I'd 5-6 smaller projects setup for the summer, I think I managed to do
2-3 of them. (I did however do everything I applied for). I really thin=
k
it's an excellent idea. This also meant that while one patch waited for
review, I'd other things to work on.

>=20
> * Mentoring improvements:
>   - Always have a co-mentor
>   - Focus on social aspects (who to Cc, etc.)
>   - Nominate separate "review mentors" to ensure fast review cycles

I like the idea of review mentors. However bear in mind that you'll
already have three people reviewing the patches (two mentors and Junio)=
=2E
We will not make it look like it's impossible to get things into
git.git.

> * Have students review some patches

This would be excellent. That's a part that I thinks is very usefull an=
d
would easy students remaining with git. It's easier to review patches
than to make them.


As a last part I would say that GSoC learned me a lot. I'm good at git,
I know test driven development, I learned shell, I got to play with a
huge C-codebase for the first time and I learned open source projects,
QA, etc.

I would like to thank Jens and Heiko for good mentoring and a lot of
patience!

(as a sidenote, I did get extremly busy when the school started. I
didn't even had time to fix a serious bug in my code (Jens had to clean
up after me). However two years later I'd some time again and got a few
patches in and I hope to get a few patches into git in the future too).

A successful GSoC for git isn't a merged project but continued
contribution to git (not necessairly in patches, but also in support an=
d
review).

A successful GSoC for Google/student is a merged project.

A successful GSoC for student is a great learning experience.
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
