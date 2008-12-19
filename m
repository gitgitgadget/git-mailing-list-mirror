From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Fri, 19 Dec 2008 15:05:59 -0800
Message-ID: <7vljub7oko.fsf@gitster.siamese.dyndns.org>
References: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
 <20081219124452.6117@nanako3.lavabit.com>
 <20081220064532.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDoRQ-0007BI-35
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYLSXGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYLSXGN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:06:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbYLSXGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:06:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BA7551AABE;
	Fri, 19 Dec 2008 18:06:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ABEA51AA8C; Fri,
 19 Dec 2008 18:06:01 -0500 (EST)
In-Reply-To: <20081220064532.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat, 20 Dec 2008 06:45:32 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F93D1D6-CE21-11DD-8D7A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103595>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I think your explanation will help people if we make it part of the
> documentation.  Especially because two different cases need two
> different recovery methods, and people need to learn which is which.

Sure.  It needs copyediting to make it readable standalone by not
mentioning "your misunderstanding", inlining "earlier Linus's suggestion",
etc., though.

Patches welcome ;-)
