From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 07:10:58 -0500
Message-ID: <20090306121058.GB3437@sigill.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org> <20090305104304.GA17760@coredump.intra.peff.net> <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com> <20090305211120.GB20157@coredump.intra.peff.net> <7vy6vjy5js.fsf@gitster.siamese.dyndns.org> <20090306052318.GB3426@sigill.intra.peff.net> <7vmybzw3el.fsf@gitster.siamese.dyndns.org> <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYum-0000qi-Oc
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 13:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbZCFMLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 07:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZCFMLB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 07:11:01 -0500
Received: from peff.net ([208.65.91.99]:44624 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbZCFMLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 07:11:01 -0500
Received: (qmail 7888 invoked by uid 107); 6 Mar 2009 12:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Mar 2009 07:11:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 07:10:58 -0500
Content-Disposition: inline
In-Reply-To: <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112431>

On Fri, Mar 06, 2009 at 01:58:36AM -0500, Jay Soffian wrote:

> 1) The CLI. You and Jeff don't seem to have an agreement here, but
> frankly, this is the easy part.
> 
> 2) The internal implementation. Your implementation (enum -> bitfield)
> is clever, but Jeff seems to prefer what I suggested (going to a
> struct). The latter is quite a bit more work.

My argument for (2), btw, is that the code is easier to read and more
maintainable if it follows the structure of the CLI. But I don't think
it's as important as getting the CLI right.

-Peff
