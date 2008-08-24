From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Sun, 24 Aug 2008 11:59:30 -0700
Message-ID: <7vsksume7h.fsf@gitster.siamese.dyndns.org>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
 <7vvdxs2t03.fsf@gitster.siamese.dyndns.org> <87k5e8i18c.fsf@cup.kalibalik.dk>
 <Pine.GSO.4.62.0808240019050.28567@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKpO-0003hA-OF
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYHXS7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYHXS7i
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:59:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYHXS7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:59:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C23B1665C9;
	Sun, 24 Aug 2008 14:59:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E46F0665C6; Sun, 24 Aug 2008 14:59:32 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0808240019050.28567@harper.uchicago.edu>
 (Jonathan Nieder's message of "Sun, 24 Aug 2008 00:28:32 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBF32D86-720E-11DD-8F6E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93549>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> Anders Melchiorsen wrote:
> ...
>> My concern is that without reading the source, it can be confusing to
>> figure out what happens with less, $LESS and git.
>
> So perhaps it is a documentation problem.  How about this patch?

I think this makes sense.  Anders?
