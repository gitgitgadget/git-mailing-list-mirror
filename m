From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 07:34:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601150730440.2964@virtualbox>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de> <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com> <5697E550.9020102@ramsayjones.plus.com> <56981DC2.6070706@kdbg.org> <5698415E.7070907@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJxy1-0001xQ-1u
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 07:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcAOGed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 01:34:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:55778 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcAOGec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 01:34:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MfEMs-1aVZbB0NSs-00OpIO; Fri, 15 Jan 2016 07:34:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5698415E.7070907@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:g5EWNYApV2qGbZVgEnlfuLLs++Sw5hNNV0ayezPfPm1K6QhFYrK
 d1AHSXfEEfztJNxUHXoLY1y9mhignBLtTTPUPvDgom0hI5kFD8lLdOQ9TI0uFRuGQbZzOyr
 Dc9lmKUyGkpxc9ZqMdFVBYgYnhnMX9gtCHvGFz1dR3KEbztsfyjuOGjt5eIrR0nUq+EBLIy
 vL/geYMRk9zwoyq+roS7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+ODWOmSzn5U=:usvIglpGqfe98bmnoHWkfn
 WCNKiJZmlKniwDaikfQsQ3Il2vtHqpTpfxTl0tCutKOTQHk6ThwhT4/ajOZPBJBJE7JyxPyT/
 JaK+97kDs4vv1GBDr+DixNPLFBKOTDENpsZbpYSR1LAq8EbvvonCopUB2n3zzLUX86mlhX4Q9
 FvHf4a5Kk5wndcOqYObcGUgf1NH9+FSqO9E4WMaO+DJ/AhCk54wObhvzl3vSbq6BAR98Fo6ne
 olNke4x9CKeyyIXDqftd8qmcCQeuwsV/uqMGbOAe19Noy/DvxEU9oKWVKfNJP9yJINHdlXExG
 YOOHpo16ESY2Qx8I8e9ZG9UHlf+kYY0fwCeGTf/gvazNm9VOJ5ejnDP8pdm324kjl3ONc+NP9
 9e+bkgRGxYXOgSlcfTVN2yw6S0ewtSitqtsDgk60YIIrVsgtnfj9uTxLKK0FIWux4uhFjERWg
 VsU+MxDE8a2ZFpBWt0nLGCY5wPf06/L2wnENRjNJurMtZLAT6iRd9OD5zTGRht78YRWJUbJzN
 CX3sT9n1sQ9l1Hxv7GeG3RKH+9W66YAmSlT+MpFN6wYS/ZR24yULq/w317IoVomr5o9oLeJse
 JYATzaRmJ+xb1PsUNGJW8yZA6Vq7IWmmyxedh9CEWmC+ma7wFJhU1ULteCR9+PjL/w+hFOSBZ
 B9tejkC5NvoFCAWBLE866YufXYPRafd4SFrsQQplXbac+ybH3wVIJHS9XipB4ZxketCs4mZ9o
 oEVbZcitRd7RpNLYHy8JBVxPgd1fv/Bat9AOMC3MwWwUOKWTvwKPiaWlqx2gAwc9Zkkv0FBN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284135>

Hi Ramsay,

On Fri, 15 Jan 2016, Ramsay Jones wrote:

> On 14/01/16 22:14, Johannes Sixt wrote:
> > Am 14.01.2016 um 19:13 schrieb Ramsay Jones:
> >> Correct me if I'm wrong (quite possible), but _each_ drive has a
> >> current working directory associated with it in win32, so it's a bit
> >> difficult to use drive designators with a relative path (eg.
> >> C:usr/lib).
> > 
> > As far as it matters for Git, such a path is still an absolute path,
> > because it is not anchored at $(pwd).
> 
> [...] seems to contradict what you say above.
> 
> What am I missing?

The missing bit is: while C:usr/lib is *not* anchored on $(pwd), it is
*still* not an absolute path because it is anchored on the current
directory of the C: drive (the entire idea that some drive state can
change the meaning of "C:usr/lib" makes it a non-absolute one).

Since this concept -- a path that is neither relative to $(pwd) nor
absolute -- does not exist on Linux, I do not think that Git for Windows
handles this case well at all.

Ciao,
Dscho
