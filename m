From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 3 Feb 2009 03:07:34 -0500
Message-ID: <20090203080734.GA27251@sigill.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com> <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de> <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com> <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de> <20090131095622.6117@nanako3.lavabit.com> <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org> <20090202124148.GB8325@sigio.peff.net> <7vskmwc5js.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:09:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUGLC-00070O-DT
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 09:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZBCIHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 03:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZBCIHk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 03:07:40 -0500
Received: from peff.net ([208.65.91.99]:57957 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbZBCIHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 03:07:39 -0500
Received: (qmail 17739 invoked by uid 107); 3 Feb 2009 08:07:50 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 03:07:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 03:07:34 -0500
Content-Disposition: inline
In-Reply-To: <7vskmwc5js.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108164>

On Tue, Feb 03, 2009 at 12:01:43AM -0800, Junio C Hamano wrote:

>  	"To allow pushing into the current branch, you can set it to 'ignore';",
> -	"but this is not recommended unless you really know what you are doing.",
> +	"but this is not recommended unless you arranged its work tree to get",
> +	"updated to match what you pushed in some other way.",

This is much better, but I believe it needs to be "...arranged _for_
its work tree to get updated..." to be grammatically correct.

And as a nit (which I seem to be full of tonight), you can get rid of
the passive voice by saying:

 but this is not recommended unless you arranged to update its work
 tree to match what you pushed in some other way.

which is slightly more clear, IMHO.

-Peff
