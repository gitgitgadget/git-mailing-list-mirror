From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 17:21:37 -0500
Message-ID: <20100120222137.GC15936@coredump.intra.peff.net>
References: <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
 <20100120205452.GA8843@coredump.intra.peff.net>
 <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
 <20100120213137.GA9107@coredump.intra.peff.net>
 <20100120214152.GC9107@coredump.intra.peff.net>
 <7vy6jszaz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXivq-0004Lw-Rw
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0ATWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465Ab0ATWVm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:21:42 -0500
Received: from peff.net ([208.65.91.99]:58783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab0ATWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:21:41 -0500
Received: (qmail 10417 invoked by uid 107); 20 Jan 2010 22:26:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 17:26:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 17:21:37 -0500
Content-Disposition: inline
In-Reply-To: <7vy6jszaz0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137592>

On Wed, Jan 20, 2010 at 02:07:47PM -0800, Junio C Hamano wrote:

> > -	if (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW)
> > +	if (context->show_notes ||
> > +	    (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW))
> >  		get_commit_notes(commit, sb, encoding,
> >  				 NOTES_SHOW_HEADER | NOTES_INDENT);
> 
> Heh, without this hunk I would have thought Peff and Gitster were the same
> person ;-).
> 
> Once you introduce --no-notes, the above condition would not work well.

Yeah, I know, or I would have just added the 2 lines for
--no-show-notes. :) I think your patch is better; I'll comment on it
separately.

-Peff
