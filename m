From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Fri, 24 Jul 2009 08:55:23 -0700
Message-ID: <7vprbqnkic.fsf@alter.siamese.dyndns.org>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
 <bkmAA5IX0ZzfCv66mQCX1GFfM5XwTCDPMQk5LjxMd37QH7PwYK29XA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUN7U-0007IT-1K
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 17:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZGXPzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbZGXPzb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 11:55:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbZGXPzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 11:55:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2341810E3B;
	Fri, 24 Jul 2009 11:55:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D320810E39; Fri, 24 Jul 2009
 11:55:25 -0400 (EDT)
In-Reply-To: <bkmAA5IX0ZzfCv66mQCX1GFfM5XwTCDPMQk5LjxMd37QH7PwYK29XA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 24 Jul 2009 10\:43\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6997F0A0-786A-11DE-A32D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123923>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> So, I have been getting NO_EXTERNAL_GREP all along without knowing it.

Thanks for a detailed analysis.  I use gcc, and I suspect Peff also does.
So it seems that I should apply my "in case it is the latter" patch.

Thanks.
