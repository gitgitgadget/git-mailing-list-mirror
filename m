From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 19:00:56 -0400
Message-ID: <20120322230056.GC14874@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net>
 <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org>
 <4F6B84DF.8040806@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:01:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAr0C-0002OH-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031011Ab2CVXA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 19:00:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57025
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755598Ab2CVXA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:00:58 -0400
Received: (qmail 6900 invoked by uid 107); 22 Mar 2012 23:01:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 19:01:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 19:00:56 -0400
Content-Disposition: inline
In-Reply-To: <4F6B84DF.8040806@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193728>

On Thu, Mar 22, 2012 at 09:00:31PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> Maybe:
> --- 8< ---
> When set, case-insensitive comparisons will be used when internally
> comparing file names.
>=20
> The default is false, but when a new repository is created by
> git-clone[1] or git-init[1], git will probe the filesystem and set it
> to `true` if the filesystem is case-insensitive.
>=20
> On case-insensitive filesystems like FAT, NTFS and HSF+, names that
> differ only in capitalization, like "Makefile" and "makefile", refer
> to the same file. While such filesystems usually preserve the
> capitalization used during file creation, tools designed for such
> filesystems will often modify capitalization when saving files and
> when displaying filenames. Enabling core.ignorecase causes git to
> ignore case-only differences in file names.
>=20
> Enabling core.ignorecase on a case insensitive filesystem does
> not make sense, because filenames with different capitalization will
> still be treated as different by the filesystem.
> --- >8 ---

=46rom his response, I guess Junio does not agree, but this is my favor=
ite
of the texts proposed so far.

-Peff

PS If we do use it, it needs s/HSF/HFS/.
