From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement a textconv filter for "git diff"
Date: Sun, 28 Sep 2008 12:12:50 -0400
Message-ID: <20080928161250.GB30199@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr> <20080928041526.GB24214@coredump.intra.peff.net> <vpq8wtc1tf7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 28 18:14:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjyuI-0000Kr-Vd
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 18:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbYI1QMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 12:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYI1QMx
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 12:12:53 -0400
Received: from peff.net ([208.65.91.99]:4262 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbYI1QMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 12:12:52 -0400
Received: (qmail 7154 invoked by uid 111); 28 Sep 2008 16:12:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 12:12:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 12:12:50 -0400
Content-Disposition: inline
In-Reply-To: <vpq8wtc1tf7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96978>

On Sun, Sep 28, 2008 at 12:00:44PM +0200, Matthieu Moy wrote:

> Hmm, why not, and the textconv could be different (like comparing
> old:foo.doc with ./foo.odt).

Exactly.

> One has to be carefull not to call textconv for plumbing commands,
> since the generated patches are not applicable, and only for the eyes
> of the reader.

Right, but that is prevented by not loading the appropriate diff driver
config, I believe (and I didn't look closely at your implementation in
that respect, but I believe it is the same as mine, because both
porcelain and plumbing use the code in diff.c).

-Peff
