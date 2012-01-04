From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --since --until
Date: Wed, 04 Jan 2012 14:58:09 -0800
Message-ID: <7v1urfoz26.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi30FL+hRSqr3XRNgvOr4yBcTsbTpiNXpxJ=CN1Q=JVo3w@mail.gmail.com>
 <7v62grp0z4.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2vi8WHFNg2+NJCWnQ_atnCTRKXyBDJJpA8GM6nHmj6HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZmj-0004At-B6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2ADW6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:58:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757163Ab2ADW6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:58:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87ABF76BF;
	Wed,  4 Jan 2012 17:58:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QsO+vW31J0IhBJ9pa+VIXNPMkTc=; b=r1r5NM
	wB8hBw9glJ2f/2AnFrgRJmDnUxgccFLrzosbRvr9HHtAOCZBXUIgtflouo78HHe7
	2QkpiomB3u1C4VbnokrVBfixyBq+Qr7lfEoqT7nkZ2p5TBlhgsT13uVgOoNU5JRW
	0rEi68Q6XlBeN99rRHCbiKrtDIFrCSauni8cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QC5N5TnS7UR+g7rSzVvnO03cOF9Le2kG
	dDuV55g3Jr5frJq/4AUjbI09KIs42uzWAkr4tq3BjlYvgzS/QrrFM6rqjhCz1IU5
	x+SjNYeX4WKMLlNrjQKt2oqg5DOh08Ppls+FtKIPmE45T7oSDstl+Quw/Z0Z01Y5
	qiz9sODNfFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F82976BE;
	Wed,  4 Jan 2012 17:58:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15D2276BD; Wed,  4 Jan 2012
 17:58:10 -0500 (EST)
In-Reply-To: <CAE1pOi2vi8WHFNg2+NJCWnQ_atnCTRKXyBDJJpA8GM6nHmj6HQ@mail.gmail.com> (Hilco
 Wijbenga's message of "Wed, 4 Jan 2012 14:32:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 933816DC-3727-11E1-A99B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187953>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> ... the author date seems to be additional data without special
> meaning to Git.

That is exactly correct. The author date is merely for human consumption.
