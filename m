From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] clone: do not add alternate references to extra_refs
Date: Sun, 12 Feb 2012 20:00:13 -0800
Message-ID: <7vaa4nidrm.fsf@alter.siamese.dyndns.org>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
 <1328941261-29746-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Feb 13 05:00:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn5T-00089H-7w
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 05:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab2BMEAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 23:00:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097Ab2BMEAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 23:00:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31B876E56;
	Sun, 12 Feb 2012 23:00:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zoMUfNm0qtoaRZta1MbJM1Hin2U=; b=bSO2U/n3UMVoUB9wVJAY
	BDfuNBi/vCZivzZB9nQkc2ftcDTTvVXhgdpzEW5vnTKmjTOQy9As+cOfHKjzmRQa
	o47p4VOLN2I+hJMf/hM/rcFqDRnsy8bXZL9Mmx+hjTFC7VrLVP4z42KRIwVBbIDY
	fVXKw5/ojEESyZkQ1JQHJw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ks+GjVBhNLEBza/ISQzqRumr+yLeeAhjlC2UGia6gNMamr
	UxDMWlA0DTJLOw8sDZoEgXZJInhuIK05Z/e5yohZXY/63G1dlsg1kJJUumdx5vcx
	FHN60XYm2FGovTgWyVPoZ1yfTUocS6F7WzFSoLiiGMX2se+PL/rUKbY5nsm2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A09F6E54;
	Sun, 12 Feb 2012 23:00:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C2156E53; Sun, 12 Feb 2012
 23:00:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BC49BA2-55F7-11E1-BEFD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190604>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Alternate references are directly (and now, correctly) handled by
> fetch-pack, so there is no need to inform fetch-pack about them via
> the extra_refs back channel.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/clone.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)

Very nice (the real niceness primarily comes from the previous step ;-).

Thanks.
