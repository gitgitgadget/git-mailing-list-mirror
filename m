From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init-db: support --import to add all files and commit
	right after init
Date: Tue, 31 Mar 2009 05:27:31 -0400
Message-ID: <20090331092731.GA1276@coredump.intra.peff.net>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com> <20090325041934.GA15524@coredump.intra.peff.net> <buomyb2cb3c.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaIK-0000nK-Ry
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbZCaJ16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZCaJ14
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:27:56 -0400
Received: from peff.net ([208.65.91.99]:51512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbZCaJ14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:27:56 -0400
Received: (qmail 8948 invoked by uid 107); 31 Mar 2009 09:27:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 05:27:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 05:27:31 -0400
Content-Disposition: inline
In-Reply-To: <buomyb2cb3c.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115236>

On Tue, Mar 31, 2009 at 06:09:43PM +0900, Miles Bader wrote:

> Jeff King <peff@peff.net> writes:
> > I seem to recall that we were phasing out "--long-option <arg>" at some
> > point, and that all long-options should use "--long-option=". But maybe
> > I am mis-remembering.
> 
> Surely it should support both where possible, since both are standard
> syntaxes for passing args to "--"-style long options (so users expect
> both to work).

Yes.  See later in the thread where I correctly remember the issue.

-Peff
