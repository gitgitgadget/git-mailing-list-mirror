From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: implement suggestions made by
 perlcritic
Date: Wed, 27 Mar 2013 10:38:44 -0700
Message-ID: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
References: <1363869587-10462-1-git-send-email-artagnon@gmail.com>
 <7vd2usbwkn.fsf@alter.siamese.dyndns.org>
 <CALkWK0kkWAkiANL-vL-OthKSDkoU2b_Q68frkGc06QNG7RbSFQ@mail.gmail.com>
 <CALkWK0mvcCODcZN0s=7YQAnpVA053bFrnCr0qugpBvSK=h6Usg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKuJf-0002HM-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3C0Ris (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:38:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab3C0Rir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:38:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A980D9E05;
	Wed, 27 Mar 2013 13:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eAZ+OJwwTMVkErm6xL263zow6ZQ=; b=wdETNM
	Ui76ugYeQKpKrbBgAdNupasdVQIv4W0Mh2gdWXcSHUCPmZdt5SlmbRSNf+YwVmtT
	bAINmwT5bFxljCkX2yu0YJYZKFhnJSNNa/O+wEnWZbksuzaoNQMXWhMfMwDthyFq
	1tNIQPk56RGLVDbc3BIOm8aUDHRxmjY5L+Pz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhYnSSNS2aYwW0FLxr4t4PQIYUzwuEH1
	c9jYpJyW4vb+j8iXnKqJNiVlOWjMzJnNY7x+POY+s+HSWlKNgTDmoK+NflYeGKcv
	YEwJJSYVmLZK7oJvWGZt0DfVpX0jZGOapsmjccobLLv46VIiZgV0nPHauMseHgJh
	qR+PgX6rH8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E7CB9E04;
	Wed, 27 Mar 2013 13:38:46 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 216BC9E03; Wed, 27 Mar 2013
 13:38:46 -0400 (EDT)
In-Reply-To: <CALkWK0mvcCODcZN0s=7YQAnpVA053bFrnCr0qugpBvSK=h6Usg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 27 Mar 2013 22:43:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D13E270-9705-11E2-865B-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219290>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I don't see this queued in 'pu'.  Do you have any objections to the
> patch, or did you just forget?

I do not recall the details but I think I was expecting a re-roll
updating the log message (if the original invited questions, there
must have been some room for improvement to avoid such confusions,
right?) for a few days since the exchange, and then forgot.
