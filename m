From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 20:13:13 -0700
Message-ID: <7vtz5hugc6.fsf@gitster.siamese.dyndns.org>
References: <49CA78BF.2020101@fastmail.fm>
 <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
 <20090326022757.GC5835@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmg3c-0001IE-9l
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCZDNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZCZDNX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:13:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbZCZDNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:13:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13AA8A52EE;
	Wed, 25 Mar 2009 23:13:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C91C3A52ED; Wed,
 25 Mar 2009 23:13:15 -0400 (EDT)
In-Reply-To: <20090326022757.GC5835@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 25 Mar 2009 22:27:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0EC7F8E2-19B4-11DE-BEB2-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114710>

Jeff King <peff@peff.net> writes:

> Mirror mode would handle this automatically, but it unfortunately also
> ignores your push refspec. So any cruft or work-in-progress refs in your
> repository would be pushed.

Exactly.

Incidentally, that is why I usually favor the current 'matching' default.
If I decide to push something to the other repository, the other
repository remembers my wish, so I do not have to keep track (of course,
for that to work effectively, you have to _own_ the other side; it does
not work well for a shared public repository and that is why we had a
lengthy discussion on push.default).
