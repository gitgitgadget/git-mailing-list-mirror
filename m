From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --numstat disagrees with git apply --numstat
Date: Mon, 15 Dec 2008 01:57:07 -0800
Message-ID: <7vhc55yd58.fsf@gitster.siamese.dyndns.org>
References: <20081211235337.GK32487@spearce.org>
 <20081212015254.GA23128@sigill.intra.peff.net>
 <20081212020857.GB23128@sigill.intra.peff.net>
 <20081212022156.GC23128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 10:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCADh-000417-KI
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 10:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYLOJ5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 04:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYLOJ5P
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 04:57:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYLOJ5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 04:57:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 077551A4E3;
	Mon, 15 Dec 2008 04:57:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 974561A4E2; Mon,
 15 Dec 2008 04:57:09 -0500 (EST)
In-Reply-To: <20081212022156.GC23128@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 11 Dec 2008 21:21:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFA10F48-CA8E-11DD-852D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103145>

Jeff King <peff@peff.net> writes:

> BTW, I got a little confused looking at the parameters to xdi_diff_outf,
> since ecb gets passed in full of random garbage. I don't know if this
> cleanup is worth applying:

I think this makes sense, but let's do this after 1.6.1 final.  It does
not fix anything, and I'd rather avoid distraction.
