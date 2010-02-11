From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 16:04:45 -0500
Message-ID: <20100211210445.GA8819@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
 <7vpr4c200i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgDT-0003r2-NS
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab0BKVEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:04:46 -0500
Received: from peff.net ([208.65.91.99]:51808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799Ab0BKVEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:04:45 -0500
Received: (qmail 21974 invoked by uid 107); 11 Feb 2010 21:04:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:04:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:04:45 -0500
Content-Disposition: inline
In-Reply-To: <7vpr4c200i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139624>

On Wed, Feb 10, 2010 at 02:34:21PM -0800, Junio C Hamano wrote:

> Changing the insn to suggest using "-C topic" when the original command
> line was "git cherry-pick topic" would be a good addition, too.  Currently
> we suggest "-c" and abbreviated object name, neither of which is sensible.

I think using the actual name instead of the abbreviated sha1 is
sensible. But I think "-c" makes sense, as it gives the user the chance
to look over the commit message to see if they need to tweak it to match
the conflict fixups. Savvy users who don't want to do that will know to
use "-C".

Series to follow:

  [1/4]: cherry-pick: rewrap advice message
  [2/4]: cherry-pick: refactor commit parsing code
  [3/4]: cherry-pick: format help message as strbuf
  [4/4]: cherry-pick: show commit name instead of sha1

-Peff
