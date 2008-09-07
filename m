From: Jeff King <peff@peff.net>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Sun, 7 Sep 2008 13:34:34 -0400
Message-ID: <20080907173434.GA26182@coredump.intra.peff.net>
References: <48C1D2AE.3010001@feds.uwaterloo.ca> <20080906012941.GA2009@coredump.intra.peff.net> <48C3E35C.2050903@feds.uwaterloo.ca> <20080907155033.GA25031@coredump.intra.peff.net> <7vprnfn9pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Gerlach <egerlach@feds.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcOAp-0004rR-0r
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbYIGReh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYIGReh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:34:37 -0400
Received: from peff.net ([208.65.91.99]:4637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbYIGReg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:34:36 -0400
Received: (qmail 12602 invoked by uid 111); 7 Sep 2008 17:34:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Sep 2008 13:34:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Sep 2008 13:34:34 -0400
Content-Disposition: inline
In-Reply-To: <7vprnfn9pz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95156>

On Sun, Sep 07, 2008 at 10:31:52AM -0700, Junio C Hamano wrote:

> All depends on how "an empty repository" is defined.  My definition of an
> empty repository would have been:
> 
>  - No objects in it;
>  - No index;
>  - No refs except symrefs.

Agreed. In the original message, he used the phrase "no existing
commits" which I latched onto (to mean "no existing commits on this
branch"). But the subject does say "empty repository". :)

Eric, maybe you can tell us more about what you're trying to accomplish?

-Peff
