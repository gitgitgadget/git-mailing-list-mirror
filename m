From: Stephen Bash <bash@genarts.com>
Subject: Re: Passing commit IDs to git-archive
Date: Mon, 12 Mar 2012 09:24:40 -0400 (EDT)
Message-ID: <57b23100-a04d-4eca-bb0e-35455464ec5c@mail>
References: <20120312114742.GC12921@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 12 14:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S75GE-00072Y-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 14:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab2CLNZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 09:25:20 -0400
Received: from hq.genarts.com ([173.9.65.1]:20832 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755477Ab2CLNYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 09:24:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id F0258BE971E;
	Mon, 12 Mar 2012 09:24:46 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gkx7QmPCBwAN; Mon, 12 Mar 2012 09:24:40 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6A278BE984B;
	Mon, 12 Mar 2012 09:24:40 -0400 (EDT)
In-Reply-To: <20120312114742.GC12921@sigill.intra.peff.net>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192867>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Monday, March 12, 2012 7:47:42 AM
> Subject: Re: Passing commit IDs to git-archive
>=20
> On Fri, Mar 09, 2012 at 05:14:05PM -0500, Stephen Bash wrote:
>=20
> > on Mac OS 10.6.8 (obviously this is local testing, the goal is to
> > use ssh remotely).  After parsing the error "no such ref" I
> > attempted the same operation using master as the tree-ish and
> > archive worked as expected (either specifying the path separately o=
r
> > using the colon syntax to reference the tree directly).  Is there a
> > reason git-archive requires a named ref rather than just a commit
> > (or tree) ID?
>=20
> Yes; generally git repositories do not allow clients to access
> arbitrary sha1s. Instead, they require that the requested objects be
> accessible by a ref.

Jeff: thanks for the concise summary.  I thought that might be the case=
, but wanted to confirm.

Junio and Ren=C3=A9: thanks for the input and ideas. Seems I'll be inve=
stigating my options today.

Thanks,
Stephen
