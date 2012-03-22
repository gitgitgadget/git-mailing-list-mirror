From: Jeff King <peff@peff.net>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 10:01:40 -0400
Message-ID: <20120322140140.GA8803@sigill.intra.peff.net>
References: <4F69AD3C.4070203@ericsson.com>
 <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 15:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAiaK-0000Us-13
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 15:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976Ab2CVOBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 10:01:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab2CVOBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 10:01:42 -0400
Received: (qmail 1093 invoked by uid 107); 22 Mar 2012 14:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 10:01:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 10:01:40 -0400
Content-Disposition: inline
In-Reply-To: <4F6B1F48.3040007@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193658>

On Thu, Mar 22, 2012 at 01:47:04PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> Yes, this will indeed fix this particular problem. But in general,
> empty files can be used for various reasons, and it can be a pretty
> nasty surprise if they sprout random content as a result of a merge.
>=20
> Maybe merge-recursive could special-case empty files?

I was thinking the same thing. And it seems this came up once before,
and the list seemed to favor special-casing merge-recursive (but not
diffcore):

  http://thread.gmane.org/gmane.comp.version-control.git/116917/focus=3D=
117082

-Peff
