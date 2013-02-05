From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebased git-subtree changes
Date: Tue, 05 Feb 2013 15:18:28 -0800
Message-ID: <7vy5f2nyd7.fsf@alter.siamese.dyndns.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2rmy-00040m-3N
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 00:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab3BEXSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 18:18:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab3BEXSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 18:18:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E61CEC499;
	Tue,  5 Feb 2013 18:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=660Gh41d1AFaP87uRSN5Bs6431k=; b=nI2fOd
	W3lk2y/n3KLdPwwdIlUlmlQ6Nc31RCRVZLqSEVPJRcaf5yHXitTYKYQuUoW/Q6kC
	Sl3uIL0dzBZGY0vI8rB7FphVuFBsLkzvcl24n+GBSUEuKowzERwbI5qV0y8OfPGE
	BPn+/CohZOMfoCYZjZP2ICKW8KKVWZneZdMqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N7cH/6S4mZKP+uDPhDqv2RMlq+OFbKhu
	cYUppPUYC2So7iDA7i4a+8rfTc0Oe3bf39KTaSKDKbPOK/xEiuwExwmIzQp5NU3K
	1WCDTGEKyj5HweWaE29cVKb7dJC4vrp/WAi/Jwv0AKlPgUp3vlCcetcJflBRkzRJ
	wftxYUqbQp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C45C498;
	Tue,  5 Feb 2013 18:18:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 454EFC496; Tue,  5 Feb 2013
 18:18:31 -0500 (EST)
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Tue, 5 Feb 2013 05:36:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AEAFD1A-6FEA-11E2-AD2F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215551>

This looks to be of mixed quality.  The earlier ones look fairly
finished, while the later ones not so much.

I am tempted to take up to 06/13 and advance them to 'next', without
the rest.
