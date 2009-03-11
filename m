From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 23:57:02 -0400
Message-ID: <20090311035701.GA6089@coredump.intra.peff.net>
References: <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com> <20090310230939.GB14083@sigio.peff.net> <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com> <20090311020409.GA31365@coredump.intra.peff.net> <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com> <20090311030604.GA3044@coredump.intra.peff.net> <76718490903102044j4ca3462eye5ffcb178608dc29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhFaY-0000iK-9G
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbZCKD5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 23:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZCKD5J
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 23:57:09 -0400
Received: from peff.net ([208.65.91.99]:54955 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbZCKD5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 23:57:09 -0400
Received: (qmail 16264 invoked by uid 107); 11 Mar 2009 03:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Mar 2009 23:57:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 23:57:02 -0400
Content-Disposition: inline
In-Reply-To: <76718490903102044j4ca3462eye5ffcb178608dc29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112876>

On Tue, Mar 10, 2009 at 11:44:14PM -0400, Jay Soffian wrote:

> > Hmm. I think of that as "make <newbranch>, move from <oldbranch> or
> > HEAD".
> 
> Um, I think of it as "rename <oldbranch> to <newbranch>" where
> <oldbranch> defaults to the current branch (aka HEAD).

Perhaps it is because it was added onto "git branch" which already had
an existing syntax and meaning, but I have always seen it as "operating"
on the new branch.

There was some debate about this when "-m" came about (with respect to
the order of arguments).

So I think it is largely a matter of perception and mental model.

> -u w/o --track/--no-track is a usage error.

Then what is the point of "-u"? You said before that it was a new
operation with room for future growth of additional options. Either it
is _just_ for --track, in which case I think you are better to have a
single option representing the notion of "update the tracking setup", or
it isn't, in which case it needs to have room for future expansion.

-Peff
