From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add support for external programs for handling
 native fetches
Date: Sat, 25 Jul 2009 23:02:23 -0700
Message-ID: <7vmy6srngw.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
 <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 08:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUwol-0001P9-6B
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 08:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZGZGCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZGZGCa
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 02:02:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZGZGCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 02:02:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 04DFD14BC3;
	Sun, 26 Jul 2009 02:02:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA1A314BBF; Sun,
 26 Jul 2009 02:02:24 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
 (Linus Torvalds's message of "Sat\, 25 Jul 2009 11\:25\:33 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E703A6F2-79A9-11DE-B185-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124103>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... Not an insignificant speedup on my machine (with an 
> obligatory "nyaah, nyaah, I can do the git test-suite under a minute" just 
> to rub peoples noses in the fact that my desktop computer is disgustingly 
> fast).

With git-svn tests?
