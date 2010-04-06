From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Mon, 05 Apr 2010 19:08:09 -0700
Message-ID: <7vmxxhl4dy.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
 <7vr5mtl55q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 04:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyyDH-0003UF-Rb
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 04:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab0DFCIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 22:08:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab0DFCIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 22:08:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 217E9A8E7B;
	Mon,  5 Apr 2010 22:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRXYfAFDUKDvw762xJX54642UUQ=; b=QMYfu7
	0oPMK6/iWyYRemopJ0CSDEterUdYYyzNlK3gxcnVpBIOWfBL7LvQSDJ9wPDO5zvo
	9THLWxI/n22FooiP+60jDEyv7BCzgDDLKcaT8fvt5E6ly87nLezWhMGggbKr8ZyK
	CGDVBP8fBmfwGlSFiq0ohQ65sGiVJZ86TRHc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TX7UMx+WP5JdUj68lvRpnIc3Vt2iSzoA
	TdTkGkxjAc7HPA6SlnKmhhGq/UG/DI7W8e4ZiRUy38gqILSixjZ6IpplHYDHZK4I
	0j7Q5nyLYwmr5K7QEd3vtmeu9KpuxKSvu/Hwgq25WC1Q6uQkkZSGxyU8z62hJxES
	Dejre5MLYqA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E2AA8E74;
	Mon,  5 Apr 2010 22:08:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42F06A8E73; Mon,  5 Apr
 2010 22:08:10 -0400 (EDT)
In-Reply-To: <7vr5mtl55q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 05 Apr 2010 18\:51\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42774C02-4121-11DF-8090-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144084>

Junio C Hamano <gitster@pobox.com> writes:

> A related but a larger issue is that I suspect this "two-dot" would not
> work, as the syntax looks for "Merge branch 'slabh'.." (two-dot taken
> literally).

Heh, what do I know.  This does seem to work.  Sorry for the noise.
