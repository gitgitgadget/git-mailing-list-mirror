From: Junio C Hamano <gitster@pobox.com>
Subject: Re: janitoring
Date: Wed, 22 Jul 2009 15:00:21 -0700
Message-ID: <7vws60cr9m.fsf@alter.siamese.dyndns.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjrT-0003D3-AO
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbZGVWA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbZGVWA1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:00:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbZGVWAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:00:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 89E3A10091;
	Wed, 22 Jul 2009 18:00:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 07CAC10090; Wed,
 22 Jul 2009 18:00:22 -0400 (EDT)
In-Reply-To: <1248298475-2990-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Wed\, 22 Jul 2009 23\:34\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F7797A2-770B-11DE-9E57-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123794>

Pierre Habouzit <madcoder@debian.org> writes:

> [PATCH 1/3] janitor: use NULL and not 0 for pointers.
>
>   I really dislike the use of 0 when NULL is meant. This patch probably
>   fixes most of them. The biggest culprit is nedmalloc, but a few
>   remnants exist in plain git code.

I am not enthused about "fixing" borrowed foreign code, unless we know
that we are committed to support our fork.  My impression was that this
ned stuff was borrowed by the MinGW folks with the understanding that we
will slurp it with minimum modification and turn a blind eye to its
sub-par coding styles, so that it can be more easily updated from the
upstream?
