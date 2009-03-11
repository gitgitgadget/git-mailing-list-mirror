From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 12:40:30 -0400
Message-ID: <20090311164030.GA5977@sigill.intra.peff.net>
References: <buoy6vi297q.fsf@dhlpc061.dev.necel.com> <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com> <20090310230939.GB14083@sigio.peff.net> <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com> <20090311020409.GA31365@coredump.intra.peff.net> <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org> <20090311190207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRVI-00055k-51
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZCKQkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZCKQkd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:40:33 -0400
Received: from peff.net ([208.65.91.99]:33797 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbZCKQkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 12:40:33 -0400
Received: (qmail 25008 invoked by uid 107); 11 Mar 2009 16:40:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Mar 2009 12:40:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Mar 2009 12:40:30 -0400
Content-Disposition: inline
In-Reply-To: <20090311190207.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112955>

On Wed, Mar 11, 2009 at 07:02:07PM +0900, Nanako Shiraishi wrote:

> I'm sorry, but I don't understand why you want to keep the entries in
> the reflog that were made before you pushed your branch to make it
> public in this scenario.
> 
> Especially because you are relinquishing the authority to the public
> repository by wishing to be able to "track" it, you can't rewind the
> branch beyond the point you initially pushed out any more. At that
> point, wouldn't it make more sense to drop the old reflog data and
> pretend as if the branch were fetched from the branch from your public
> repository it now follows, just like everybody else does?

That only means that you cannot rewind back to some spot in the reflog.
There is nothing to say that you cannot pull useful ideas from the
reflog that you thought were failed experiments, and apply them as
new commits.

-Peff
