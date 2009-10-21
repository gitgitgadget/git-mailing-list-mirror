From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Document GNU_ROFF in Makefile
Date: Wed, 21 Oct 2009 18:51:33 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910211824220.5105@dr-wily.mit.edu>
References: <alpine.DEB.2.00.0910211357160.5105@dr-wily.mit.edu> <7a3e6c8c5a11e14c19bc1a27608dcc78171c9feb.1256151199.git.trast@student.ethz.ch> <20091021213149.GX6115@genesis.frugalware.org> <7vk4yoz8sf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	bill lam <cbill.lam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0k2E-0006mk-V4
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbZJUWvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 18:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbZJUWvt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:51:49 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63151 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755834AbZJUWvs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:51:48 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9LMpQk3005549;
	Wed, 21 Oct 2009 18:51:26 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9LMpZl2022096;
	Wed, 21 Oct 2009 18:51:35 -0400 (EDT)
In-Reply-To: <7vk4yoz8sf.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130983>

On Wed, 21 Oct 2009, Junio C Hamano wrote:
> > +# Define GNU_ROFF if you have GNU roff and you don't want to have =
pretty
> > +# apostrophe so that cut&pasting examples to the shell will work.
>=20
> This makes it sound as if groff is the only roff implementation that =
has=20
> this problem---iow, if we use non-GNU roff then the documentation com=
es=20
> out just fine.  Is that the case?

Yes:
                            built without GNU_ROFF   built with GNU_ROF=
=46
 viewed with non-GNU roff   correct (')              wrong (no output!)
 viewed with GNU groff      wrong (=C2=B4)                correct (')

In order to build a manpage that can be viewed correctly on both=20
platforms, the conditional logic should live in the manpage itself (as =
per=20
the bug comments I linked to and Thomas quoted from).

Anders
