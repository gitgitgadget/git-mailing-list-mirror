From: Junio C Hamano <gitster@pobox.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 05 Aug 2009 13:44:36 -0700
Message-ID: <7vzlaeyoqz.fsf@alter.siamese.dyndns.org>
References: <7vljlzjorh.fsf@alter.siamese.dyndns.org>
 <20090805181755.22765.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnLs-00039u-2Z
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZHEUol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbZHEUol
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:44:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbZHEUok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:44:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5023222717;
	Wed,  5 Aug 2009 16:44:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 934E222716; Wed, 
 5 Aug 2009 16:44:37 -0400 (EDT)
In-Reply-To: <20090805181755.22765.qmail@science.horizon.com> (George
 Spelvin's message of "5 Aug 2009 14\:17\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCAA9356-8200-11DE-B50F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124974>

"George Spelvin" <linux@horizon.com> writes:

>> We can continue shipping mozilla one to help the last group.
>
> Of course, we always need a C fallback.  Would you like a faster one?

No.  I'd rather keep tested and tried while a better alternative is in
work-in-progress state.
