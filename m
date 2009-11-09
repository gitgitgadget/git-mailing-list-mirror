From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/4] Teach the --multiple option to 'git fetch'
Date: Sun, 8 Nov 2009 20:08:24 -0500
Message-ID: <20091109010824.GA17414@coredump.intra.peff.net>
References: <4AF6E7DE.1020201@gmail.com>
 <76718490911081659u318ea362l29342a9b3d90f03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 02:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7IkR-0007i1-AV
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 02:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbZKIBIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 20:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZKIBIa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 20:08:30 -0500
Received: from peff.net ([208.65.91.99]:56469 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZKIBIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 20:08:30 -0500
Received: (qmail 24447 invoked by uid 107); 9 Nov 2009 01:12:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Nov 2009 20:12:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Nov 2009 20:08:24 -0500
Content-Disposition: inline
In-Reply-To: <76718490911081659u318ea362l29342a9b3d90f03f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132434>

On Sun, Nov 08, 2009 at 07:59:46PM -0500, Jay Soffian wrote:

> 2009/11/8 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
> > Add the --multiple option to specify that all arguments are either
> > groups or remotes. The primary reason for adding this option is
> > to allow us to re-implement 'git remote update' using fetch.
>=20
> Can't this be determined automagically by inspecting the arguments? I
> believe there can be two unambiguous usages:
> [...]
> "The format of a <refspec> parameter is an optional plus +, followed
> by the source ref <src>, followed by a colon :, followed by the
> destination ref <dst>."

Isn't the colon optional, indicating that the ref should be fetched int=
o
=46ETCH_HEAD? I.e.,

  $ git fetch origin pu
  From git://git2.kernel.org/pub/scm/git/git
   * branch            pu         -> FETCH_HEAD

?

-Peff
