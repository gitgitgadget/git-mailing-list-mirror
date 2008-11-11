From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [take 2] git send-email updates
Date: Tue, 11 Nov 2008 12:30:51 -0800
Message-ID: <7v4p2e0zus.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 21:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzzuX-0001zQ-Td
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYKKUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYKKUbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:31:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYKKUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 15:31:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B69B1978E9;
	Tue, 11 Nov 2008 15:31:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 58071978E8; Tue,
 11 Nov 2008 15:30:53 -0500 (EST)
In-Reply-To: <1226361242-2516-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Tue, 11 Nov 2008 00:53:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7DB9CDA-B02F-11DD-AB38-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100671>

Pierre Habouzit <madcoder@debian.org> writes:

> The last patch is dropped for now (the automatic --compose stuff)
> because I'm not sure which option to add, and that I don't care enough
> about it to spend more time on it.
>
> I think I've incorporated most of the stuff people asked about in this
> series.
>
>  [PATCH 1/4] git send-email: make the message file name more specific.
>  [PATCH 2/4] git send-email: interpret unknown files as revision lists
>  [PATCH 3/4] git send-email: add --annotate option
>  [PATCH 4/4] git send-email: ask less questions when --compose is used.

Thanks.

It is somewhat unfortunate that an explicit --no-format-patch works
exactly the same way as not giving the option at all.  I would have
expected that it would guess and warn if you did not give either, and it
would not even guess (i.e. file is mbox, dir is maildir) and error out if
there is a leftover option in @rev_list_opts if the user explicitly asked
the command not act as a frontend to format patch.

I will queue the series in 'pu' because I suspect you would like a chance
to amend out a "print foo" from the second commit ;-)
