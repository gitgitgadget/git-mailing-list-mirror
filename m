From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes: noted the addition of contrib/diffall
Date: Fri, 09 Mar 2012 10:15:49 -0800
Message-ID: <7v399h7i96.fsf@alter.siamese.dyndns.org>
References: <7v8vjadfgg.fsf@alter.siamese.dyndns.org>
 <1331300127-21169-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:15:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S64M9-0001z2-SV
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 19:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab2CISPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 13:15:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab2CISPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 13:15:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB607DEE;
	Fri,  9 Mar 2012 13:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J/HJHXrELchi6UnPGZJbNEZwWDg=; b=KxCECm
	ONu6YzghFVYluGjk1QMiqIyz6wOeholZhbWoor17Nw6A5fS2VugzxC+qrEm6D6Qx
	leUZ3Xdp4Is9S/9MgLAvwHcqeDzidU3xYTnoe+yEuNGMAEyvqXQCBsYkiHSu6YPf
	hONnXRSuSx/AUBQq6GdoCMft9irRrYJ65UAtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZ0XToPRinQB+jRgM4p6UB4lRw/gkK7q
	XOWBHHexUkChlmMUiXK/27NQUX8xj28DzHXtlWnqATCrOzEcc+R2Rej8Qe+MA6RL
	nayGv1CIvhNHvMFjw8Ix8xwOO96UNMgjLG41/+jmv/miO6mLWttjTqPbKnhYBZQn
	qwuQ25q+jlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C30A87DED;
	Fri,  9 Mar 2012 13:15:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54BD17DEC; Fri,  9 Mar 2012
 13:15:51 -0500 (EST)
In-Reply-To: <1331300127-21169-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 9 Mar 2012 08:35:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7325918-6A13-11E1-9530-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192731>

Tim Henigan <tim.henigan@gmail.com> writes:

> I wasn't sure if you wanted an actual patch or just wanted me to write
> up the paragraph.  If you squash this in to some other commit, that is
> fine with me.

I didn't mean to burden you with a proper patch submission and just
a paragraph write-up was perfectly fine.

> + * "git diffall" can now be installed from contrib/. The script drives
> +   an external tool to perform a directory diff of two Git revisions.

I'm tempted to add a third line, like this:

   ... an external tool to perform a directory diff of two Git revisions
   in one go, unlike "difftool" which compares one-file-at-a-time.

to make the true value of this new addition stand out.

Thanks.
