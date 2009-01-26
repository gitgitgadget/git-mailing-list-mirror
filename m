From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 19:42:06 -0800
Message-ID: <7v4ozmbunl.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
 <20090126031206.GB14277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRINw-0001Wp-7S
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbZAZDmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbZAZDmO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:42:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZAZDmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:42:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28C3A9317F;
	Sun, 25 Jan 2009 22:42:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED8E89317E; Sun,
 25 Jan 2009 22:42:08 -0500 (EST)
In-Reply-To: <20090126031206.GB14277@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 25 Jan 2009 22:12:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 516BA5FE-EB5B-11DD-BD46-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107167>

Jeff King <peff@peff.net> writes:

We seem to think the same way these days, so I do not have very much to
add on top of what you already said.  I'll fix one typo, though.

> But this can break down in two ways:
>
>   1. Sometimes we blur the line of plumbing and porcelain, where
>      functionality is available only through plumbing. For example,

s/through plumbing/through Porcelain/.
