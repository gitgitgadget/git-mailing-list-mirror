From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] {fetch,upload}-pack: allow --depth=0 for
 infinite depth
Date: Tue, 24 Aug 2010 09:53:41 -0400
Message-ID: <20100824135341.GA6457@coredump.intra.peff.net>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
 <1282565304-3122-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 15:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ontx6-0008QE-K0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 15:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab0HXNxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 09:53:47 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab0HXNxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 09:53:46 -0400
Received: (qmail 17616 invoked by uid 111); 24 Aug 2010 13:53:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 24 Aug 2010 13:53:44 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Aug 2010 09:53:41 -0400
Content-Disposition: inline
In-Reply-To: <1282565304-3122-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154313>

On Mon, Aug 23, 2010 at 10:08:24PM +1000, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Users can do --depth=3D2147483648 for infinite depth now. It just loo=
ks
> ugly. So make "0" special (i.e. infinite depth) at plumbing/protocol
> level.

What happens if I connect to an older server? Shouldn't "I understand
depth=3D0 is infinite" be a server capability, and we hack around it by
sending depth=3D2^32-1 when we have a modern client but an older server=
?

-Peff
