From: Jeff King <peff@peff.net>
Subject: Re: The outputs of "git fsck --full" are not same. sometimes the
 outputs are OK, but sometimes it says a corrupted object.
Date: Mon, 7 Mar 2011 11:21:43 -0500
Message-ID: <20110307162143.GC11934@sigill.intra.peff.net>
References: <4D73AC10.90902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?7J206rec7ZiV?= <leekyoohyung@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 17:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwdBy-0004UM-5R
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab1CGQVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 11:21:48 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59710 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab1CGQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 11:21:47 -0500
Received: (qmail 5402 invoked by uid 111); 7 Mar 2011 16:21:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 16:21:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 11:21:43 -0500
Content-Disposition: inline
In-Reply-To: <4D73AC10.90902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168595>

On Mon, Mar 07, 2011 at 12:45:20AM +0900, =EC=9D=B4=EA=B7=9C=ED=98=95 w=
rote:

> I am using GIT to control the version of documents in my office.
>=20
> and I think it is very useful solution to manage Word, Powerpoint and=
 Excel documents.
>=20
> But there is one problem. The outputs of "git fsck --full" are not sa=
me.
>=20
> sometimes the outputs are OK, but sometimes it says a corrupted objec=
t.

=46sck should be deterministic. So either there is a bug in git, or the=
re
is a problem with your hardware. Have you tried copying the repository
to a different machine and repeating your fsck? I'm wondering if your
disk is bad and giving inconsistent data.

-Peff
