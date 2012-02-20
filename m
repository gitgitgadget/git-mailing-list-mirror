From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Make libintl in libc detection more robust
Date: Mon, 20 Feb 2012 00:34:01 -0800
Message-ID: <7vd399nbt2.fsf@alter.siamese.dyndns.org>
References: <1329593884-9999-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOhK-0002kp-4r
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab2BTIeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:34:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab2BTIeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:34:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EC213F14;
	Mon, 20 Feb 2012 03:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mQioQPztgRd3QNlomYx525PucOs=; b=W+E9QnetTYLj0Lx2PJNG
	vc/UcEp8xSn+7B7hRWK6j2iKyliOc4DvcVkhEavUMGpm6SGfgoOHgUUTW7VezbHA
	sxXE70Bow2wwm9+uSEWf3SxHCjIhwfN+CeHJVEFPdR/01fJFvuNhu8GGTxgZu8S6
	94owTN8MRGaY7Xun64u1qK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jIFQsplimdn6A1hOV1eH9vDCITM3l4/++Q0WzDJ3cnpFZS
	p/tWqv96tv7glRe1c3U3hq57g+PsE4wZ5xKnfVxDRw5+BuO9mz1bl3hIakhsFGx6
	XAdGieCeS2Op2fMenxe5Fu9RJ1bqX/F5R6q+fVzaUofq6TJwmbaSX9xjy+8PY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 608A23F13;
	Mon, 20 Feb 2012 03:34:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E31DA3F12; Mon, 20 Feb 2012
 03:34:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4B9433C-5B9D-11E1-AEB3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191054>

John Szakmeister <john@szakmeister.net> writes:

> This is my first time submitting a patch to git.  I hope I've done
> things correctly!

Looks good, except for the subject line that would have been better to say
something like:

    configure: don't use -lintl when there is no gettext support

I'll tweak the log message and queue.

Thanks.
