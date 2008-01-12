From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 04:05:46 -0500
Message-ID: <20080112090546.GA8284@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDcJk-0008To-TG
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbYALJFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 04:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbYALJFt
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:05:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1207 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbYALJFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:05:48 -0500
Received: (qmail 5486 invoked by uid 111); 12 Jan 2008 09:05:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 04:05:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 04:05:46 -0500
Content-Disposition: inline
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70300>

On Sat, Jan 12, 2008 at 04:04:32AM -0500, Jeff King wrote:

> On Sat, Jan 12, 2008 at 09:47:48AM +0200, Ismail D=F6nmez wrote:
>=20
> > Removing part3.c
> > ./test-lib.sh: line 193: 19413 Aborted                 git-clean
> > * FAIL 5: git-clean with prefix
>=20
> Junio, can you please sanity check this fix (it stops the valgrind
> error, but I want to make sure my assumptions about match_pathspec ar=
e
> right).

Oh, and Ismail, can you please confirm that this causes t7300 to pass
for you?

-Peff
