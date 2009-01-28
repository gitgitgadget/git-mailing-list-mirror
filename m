From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: output correct index lines for a split diff
Date: Wed, 28 Jan 2009 13:32:04 -0800
Message-ID: <7vr62nktgr.fsf@gitster.siamese.dyndns.org>
References: <lyhc3q9pl1.fsf@leia.mandriva.com>
 <20090126003556.GA19368@coredump.intra.peff.net>
 <7vy6wy8qmm.fsf@gitster.siamese.dyndns.org>
 <7vhc3m8o0b.fsf_-_@gitster.siamese.dyndns.org>
 <20090126090712.GA12648@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pixel <pixel@mandriva.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSI2q-0003za-FH
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbZA1VcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZA1VcN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:32:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZA1VcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:32:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 421D11D80E;
	Wed, 28 Jan 2009 16:32:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 722891D805; Wed,
 28 Jan 2009 16:32:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F4C5756-ED83-11DD-8580-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107581>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 26, 2009 at 12:33:56AM -0800, Junio C Hamano wrote:
>
>> This moves the code to generate metainfo lines around, so that two
>> independent sets of metainfo lines are used for the split halves.
>
> The patch and the generated output look correct to me, so
>
> Acked-by: Jeff King <peff@peff.net>
>
>> I did not include your new test script here; perhaps we can add it to an
>> existing typechange diff/apply test, like t4114?
>
> I think it makes sense to add to t4114. Please squash in the test below.

Thanks.
