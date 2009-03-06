From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 07:09:16 -0500
Message-ID: <20090306120916.GA3437@sigill.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org> <20090305104304.GA17760@coredump.intra.peff.net> <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com> <20090305211120.GB20157@coredump.intra.peff.net> <7vy6vjy5js.fsf@gitster.siamese.dyndns.org> <20090306052318.GB3426@sigill.intra.peff.net> <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYt6-0000D7-AX
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 13:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCFMJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 07:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZCFMJU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 07:09:20 -0500
Received: from peff.net ([208.65.91.99]:46484 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbZCFMJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 07:09:19 -0500
Received: (qmail 7865 invoked by uid 107); 6 Mar 2009 12:09:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Mar 2009 07:09:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 07:09:16 -0500
Content-Disposition: inline
In-Reply-To: <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112430>

On Thu, Mar 05, 2009 at 10:50:42PM -0800, Junio C Hamano wrote:

> > Because from the user's perspective --foo={bar,baz,bleep} is about
> > selecting exactly one of {bar,baz,bleep}.
> 
> I do not feel very strongly about this either way, and without any prior
> end user "Huh?" input, I would probably have argued like you myself, but
> I saw the original message from Miles about giving more than one --date
> and getting perplexed to see that it did not work, so...

Interesting. I saw the original message from Miles as "I tried to use
more than one --date, but that seems wrong to me because these concepts
are orthogonal".  But I do recognize that it is somewhat a matter of
perception and style.

Anyway, as our one user in this thread, he has said the separate option
is more clear. So I think we should go with that.

-Peff
