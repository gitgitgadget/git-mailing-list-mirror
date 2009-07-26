From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add support for external programs for handling
 native fetches
Date: Sat, 25 Jul 2009 23:33:14 -0700
Message-ID: <7viqhgrm1h.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
 <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 08:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUxIe-0002NB-4M
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 08:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZGZGdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 02:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZGZGdV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 02:33:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZGZGdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 02:33:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96EC614C84;
	Sun, 26 Jul 2009 02:33:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0F2314C83; Sun,
 26 Jul 2009 02:33:15 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
 (Linus Torvalds's message of "Sat\, 25 Jul 2009 11\:25\:33 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 360E50AE-79AE-11DE-A62C-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124105>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So a very big Acked-by: from me for the series. I didn't test that http: 
> works with it, but I don't personally even care, so I'd ack it even 
> without that ;)

Heh, "git ls-remote http://..." segfaulting for me is not a very good
sign, but I like the concept.
