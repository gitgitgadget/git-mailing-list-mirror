From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 02:32:54 -0400
Message-ID: <20090311063254.GA1324@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de> <buoy6vi297q.fsf@dhlpc061.dev.necel.com> <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com> <20090310230939.GB14083@sigio.peff.net> <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com> <20090311020409.GA31365@coredump.intra.peff.net> <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 07:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhI7a-0000WV-BS
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 07:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbZCKGc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 02:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbZCKGc6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 02:32:58 -0400
Received: from peff.net ([208.65.91.99]:50355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbZCKGc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 02:32:57 -0400
Received: (qmail 17525 invoked by uid 107); 11 Mar 2009 06:33:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Mar 2009 02:33:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Mar 2009 02:32:54 -0400
Content-Disposition: inline
In-Reply-To: <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112888>

On Tue, Mar 10, 2009 at 09:37:21PM -0700, Junio C Hamano wrote:

> In any case, I find these "branch --retrack" proposals too confusing and
> probably overengineered.

I agree. I was hoping to find something that _wasn't_ confusing, but I
don't think we've succeeded.

> I need to ask a more fundamental question.  Is it really useful for people
> to be able to re-track arbitrary remote/branch with an existing branch?

I do it occasionally, but I have never had a problem with editing
.git/config.

My use case is usually something like:

  1. make an experimental commit on some long-running branch like 'next'
     or 'master'

  2. realize it's going to take several commits and would work better as
     a topic branch

  3. git checkout -b topic

in which case I have no tracking setup. But if I had realized it was
going to be a topic in the first place and done "git checkout -b topic
origin/master" then I would.

But again, I don't have a problem with editing .git/config. I was trying
in this thread to respond to user request.

-Peff
