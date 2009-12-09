From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t7508-status: test all modes with color
Date: Wed, 09 Dec 2009 13:59:15 -0800
Message-ID: <7vpr6nn70s.fsf@alter.siamese.dyndns.org>
References: <cover.1260266027.git.git@drmicha.warpmail.net>
 <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net> <hflc82$sf8$1@ger.gmane.org> <4B1E798C.5050204@drmicha.warpmail.net> <7vzl5sww3w.fsf@alter.siamese.dyndns.org> <7vmy1swvjc.fsf@alter.siamese.dyndns.org> <4B1F6B77.80108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 22:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIUZO-0007xr-BL
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 22:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbZLIV70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757304AbZLIV70
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 16:59:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZLIV7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 16:59:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A782286B3A;
	Wed,  9 Dec 2009 16:59:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ugDh645vUc17Ipq8JRnBmQi62A8=; b=OM0UtE
	bAaUwHTMAnNqh3DpIMinVkOMYZGOrlnUc2pfQqmLhV2xXodAuKobVae5zBeV7bLf
	6CjRSLdtA4iq/a0ExyIIPU9ZMvRAdEHCoEXcHd0lvglqA2ecU+sXef0lkKrptvss
	1l74bCfmE3/YN/5AKHZlEmENhChAX+4pVvFWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtlknapwmsLnyO5j+jBg4cBG6Us4SzNS
	liHHmsYaxko4WxBpTTBbw0ROSmHhflnoBCiJnm2ZV5E1VI2Qr+r1oJZXkJpH4pQ1
	6tA870Kd6N2pxZIwZNjzEijNr8x95OcscrLBmwjBRFxY1boXBPixxiEA/shwZG23
	Eauww0xtdic=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5E286B35;
	Wed,  9 Dec 2009 16:59:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E67F586B33; Wed,  9 Dec
 2009 16:59:16 -0500 (EST)
In-Reply-To: <4B1F6B77.80108@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 09 Dec 2009 10\:18\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D417F3A-E50E-11DE-AAF8-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135002>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Regarding the larger part of your change: Is there a specific reason for
> ...
> ">output" rather than "> output" or just a style issue?

Yeah, I shouldn't have included these style fixes in there.
