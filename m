From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Allow certain refs to be ignored
Date: Mon, 10 Oct 2011 15:58:38 -0700
Message-ID: <20111010225838.GB3828@dcvr.yhbt.net>
References: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com>
 <7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 00:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDOo0-0003b6-8h
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab1JJW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 18:58:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47349 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab1JJW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 18:58:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE242968AB;
	Mon, 10 Oct 2011 22:58:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183264>

Junio C Hamano <gitster@pobox.com> wrote:
> Asking Eric to comment when he has time to do so.
> 
> I find these pattern matches that are not anchored on either side 
> somewhat disturbing (e.g. --ignore-refs=master would ignore master2)
> but ignore-paths codepath seems to follow the same pattern, so perhaps it
> is in line with what git-svn users want. I dunno.

As stated last year, I remember wanting globs instead of regexps, but
we already made the regexp mistake with ignore-paths, too :(

I don't think it's horrible with regexps, and if git-svn users find it
useful, it's fine by me.

> Michael Olson <mwolson@gnu.org> writes:
> > Re-sent by request of Piotr Krukowiecki.  This is against v1.7.4.1,
> > and I've been using it stably for a while.

Michael: can you please rebase against latest and resend?  Thanks.
