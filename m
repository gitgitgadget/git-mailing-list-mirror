From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] '"succeeded" was misspelled in the code, which
 propagated throughout the translations. Fix all of them"
Date: Mon, 05 Mar 2012 17:43:54 -0800
Message-ID: <7v8vjewlk5.fsf@alter.siamese.dyndns.org>
References: <CAGOdq5mZdyYcKVaBb1=-8gQAxwwgGNs98HCZb-3JYc=8wHY9qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	patthoyts@users.sourceforge.net, worldhello.net@gmail.com
To: Benjamin Kerensa <bkerensa@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4jRe-0007iI-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 02:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab2CFBn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 20:43:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758166Ab2CFBn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 20:43:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF3A372F5;
	Mon,  5 Mar 2012 20:43:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ViH0vjsVvnWe6x57K1ALXrScmZk=; b=heX5HZ
	gdjqsAmYhHDTyDp70+b0kbfh11oZXSnzUdxBTnmTt6ZXzpS0cwiglttMKjtFDLv2
	9i/SPvpOvC/lTDKWVEviuRF2m1BtlqLEfcLK7dO+AXiZTwbkVquiyZvSad3BWUQs
	0y/B2U6qv8sr8mBYP92SXhjE2AHUXPQ5lBDfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzjlPKquX8s8BO0k7UgGJoSs1JmSPand
	9KMJyC3tHlt3CW4X2gbGPg7pwkwkCyLR+UDG0n7jRCNn1WgG/BzqfP7yICwfS8h0
	uQ36pUq8GV0M9QHhu9eJMKN77Lv/nrdYto1+xLBXN2IudZPx9FpGRrmha+t5Mb3t
	Mnqm5ENpblU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C3872F4;
	Mon,  5 Mar 2012 20:43:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09E0D72F1; Mon,  5 Mar 2012
 20:43:55 -0500 (EST)
In-Reply-To: <CAGOdq5mZdyYcKVaBb1=-8gQAxwwgGNs98HCZb-3JYc=8wHY9qg@mail.gmail.com>
 (Benjamin Kerensa's message of "Mon, 5 Mar 2012 17:36:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6120B4E-672D-11E1-80A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192298>

Benjamin Kerensa <bkerensa@ubuntu.com> writes:

> ---

Please sign-off your patch.

A commit log message is "one line summary" (that goes to the
subject), and description in a separate paragraph (that goes to the
body).  What I said was to describe the commit in the _body_ of the
log message, so your entire e-mail would look like this:

 ]  To: ...
 ]  From: Benjamin...
 ]  Subject: [PATCH] git-gui: fix a typo in po/ files

 |  "succeeded" was misspelled in the code, which propagated throughout the
 |  translations.
 |
 |  Fix all of them.
 |
 |  Signed-off-by: ....
 |  ---
 |   po/de.po | 2 +-
 |   ...

where "]" lines are the e-mail header and "|" lines are the body of
the message.

Thanks.
