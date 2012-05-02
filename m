From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #01; Wed, 2)
Date: Wed, 02 May 2012 15:19:45 -0700
Message-ID: <7vehr2gr9a.fsf@alter.siamese.dyndns.org>
References: <7vipgegrl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 00:20:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPhtt-0006GX-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 00:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab2EBWTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 18:19:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab2EBWTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 18:19:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5F248255;
	Wed,  2 May 2012 18:19:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YrBoZQXCthzaFkT1cnQP5sHIwWY=; b=T9w7wb
	MeXbEfeBuqcP0+LfoTJmHiwAxBVPwFEdb/4ng1A5lo0gWPzEd7McU2AHrtR44+FP
	p3vQUEqf7EtpP/h9/mPwx2l+dLAtz45pr1/cCLtKb31Pbn0DZK+bsjhcjpbzKyY2
	IIYO3d4AnaYypUYXuiIt7yWY3TQtzZPXjRsGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nni31tPgJ6gca7S1YG+I0RFaFi1OawW4
	I7aliJw6yKQmWH9NcG3mcoQ/B+yxIcKsGvsBf2aETo8lW7IGFoFQRQtOjDQ+MJ+m
	t8TlgQv7rLJxgdxT86l6cFi3ZFkKxSQnMwiE07R2yWbOhgiKi7oAaaGB/89N66yZ
	ahG+c2X3Pm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE9B18254;
	Wed,  2 May 2012 18:19:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 664448253; Wed,  2 May 2012
 18:19:47 -0400 (EDT)
In-Reply-To: <7vipgegrl0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 02 May 2012 15:12:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED480C1A-94A4-11E1-8600-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196868>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.
>
> The eighth batch of topics in this cycle is now in 'master', the topics in
> 'next' all look ready, and we do not have many topics left in 'pu'.  The
> cycle is going well ;-)
>
> Except for folks with libsvn-perl 1.6.x where x is greater than 9; we know
> how the fix should look like, and we will have it in tomorrow's integration
> round.

Actually, I lied.  Eric's pull request almost crossed with the
announcement, and I decided to redo today's integration cycle to include
the fix, as having to say "GIT_SKIP_TESTS=t91?? make" is just annoying.
