From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 03 Jul 2012 10:19:58 -0700
Message-ID: <7vehoswym9.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:20:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm6lj-0001tp-DU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab2GCRUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:20:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab2GCRUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:20:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3548885;
	Tue,  3 Jul 2012 13:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8c/m9Drvj3OrsH8aOWfeskH+voU=; b=R9KIpw
	x1eSJa0g8m7blmhPdvfm0BixFr3VpH2N89rSgyAdQRacjDeNQLMN87iBCgDsPPz9
	RpBWyYLLohDi5xkUVCHSK9mssiovLn8Gm8n+Ptc+rjKTAzaVD6KkffBxfhb7gog8
	dGgGwCuAdxF65WXh4XsUsfeXGX697LYwnyMYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vo44LjxnrC9roOIVUu23sfquQzv1GbIv
	pdu7Jn/vfacPeEv3dzNTwuRvKWqLY8VVddICBhVDGur5QM2xeEJUjC+01h+Zgjv4
	YYX5o5rH2LSjZ7ERcC28hXHXAGVZMyeaeRY3lulR4OXUQedib4FxkgXfhIdooT4t
	nb+Hri1zHSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E6A8884;
	Tue,  3 Jul 2012 13:19:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E6DC8881; Tue,  3 Jul 2012
 13:19:59 -0400 (EDT)
In-Reply-To: <20120703071940.GB16679@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 03:19:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5130A93A-C533-11E1-B7B0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200921>

Jeff King <peff@peff.net> writes:

>   $ git show 0003^{commit}
>   fatal: ambiguous argument '0003^{commit}': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions
>
> I think the code is right not to return an object at all (since it is
> ambiguous), but it might be helpful to say "your sha1 was ambiguous, but
> none of the possibilities matched our criteria" or similar. Otherwise
> the error message looks exactly like the "there is no such object at
> all" case.

True.  Thanks for reading.
