From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [NON-PATCH 3/2] Documentation/git-merge: format full commands in
 typewriter font
Date: Thu, 07 Jan 2010 13:08:38 -0800
Message-ID: <7v3a2h39nt.fsf@alter.siamese.dyndns.org>
References: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch> <ebbb4e2b0e98490a64b3cd52c33d3a995fa7e980.1262883414.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:08:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSzbD-0007vo-8N
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab0AGVIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324Ab0AGVIs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:08:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0AGVIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:08:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1EC58E0D7;
	Thu,  7 Jan 2010 16:08:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RJEryp6p3m7MHLrbg8xs/CoQDDs=; b=cjUzEM
	A/FG70hsEHlglMPKfTaWuSb545WJrNjhch0Wn1W3OOkCAg1HQeVoYPy6dLW4kKov
	44nymxkDOzwWsD04tDi1Z8Bc9uM70kl4Oxuz7x5wLFtkP3cr/JAjzxksa/AM88zW
	BUWeA+Zpx3jmhkMq2EnuVCRP+TqWnDbyaD2WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qEgCaIjC9xvPRSxQMGHK827tSlrQ814P
	IsJM1sgrIn6Y6JSUeVps/Pfx+qx7i/slabsjuCMBrHleoUqNh8xyY5pohe/PJFcr
	AUC1VtKW0QG4NSegEtbUZ0lavCNZwcTK6GmFZ6R827zyhZyCMK0sGSWvcrdlsLCm
	4j4L4BadGjk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCCBE8E0D6;
	Thu,  7 Jan 2010 16:08:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CE9F8E0CE; Thu,  7 Jan
 2010 16:08:39 -0500 (EST)
In-Reply-To: <ebbb4e2b0e98490a64b3cd52c33d3a995fa7e980.1262883414.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu\, 7 Jan 2010 18\:03\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5DB81D4-FBD0-11DE-9167-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136385>

Thomas Rast <trast@student.ethz.ch> writes:

> * More importantly, while `code` style seems to be an improvement in
>   HTML output (because it gives typewriter font), my local 'man'
>   renders 'emphasis' as underlines -- which actually makes the code
>   snippets much more visible than `literal` quotes which are not
>   rendered specially at all.
>
> So which way should it be changed?

I'd prefer to see us mark code as `code`.

The documentation toolchain may hopefully be fixed in the upstream in the
future, and we could keep our local style tweaks in Documentation/ until
that happens if we really wanted to.
