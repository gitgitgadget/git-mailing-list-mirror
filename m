From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Thu, 17 Feb 2011 23:18:40 -0500
Message-ID: <20110218041840.GB12348@sigill.intra.peff.net>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023126.GB23435@elie>
 <AANLkTikFLkXKKhZoDGAgh+i8H2fv+QNEVj7vEVABxee2@mail.gmail.com>
 <20110218041358.GB15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:19:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHo8-0002vw-Ib
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab1BRESt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 23:18:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab1BRESo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:18:44 -0500
Received: (qmail 27305 invoked by uid 111); 18 Feb 2011 04:18:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 04:18:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Feb 2011 23:18:40 -0500
Content-Disposition: inline
In-Reply-To: <20110218041358.GB15643@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167164>

On Thu, Feb 17, 2011 at 10:14:05PM -0600, Jonathan Nieder wrote:

> Nguyen Thai Ngoc Duy wrote:
> > 2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:
>=20
> >> Move sources for libgit.a to a libgit/ subdirectory. =C2=A0This wa=
y, a
> >> person wanting to tackle the reusable part of git will know where =
to
> >> look, and those looking to work on individual commands know to loo=
k
> >> elsewhere.
> >
> > You missed a few (on purpose?): block-sha1, ppc and compat.
>=20
> Yes, on purpose.  They're separately reusable.

I wonder if there should perhaps be lib/, with all of the libgit.a
sources in it, and then lib/block-sha1, lib/ppc, lib/compat, etc. Those
things do end up inside libgit.a, don't they?

-Peff
