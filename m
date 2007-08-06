From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 15:52:04 +0200
Message-ID: <20070806135204.GC23349@diana.vm.bytemark.co.uk>
References: <1186163410.26110.55.camel@dv> <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com> <20070806095623.GA23349@diana.vm.bytemark.co.uk> <1186404125.10627.30.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 15:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II30i-0002D9-Ph
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 15:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbXHFNwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 09:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXHFNwh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 09:52:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3207 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbXHFNwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 09:52:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1II308-0007M2-00; Mon, 06 Aug 2007 14:52:04 +0100
Content-Disposition: inline
In-Reply-To: <1186404125.10627.30.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55148>

On 2007-08-06 08:42:05 -0400, Pavel Roskin wrote:

> On Mon, 2007-08-06 at 11:56 +0200, Karl Hasselstr=F6m wrote:
>
> > I never really understood why commit message editing had to be
> > part of the "refresh" command. If it were a separate command and
> > not tied to refresh, we could allow editing the message (and
> > author, committer, date, ...) of any commit in the stack -- since
> > the tree objects would be unchanged, we could just reuse the same
> > tree objects when rewriting the commit objects on top of it.
>
> Purely from the code standpoint, yes, it should be a separate
> command. But it may be practical to have both in one command, since
> I commonly need to change the description after changing the code.

Sure. I don't have any objection to making

  stg refresh -e

be equivalent to

  stg refresh && stg edit-patch-message <topmost-patch>

What I'm objecting to is being forced to refresh when I just want to
edit the message. (And, to a lesser degree, having to manually push
and pop to make the patch topmost before I can edit its message.)

Obviously not annoyed enough to have written a patch for it yet,
though. :-)

> We need to think what would be convenient for the normal workflow.

Of course.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
