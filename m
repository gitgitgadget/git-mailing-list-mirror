From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Thu, 14 Apr 2016 17:50:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604141748370.2967@virtualbox>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com> <loom.20160407T042319-468@post.gmane.org> <alpine.DEB.2.20.1604071017510.2967@virtualbox> <CAEnbY+eaReDYOH8azpSG7n7MOrvqORkC0ar80pd1m8wR4vv20A@mail.gmail.com>
 <CAOAY-+1TztY95z3Yi34HB3aYUG5aOHKK9G3OmpYM41ugDMtJUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Daurnimator <quae@daurnimator.com>, git@vger.kernel.org
To: Cameron Currie <me@cameroncurrie.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 17:51:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqjYH-00074W-7p
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 17:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbcDNPvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 11:51:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:64115 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932709AbcDNPvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 11:51:03 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LuP5z-1boIhp2WUp-011mVI; Thu, 14 Apr 2016 17:50:58
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAOAY-+1TztY95z3Yi34HB3aYUG5aOHKK9G3OmpYM41ugDMtJUA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4DjnbCHxZOHxU95pCjGDVXsNokmW2ccFWXKPcLLUziVLALNPmTl
 b1CsOykmmmTR0FO3DOuXJqgYWSHOXMey5Se1w1q1rGMHnjfV8qU/tM6YBYtRDDuxqxdHIyO
 pdMvoGIXGgKmNawWPiBGB+3tzh02Xp4q62vIVl5+x5TntkXR+uNTqm9JRvUxKoibUhT1chZ
 4glt0MbiVyKF0VXcG9IDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OcEBqOTZiiw=:MAMB82uLh1BE5pCGYyjLzO
 fjz88F3F2ShNyULQOsBo+BNN8Y/EjPV+n4uB9Ajhwxuv7rxvOVlnOQ40uv08DZAUyxPvO1bjT
 crZ9IxlQRevZX3wKlnN9QhAx24vIWFHV5B7SVzscoveKNbxGQNaOoRPIQxPX37tcxtX/plju0
 LfwZwCKOldBuwILBYQ/v3v1QLkvJDGYJ6N4THC9b7X5+IhO4fhrW5IAk9q9RAdLqeQZlqvzsu
 rTb5wwdyp1i+YeHhodUVheZfB8KSbvO8FCZhmd0q2chkhcg3okMzUPUcknAEjF1H9XAkEu7/5
 AJDqOxDJqPZeDTir3ArzGvd01bW5wmhK4oKaz3Qg+TZjfqx62cXQj9XhpFsHcq7B4zpK5Zf/6
 ESEIqKgzCQWgWjp1xGP3y0YnKt96CynJRuKbYHNFeovmfZTkHIiuYI0PX93/O3V34tjkrVyqo
 0XjUB6Bj9YhJFh9iTxJYUtXvXcAOHgYPvb+kVTkuItE/lyL5p+JG8eDEtOaKm6sK8uRsgoyQV
 C/FnDaCP/bbpNO77kTz3dEACte4tJrpx3Fa/FJNOBFccdP2AinHVOBHL32JFMeQv62m+fec0i
 PoEJcnpAxgwv4tiRT/+5NTRuVngOTPpiWjcjfH6aiWrevmN/YjoAHZ8o6HzS0ZVHgMtW+/b2d
 JPqSYcacr5Gpja9jghKmXUFHQXutyutTP8gevuhOS8NEBa34me0xS6IVXZOpKz8hS6rxrUmDq
 FaOTT98bK1G3xZZYPsn8EmiC8UVNnTKy1wR8aQvY+H8BxF0PNQJyZ6QV+bi75dm15WmZ8vwR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291527>

Hi Cameron,

On Wed, 13 Apr 2016, Cameron Currie wrote:

> > > On Thu, 7 Apr 2016, daurnimator wrote:
> > >
> > >> Cameron Currie <me <at> cameroncurrie.net> writes:
> > >> > This is helpful for folks with commit.gpgsign = true in their
> > >> > .gitconfig.
> > >>
> > >> > https://github.com/git/git/pull/186
> > >>
> > >> I too would like this.
> > >> Bumping due to lack of attention.
> > >
> > > It lacks a Sign-off, our convention is to continue in lower-case
> > > after the colon in the commit's subject, and I think that it would
> > > be good to write so much as one paragraph in the commit message.
>
> I don't think I can find the time right now. Feel free to rewrite the
> commit message to match convention.

I am afraid that it would be improper for anybody to add your Sign-off, as
it is *your* statement that you are indeed contributing this as Open
Source, and that you indeed are free to do so.

If you do not find the time to take care of these small changes, I fear
the Git maintainer will *have* to drop your patch to avoid hassle for
himself.

Ciao,
Johannes
