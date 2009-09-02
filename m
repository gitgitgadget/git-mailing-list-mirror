From: Jeff King <peff@peff.net>
Subject: Re: stash --dwim safety
Date: Wed, 2 Sep 2009 00:59:37 -0400
Message-ID: <20090902045937.GA12046@coredump.intra.peff.net>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
 <7v3a77dx5b.fsf@alter.siamese.dyndns.org>
 <vpqocpv2n93.fsf@bauges.imag.fr>
 <20090901065716.GA5575@sigill.intra.peff.net>
 <7vy6oyj892.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 06:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mihwi-0006xs-8q
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 06:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbZIBE7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbZIBE7i
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 00:59:38 -0400
Received: from peff.net ([208.65.91.99]:37406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbZIBE7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 00:59:38 -0400
Received: (qmail 4668 invoked by uid 107); 2 Sep 2009 04:59:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 00:59:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 00:59:37 -0400
Content-Disposition: inline
In-Reply-To: <7vy6oyj892.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127577>

[cc'ing Dscho, as he was the main opponent of similar proposals, and I
suspect his silence here means he missed this discussion. I hope this
addresses his concerns, but I think it is good to get comment from all
interested parties.

I'll just quote as appropriate below to comment, but for the whole patch
see:

  http://article.gmane.org/gmane.comp.version-control.git/127574

]

On Tue, Sep 01, 2009 at 09:11:37PM -0700, Junio C Hamano wrote:

> This makes the logic of defaulting to "save" much simpler. If there is no
> non-flag arguments, it is clear that there is no command word, and we

s/is/are/ (or s/arguments/argument/)

> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> [...]
> -	--hard` to revert them.  This is the default action when no
> -	subcommand is given. The <message> part is optional and gives
> -	the description along with the stashed state.
> +	--hard` to revert them.  The <message> part is optional and gives
> +	the description along with the stashed state.  For quickly making
> +	a snapshot, you can omit _both_ "save" and <message>, but giving
> +	only <message> does not trigger this action to prevent misspelled
> +	subcommand from making an unwanted stash.

s/misspelled/a &/

-Peff
