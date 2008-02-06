From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 6 Feb 2008 09:16:41 +0100
Message-ID: <20080206081641.GA19876@diana.vm.bytemark.co.uk>
References: <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org> <7vprvb6k9u.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051648410.2967@woody.linux-foundation.org> <7vwspi4poh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfWc-00083a-FG
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759227AbYBFIUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 03:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbYBFIUY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:20:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3621 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYBFIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 03:20:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JMfST-0005d0-00; Wed, 06 Feb 2008 08:16:41 +0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwspi4poh.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72769>

On 2008-02-05 21:30:38 -0800, Junio C Hamano wrote:

> I really wish this was still May 2005. Then I (actually, you) could
> just decree:
>
>       Sorry guys, but you all need to run convert-objects to update
>       your repo. What it does is to add a "generation" header to
>       each and every commit object. Then upgrade your git to this
>       version, that maintains the "generation" number, defined as:
>
>         (1) parentless commit gets generation #0;
>
>         (2) otherwise the generation number of a commit is max(its
>             parents' generation number)+1.

Would it be possible to start adding a generation header to new
commits, so that this problem (and others -- I recall hearing this
same wish a year or two ago regarding some gitk toposorting issue)
will eventually fade away?

=46or old commits without an embedded generation number, git could
conceivably compute their generation number once and store them in a
(local) file somewhere.

I expect that this has been considered already, and I'd be interested
in hearing why it doesn't work, if you (or someone else) have some
time to waste. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
