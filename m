From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 03:00:21 -0400
Message-ID: <20090814070021.GB7113@coredump.intra.peff.net>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <7vab22ubr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:00:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbqm6-0001xQ-Lu
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbZHNHAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbZHNHAW
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:00:22 -0400
Received: from peff.net ([208.65.91.99]:57016 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467AbZHNHAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:00:21 -0400
Received: (qmail 15412 invoked by uid 107); 14 Aug 2009 07:00:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 Aug 2009 03:00:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Aug 2009 03:00:21 -0400
Content-Disposition: inline
In-Reply-To: <7vab22ubr5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125908>

On Thu, Aug 13, 2009 at 11:53:50PM -0700, Junio C Hamano wrote:

> I do not mean that this new feature is useless nor stupid.  Being able to
> say "git push --delete branch1 branch2" matches _a_ mental model (perhaps
> Hg inspired one) _very_ naturally.  There are branches on the other side,
> and there is a special operation called 'delete' that you can inflict on
> them.
> 
> But it is a different mental model of how git natively does "push".  In
> git model, you give list of instructions <which branch to update with what
> commit>, and as a special case "what commit" could be "empty" to signal
> deletion, and "push" carries out the instructions.
> 
> These are both valid models.  They just do not mix, so let's avoid
> confusion by not allowing both at the same time.

Thank you for succintly explaining what I was trying to put my finger on
elsewhere in the thread. To sum up what I was trying to say:

I don't have anything against the "delete mode" mental model, but I
don't have a particular use for it. My counter-proposal was "syntactic
sugar without changing the mental model". Between the two, I don't have
a strong feeling (and my "this is wrong" comments were about where you
had mixed the two, and I think you agreed with them).

-Peff
