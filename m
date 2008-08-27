From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 09:42:31 +0200
Message-ID: <20080827094231.51d00b31@hyperion.delvare>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	<1219664940.9583.42.camel@pmac.infradead.org>
	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	<20080826145719.GB5046@coredump.intra.peff.net>
	<1219764860.4471.13.camel@gaara.bos.redhat.com>
	<1219766398.7107.87.camel@pmac.infradead.org>
	<20080826182349.0a1a75e2@hyperion.delvare>
	<48B46443.6000800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: erg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFhw-0003Et-O6
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 09:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYH0HnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 03:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYH0HnX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 03:43:23 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:24939 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbYH0HnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 03:43:23 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1KYGev-0001Yj-Gs
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 27 Aug 2008 10:45:45 +0200
In-Reply-To: <48B46443.6000800@kernel.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93866>

Hi Peter,

On Tue, 26 Aug 2008 13:14:59 -0700, H. Peter Anvin wrote:
> Jean Delvare wrote:
> > 
> > Reducing /usr/bin in size was totally worthwhile. Maybe not to you, but
> > to the silent majority I am a proud member of, it was. (I'm not saying
> > that the path that was taken to get there was optimal, just that the
> > goal was sound.)
> 
> You keep trying to use the Nixon argument ("silent majority.")  You *do* 
> know that it was a rhetorical device used by Nixon's speechwriters to 
> push ahead with policies despite compact opposition, don't you?

No, I don't. What I know is that people who are happy about a decision
usually don't tell about it and just take it for good and granted and
move to something else. You almost always only hear people who are
unhappy about decisions. Which means that comparing the amount of
noise made by the two groups is not fair. For a fair comparison, you
need to ask before doing the change, or if you have already done it, you
have to revert it and see if it generates more complaints than the
original change did (and even that is not totally fair, as some people
will complain because of the double change rather than the decision
itself.)

Anyway, the "silent majority" is no longer silent. If it were, this
discussion thread wouldn't be 60 posts long.

> As far as I can tell, most of the arguments in favour came from fanbois 
> of $OTHER_SCM which went along the lines of "why does git need all this 
> stuff in /usr/bin, when $OTHER_SCM doesn't?"  It had nothing to do with 
> reality, of course; it was just a difference between git and $OTHER_SCM 
> which they choose to pick on.

I see no point in limiting ourselves to SCMs. There are many other
categories of software which have internal commands. I'm using many of
these every day: trac, quilt, lftp. The fact is that none of these have
a hundred extra entries in /usr/bin as git does. trac has one, quilt
has two, lftp has three. So, git does (or used to do) things in a way
that differs from most other tools do.

OTOH, speaking of SCMs, I clearly remember of an old SCM (was it RCS?)
which exposed internal commands "ci" and "co" in the PATH and that
caused great frustration to me several times (notice how near the C and
V are on the keyboard.) I was very happy to see that this namespace
pollution was gone with CVS. Not so happy to see that it was partly back
with SVN (9 binaries in /usr/bin). And frankly unhappy to see that it
was one order of magnitude worse with git.

OK, I'm done with this discussion now. I'm sure everyone involved has
better things to spend their time on.

-- 
Jean Delvare
