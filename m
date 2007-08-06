From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some ideas for StGIT
Date: Mon, 06 Aug 2007 08:42:05 -0400
Message-ID: <1186404125.10627.30.camel@dv>
References: <1186163410.26110.55.camel@dv>
	 <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
	 <20070806095623.GA23349@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 14:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II1uY-0006UE-I2
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 14:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763911AbXHFMmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 08:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763897AbXHFMmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 08:42:09 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:52136 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763776AbXHFMmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 08:42:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1II1x8-0006hB-8D
	for git@vger.kernel.org; Mon, 06 Aug 2007 08:44:54 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1II1uP-0002sS-6H; Mon, 06 Aug 2007 08:42:05 -0400
In-Reply-To: <20070806095623.GA23349@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55143>

On Mon, 2007-08-06 at 11:56 +0200, Karl Hasselstr=F6m wrote:

> I never really understood why commit message editing had to be part o=
f
> the "refresh" command. If it were a separate command and not tied to
> refresh, we could allow editing the message (and author, committer,
> date, ...) of any commit in the stack -- since the tree objects would
> be unchanged, we could just reuse the same tree objects when rewritin=
g
> the commit objects on top of it.
>=20
> That's obviously not going to work if we allow editing of the patch.
> But patch editing isn't a good fit as a refresh switch either, since
> it's not at all related to replacing the tree of the current patch
> with the working tree.

Purely from the code standpoint, yes, it should be a separate command.
But it may be practical to have both in one command, since I commonly
need to change the description after changing the code.

We need to think what would be convenient for the normal workflow.

--=20
Regards,
Pavel Roskin
