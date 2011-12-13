From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 11:17:29 -0800
Message-ID: <7vhb14uvqu.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 13 20:17:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXr7-00019W-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 20:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab1LMTRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 14:17:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab1LMTRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 14:17:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E7556AA;
	Tue, 13 Dec 2011 14:17:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7xPmS18leAjAmqgsKfZCdUcN1Xs=; b=WUh8iO
	okWY8UADMjdzxF7yX0H7YdA9U3ehaPK5s+0pQoa4vRMzkcDiCradc8nBbOSQHvwJ
	BkPQ1fAGHaiKsA9RTx7YWqd8Fpg2/8CT0fceJxffv2I4N7fd9JRwPXxNxAf9aZzJ
	Qmjqtf4D3zORacFiFjhhuVDA2dv1t6nZbDcnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uKqu+9IF5mB0JJfhod7Rg6KMNQYDKFi2
	yeDil137sREEcbaY6EGwTVRxhzfgoFtU+ZQzH8TtVWIOwjFte3BkijHOiev+lbro
	58rdRxubeHJfoGDCuzPoETPAtDKAYqSM66IVpEn/LUOD7fTWni7unyFkh/A0JfFb
	ioWvHcen2P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A1AF56A9;
	Tue, 13 Dec 2011 14:17:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A9E756A8; Tue, 13 Dec 2011
 14:17:30 -0500 (EST)
In-Reply-To: <4EE7A387.3070400@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 13 Dec 2011 20:12:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A24DC22-25BF-11E1-BABD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187048>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...  But I leave for vacation on Thursday so it is quite likely that I
> won't be able to get it finished before I return in the new year.

That is perfectly fine. Have fun.

I wasn't expecting the entire series to be ready during this cycle
anyway, and was planning to queue the clean-up series, up to 16/51
or so, for the next release.
