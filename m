From: Michael Heerdegen <michael_heerdegen@web.de>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Thu, 19 May 2016 01:05:28 +0200
Message-ID: <87r3cz55mv.fsf@web.de>
References: <87vb2d37ea.fsf@web.de> <8760ucoaus.fsf@web.de>
	<20160518004008.GA20007@sigill.intra.peff.net>
	<20160518005824.GA7120@sigill.intra.peff.net>
	<xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
	<20160518174919.GA5796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 01:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3AXC-0006ZY-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 01:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcERXFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 19:05:41 -0400
Received: from plane.gmane.org ([80.91.229.3]:54642 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbcERXFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 19:05:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b3AX3-0006Ue-KS
	for git@vger.kernel.org; Thu, 19 May 2016 01:05:37 +0200
Received: from dslb-094-217-122-112.094.217.pools.vodafone-ip.de ([94.217.122.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 May 2016 01:05:37 +0200
Received: from michael_heerdegen by dslb-094-217-122-112.094.217.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 May 2016 01:05:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-094-217-122-112.094.217.pools.vodafone-ip.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
Cancel-Lock: sha1:4TvzAKCbSxBbufnnR7d4KG95VpA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295028>

Jeff King <peff@peff.net> writes:

>   3. The epoch times for the latter lines should match.

FWIW, I think the epoch time is the most practical way to transfer the
time of a commit into a different program.  When this program wants to
do it's own date arithmetic with it, unix time is just nice (no time
format parsing needed).

That's why it would be good if the unix time values could be relied on.

Conclusion: in addition to 3., I wished both epoch times were also
correct per se.


Regards,

Michael.
