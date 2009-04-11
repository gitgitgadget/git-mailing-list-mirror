From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 16:07:56 +0200
Message-ID: <20090411140756.GA15288@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 16:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsdyB-0003PV-4c
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 16:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbZDKOIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 10:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbZDKOID
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 10:08:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:41866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbZDKOIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 10:08:01 -0400
Received: (qmail invoked by alias); 11 Apr 2009 14:07:58 -0000
Received: from i59F5409B.versanet.de (EHLO atjola.local) [89.245.64.155]
  by mail.gmx.net (mp039) with SMTP; 11 Apr 2009 16:07:58 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+7IVxKtc+7DSAsqBMozL5UqUHmHbOTGYDQSbCXj4
	5FfiAv2Rp9QtVN
Content-Disposition: inline
In-Reply-To: <20090411134112.GA1673@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116298>

On 2009.04.11 15:41:12 +0200, Bj=F6rn Steinbrink wrote:
> On 2009.04.10 18:15:26 -0700, Linus Torvalds wrote:
> > It obviously goes on top of my previous patch.
>=20
> Gives some nice results for the "rev-list --all --objects" test on th=
e
> gentoo repo says (with the old pack):

And for completeness, here are the results for linux-2.6.git

     | With my patch | With your patch on top
-----|---------------|-----------------------
VSZ  |        460376 | 407900
RSS  |        292996 | 239760
time |       0:14.28 | 0:14.66

And again, the new pack is slightly worse than the old one
 (window=3D250, --depth=3D250).
Old: 240238406
New: 240280452

But again, it's negligible.

Bj=F6rn
