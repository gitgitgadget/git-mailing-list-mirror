From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Cleanup warning about known issues in cvsimport
	documentation
Date: Tue, 31 Mar 2009 15:49:40 -0400
Message-ID: <20090331194940.GB23184@coredump.intra.peff.net>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net> <20090330223646.GC68118@macbook.lan> <7v4oxaa506.fsf@gitster.siamese.dyndns.org> <20090331164503.GB72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LojzZ-0002rm-Cv
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbZCaTty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbZCaTtx
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:49:53 -0400
Received: from peff.net ([208.65.91.99]:43176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbZCaTtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:49:53 -0400
Received: (qmail 12584 invoked by uid 107); 31 Mar 2009 19:50:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 15:50:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 15:49:40 -0400
Content-Disposition: inline
In-Reply-To: <20090331164503.GB72569@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115305>

On Tue, Mar 31, 2009 at 06:45:03PM +0200, Heiko Voigt wrote:

> Not all statements were complete sentences.

Thanks, this is looking much better. A few minor comments:

>   * If any files were ever "cvs import"ed more than once (e.g., import of
> -   more than one vendor release)
> +   more than one vendor release) the HEAD will be incorrect.

Incorrect how? I assume "contains the wrong content".

> + * This applies to files added to the source branch *after* a daughter
> +   branch was created: If previously no commit was made on the daugther
> +   branch they will erroneously be added to the daughter branch in git.

s/If/if/, s/daugther/daughter/

Other than that, looks good to me.

-Peff
