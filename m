From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
	branch
Date: Fri, 20 Mar 2009 15:36:50 -0400
Message-ID: <20090320193650.GA26934@coredump.intra.peff.net>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <7vwsakgjie.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkYC-0006MH-He
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760306AbZCTThG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760252AbZCTThE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:37:04 -0400
Received: from peff.net ([208.65.91.99]:42037 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760177AbZCTThD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:37:03 -0400
Received: (qmail 10573 invoked by uid 107); 20 Mar 2009 19:37:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 15:37:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 15:36:50 -0400
Content-Disposition: inline
In-Reply-To: <7vwsakgjie.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113994>

On Fri, Mar 20, 2009 at 11:02:33AM -0700, Junio C Hamano wrote:

> A na=C3=AFve question.
>=20
> Has nobody suggested to use a really illegal characters such as ':'
> instead?  After all, we are not talking something that you can use in
> refspecs but another way to spell branch names.

But if this goes into dwim_ref, then won't it be usable for refspecs? O=
r
even if it isn't, then imagine the user who doesn't know this and types

  git push :foo

unwittingly deleting the remote "foo".

Yes, that is unlikely (since why would they push the tracking branch of
foo?), but I don't think it makes sense to argue that it doesn't have
confusing (and potentially dangerous) consequenses.

> Alternatively, '~master' may have a nice connotation that means "wher=
e
> master calls its home".

I think that is quite clever and doesn't have any meaning for a revisio=
n
specifier already. I like it.

-Peff
