From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] New whitespace checking category 'trailing-blank-line'
Date: Sun, 26 Jul 2009 16:57:10 -0700
Message-ID: <7v7hxvov55.fsf@alter.siamese.dyndns.org>
References: <200907261145.38449.bruno@clisp.org>
 <7vbpn7p1mw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 01:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVDat-0004g3-7K
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 01:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbZGZX5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 19:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZGZX5R
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 19:57:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZGZX5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 19:57:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B957A156DC;
	Sun, 26 Jul 2009 19:57:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26D8F156DB; Sun,
 26 Jul 2009 19:57:12 -0400 (EDT)
In-Reply-To: <7vbpn7p1mw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 26 Jul 2009 14\:36\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B856B32-7A40-11DE-A7E2-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124141>

Junio C Hamano <gitster@pobox.com> writes:

> I think the way we handled cr-at-eol was suboptimal. We should be able to
> link this to crlf attribute (and core.autocrlf configuration) and pretend
> as if cr-at-eol was given if a file is subject to the crlf conversion
> (iow,. cr-at-eol should be deprecated/removed as a mistake).

I was a moron.  I think cr-at-eol was really the best we could do, as it
is to allow CR at the end of the line _in the tracked contents_; iow,
people who would want to use this would not be using crlf attribute at all.

So please strike this part out, but everything else stays the same.
