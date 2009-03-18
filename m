From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH1/2] Libify blame
Date: Tue, 17 Mar 2009 23:20:29 -0700
Message-ID: <7v3adbmjwy.fsf@gitster.siamese.dyndns.org>
References: <49BE5343.60900@gmail.com>
 <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
 <1b29507a0903172259t348cb4d5n70f5b3003b1eeb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: pi.songs@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 18 07:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjpBt-0000Ht-BO
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 07:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbZCRGUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 02:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZCRGUi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 02:20:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZCRGUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 02:20:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C0425721A;
	Wed, 18 Mar 2009 02:20:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26BEE7219; Wed,
 18 Mar 2009 02:20:31 -0400 (EDT)
In-Reply-To: <1b29507a0903172259t348cb4d5n70f5b3003b1eeb00@mail.gmail.com>
 (pi song's message of "Wed, 18 Mar 2009 16:59:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3E591FA-1384-11DE-812F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113585>

pi song <pi.songs@gmail.com> writes:

> Don't you think we should rather split up into smaller files before
> start reorganizing things?

Yes, but splitting it wrong is, eh, wrong ;-)
