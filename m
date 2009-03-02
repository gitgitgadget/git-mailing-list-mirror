From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 RFC] fetch-pack: log(n)-transmission find_common()
Date: Sun, 01 Mar 2009 23:37:49 -0800
Message-ID: <7vsklw5q9e.fsf@gitster.siamese.dyndns.org>
References: <1235942640-2370-1-git-send-email-trast@student.ethz.ch>
 <200903012237.40891.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:39:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2kG-0006Jp-Hp
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbZCBHh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 02:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZCBHh4
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:37:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZCBHhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:37:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 47E502BEA;
	Mon,  2 Mar 2009 02:37:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E0A42BE8; Mon, 
 2 Mar 2009 02:37:50 -0500 (EST)
In-Reply-To: <200903012237.40891.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun, 1 Mar 2009 22:37:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AA62C4E-06FD-11DE-BF2D-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111908>

Thomas Rast <trast@student.ethz.ch> writes:

> But it also turns out, as you can see, that git-send-email happily
> ignores --in-reply-to if threading is disabled. :-(

Yeah, I think I noticed it recently, too.  Thanks for a quick fix.
