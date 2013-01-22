From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] Change old system name 'GIT' to 'Git'
Date: Mon, 21 Jan 2013 16:39:04 -0800
Message-ID: <7vfw1udpav.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1335904329.632749.1358795780375.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxRtj-0001V8-28
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 01:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3AVAjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 19:39:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab3AVAjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 19:39:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 644BBCD38;
	Mon, 21 Jan 2013 19:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YMzBdQRHEJdOy6byA/P+sqSZI/M=; b=Ck8t1S
	DrGJXw5k/i6YxdrUNzepflh67BDr/Gk8IrqsmPUsWsPQi10E+oAucLPGjcXjqeH+
	d7X9X7zoXstUTPfx4pABXT2ueXEixrDZX/skJP7LmLzRJBfb6VhHFw7xd3J5l9Z8
	yud9x8C/Niz7lQ4Lx1UOVjdbM6MC4HJSKv3HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sP6nrwe+dw8RUH0sWgNXWRmYHrTgWNgc
	OMkCvONg8VtxsBJMMh95tPRVVgQ1WcxvDO6lqeMKO1ZsqXn6oZUQqNXTzFpC1dmx
	t+jMTi/yEwzbhmZzL0NUJorQXYs+uahi12RzmNKcUrS1fE00UcC6RMSH1y9T7yA0
	dY8UUI1wdOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57ED5CD36;
	Mon, 21 Jan 2013 19:39:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1C22CD34; Mon, 21 Jan 2013
 19:39:05 -0500 (EST)
In-Reply-To: <1335904329.632749.1358795780375.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:16:20 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2050BD12-642C-11E2-8E79-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214180>

Thomas Ackermann <th.acker@arcor.de> writes:

> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
> (as can be seen in the corresponding release note where 'GIT' was
> changed to 'Git' in the header line). So change every occurrence
> of 'GIT" in the documention to 'Git'.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

This is more about "stop using poor-man's small caps".

I think it misses "GIT - the stupid content tracker" in README, but
probably it is OK (it is not an end-user facing documentation).

I noticed that these two places still use poor-man's small caps
after this patch.

 * Documentation/SubmittingPatches:
 that are being emailed around. Although core GIT is a lot

 * Documentation/git-credential.txt:
 TYPICAL USE OF GIT CREDENTIAL

With these two updated, I think it is a sensible change and the
patch is timed reasonably well.  It applies to 'maint', and other
topics in flight do not seem to add new uses of GIT.

Not commenting on other 5 patches in the series yet, but if they
interact with other topics in flight, they may have to be separated
out. We'll see.

Thanks.
