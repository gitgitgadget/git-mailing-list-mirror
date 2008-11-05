From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] git send-email: turn --compose on when more than
	one patch.
Date: Tue, 4 Nov 2008 22:31:51 -0500
Message-ID: <20081105033151.GB24886@coredump.intra.peff.net>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225815858-30617-1-git-send-email-madcoder@debian.org> <1225815858-30617-2-git-send-email-madcoder@debian.org> <1225815858-30617-3-git-send-email-madcoder@debian.org> <1225815858-30617-4-git-send-email-madcoder@debian.org> <1225815858-30617-5-git-send-email-madcoder@debian.org> <1225815858-30617-6-git-send-email-madcoder@debian.org> <7vprlbnj1t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 04:33:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxZ8m-0007Fe-4E
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 04:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYKEDby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 22:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbYKEDby
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 22:31:54 -0500
Received: from peff.net ([208.65.91.99]:4496 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356AbYKEDbx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 22:31:53 -0500
Received: (qmail 11678 invoked by uid 111); 5 Nov 2008 03:31:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 22:31:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 22:31:51 -0500
Content-Disposition: inline
In-Reply-To: <7vprlbnj1t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100141>

On Tue, Nov 04, 2008 at 03:54:54PM -0800, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > Automatically turn --compose on when there is more than one patch, and
> > that the output is a tty.
> 
> I do not think this is a good idea.  I suspect I am not the only person
> who uses "format-patch --cover-letter", edit the files to review and
> prepare, and runs send-email to fire them off.

Maybe a config option to turn this behavior on? It seems specific to
different workflows (i.e., whether or not you are using "git send-email
$REVS" or using format-patch first).

-Peff
