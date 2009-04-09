From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 09 Apr 2009 01:49:17 -0700
Message-ID: <7v3aci43g2.fsf@gitster.siamese.dyndns.org>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
 <20090409081443.GB17221@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:51:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpzA-0004Dd-3U
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760756AbZDIItj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZDIIti
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:49:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbZDIItg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:49:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E85CFA9A27;
	Thu,  9 Apr 2009 04:49:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 70D65A9A26; Thu,
  9 Apr 2009 04:49:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59B3C1F8-24E3-11DE-A2D4-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116155>

Jeff King <peff@peff.net> writes:

> I disagree that it's unintrusive (and I understand that you don't think
> it is, and that there may be others like you, but I am pointing out
> there are others who think the opposite). But given that it's optional,
> and it's not very much code, I don't have a strong objection. My
> original comment was that I was dubious whether it would work: however,
> I was thinking you would set it to a few seconds. Setting it to 60
> seconds, I can imagine it would have an impact.

Heh, then why not make the option specify the number of _minutes_ not
seconds to delay?  That would help clarifying what this option is meant to
do.

The description for this new feature in the manual page should make it
absolutely clear that the maintainer who accepts such a feature is not
clueless to think that such a delay will guarantee something.  It is
merely for people who believe it would help guaranteeing the delivery
order _in practice_ and are willing to background the slow sending.
