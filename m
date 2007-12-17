From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 07:12:10 -0500
Message-ID: <20071217121209.GA15368@coredump.intra.peff.net>
References: <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net> <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site> <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com> <Pine.LNX.4.64.0712171151490.9446@racer.site> <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Epo-0000C4-AK
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbXLQMMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXLQMMO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:12:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1740 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933188AbXLQMMN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:12:13 -0500
Received: (qmail 8160 invoked by uid 111); 17 Dec 2007 12:12:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 07:12:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 07:12:10 -0500
Content-Disposition: inline
In-Reply-To: <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68552>

On Mon, Dec 17, 2007 at 01:08:45PM +0100, Wincent Colaiuta wrote:

>> So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but not
>> "git diff".
>
> Well cmp would be fine as well, seeing all we want is a boolean "is this the 
> same or not" answer. (I'm not familiar with the GNU diff bug you speak of, 
> but was it so bad that it couldn't even get *that* answer right?)

Personally I find it useful to generate the diff output when viewing
with "-v". But if there is a real reason to use cmp over diff in the
script, one can always manually go into the trash directory and run
diff.

-Peff
