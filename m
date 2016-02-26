From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rebase performance
Date: Fri, 26 Feb 2016 16:45:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602261644570.3152@virtualbox>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com> <CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com> <vpq37sg4s0l.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-296925318-1456501525=:3152"
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZKad-000180-3b
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 16:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbcBZPpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 10:45:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:63849 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbcBZPpr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 10:45:47 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYtId-1aMpkE0APz-00VjEr; Fri, 26 Feb 2016 16:45:33
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <vpq37sg4s0l.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-ID: <alpine.DEB.2.20.1602261645300.3152@virtualbox>
X-Provags-ID: V03:K0:DEqtS+xeAWkrxyyhWY8WjE0lQ6QCrum/nHXsXKFbsZbUoSr/N6M
 +gauOw6BkD5v4eEX/vf1u1KSc73DdD54QXC9IimdbjO/FgjkkttJrhpMdI+0ki8vx8G/gb8
 CSbnazLwo9HHXyFuK6XRT+6sVR/LIbZlbRzS5cAf+fRdO5UVEY3T4PT0sxl9KZJbWOKClz1
 g25CudjVCEA7gBX7x+CDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fiAaBlut5wc=:TtUZKFhGnrh8hpj/6AAdgn
 NGG+0f3d0sGoKTEC2Yv2itWWePZcIPD9hQFqi0w33J7imU+vymlMJ86g80c0h+7dRh+tHbkSZ
 GU0bGGgdM6YcnYB0AlsFK/dwnZhYe0klugYtUK+ml3OKzYr+Z/qmvqgC3nSzsyBw3vNCgoX3q
 cev30jyDObQYoHiplx7icKB0toOr87fTSwplSCVnzGSeIpnQUlVcE5Zy1tBCGi+2GMRNYhU6A
 RkgNnpuCVLp4liG3ezLZU9g9onvDmViHZQjgAnGH/nTTfoWxhL5w5DRFbzqFGeB6zxMEj3e5c
 sy1kKWXfc+gumD385GdQNwvl2uVV7fRm1g6pgVj6+eIKGvIW+GRgExFDGhOFlvzfI6rtEHPwY
 J6qIu0/JPvBUdI6q7vbix6CF8ZMFGqm8UptkwKv+zziZd4AdBHtomSnKik30mFbLgjJXwEPvI
 VXXd1yG0v1pzYiLj40R+HfSS6ca1/g4u65T7EYUqasDlthDUaZp9BjOqxrAvzazh+U4mliJc7
 h4M+3/m58icFFnv++09TzTujqomwL0wTJoEAfI1bc3uCn+gbivMlMgPmD9b+YRAIE2pW2LgfL
 XHuMo7PYmzEL6ffBLnsuIjQiBQV4pVYGrL88avzqYj33IAXkfxuwQwU2FapfrBpC8j6Q2Bmpb
 lbzmGPCaI/STcxb56rJ7iaOQQxCkiB0DIu05IT8utrlG0/7fSrIo39I20BrEATgyB2qvAlb74
 8mGxPu+I4UXmqp0El9QYzmcP9spkS5sfK5WwiqzLf4JFThrOH507b2VR2AzjUdhw53lm+wQ2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287579>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-296925318-1456501525=:3152
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1602261645301.3152@virtualbox>

Hi Matthieu,

On Thu, 25 Feb 2016, Matthieu Moy wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > At the risk of derailing this thread, a thing that would make rebase
> > even faster I think would be to change it so that instead of applying
> > a patch at a time to the working tree the whole operation takes place
> > on temporary trees & commits and then we'll eventually move the branch
> > pointer to that once it's finished.
> >
> > I.e. there's no reason for why a sequence of 1000 patches where a
> > FOO.txt is changed from "hi1", "hi2", "hi3", ... would be noticeably
> > slower than applying the same changes with git-fast-import.
>=20
> Also, not touching the worktree during rebase would have the advantage
> that if the final result doesn't change a file, we wouldn't need to
> touch this file at all, hence the next "make" (or whatever
> timestamp-using build system the user runs) would consider this file
> unchanged.

We still have to write all blobs. So I would still expect this to be I/O
bound.

Ciao,
Dscho
--8323329-296925318-1456501525=:3152--
