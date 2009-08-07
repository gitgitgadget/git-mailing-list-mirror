From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (v2)] reset: make the output more user-friendly.
Date: Fri, 07 Aug 2009 14:20:13 -0700
Message-ID: <7viqgztj76.fsf@alter.siamese.dyndns.org>
References: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
 <1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249676676-5051-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZWrV-0007Hx-Os
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 23:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbZHGVUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441AbZHGVUV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 17:20:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbZHGVUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 17:20:21 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 292551FF0;
	Fri,  7 Aug 2009 17:20:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 943521FEE; Fri,  7 Aug
 2009 17:20:14 -0400 (EDT)
In-Reply-To: <1249676676-5051-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\,  7 Aug 2009 22\:24\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A8F0CEE-8398-11DE-8E61-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125227>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>  cat > expect << EOF
> -file2: locally modified
> +Unstaged changes after reset:
> +M	file2

It simply feels backwards when plumbing output says something in human
language (e.g. "needs update") while Porcelain output spits out a cryptic
M or U.  If the goal is human-readability and user-friendliness, shouldn't
we rather say:

	Path with local modifications:
        	file2

or something?
