From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 001/14] howto-index.sh: use the $( ... ) construct for command substitution
Date: Thu, 17 Apr 2014 11:25:29 -0700
Message-ID: <xmqqbnvzerty.fsf@gitster.dls.corp.google.com>
References: <1397669398-25410-1-git-send-email-gitter.spiros@gmail.com>
	<vpqsipc1gah.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1War0D-0007jA-TG
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 20:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaDQSZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 14:25:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaDQSZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 14:25:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CAA37AD0F;
	Thu, 17 Apr 2014 14:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYjJCZ89pVluqE5yVu6hX79FroA=; b=XIyd1c
	H5t6hhU2hScCSSTzts6Pa9l8QhdVdugTL5tHePj8n2lCnKB73+M8vpx+d/W9KjKl
	K2CPbR/5TjSnOe5lSO3rd7RIMJiAmIQsHWzYBfZ8caHwNRD5Q74AO1rYj4UX8GKE
	Za0VGoz3fFtE/ydBuwcvUfOPswn59+65DuWD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXpUsCMnZfUnWMav6dWGJhvwemgmt70u
	sWHhpK3jJl97HSvAkvEcPZ0EIoe+cBkn19r6gqhS1ipraB/hHHLxErrqAKrU8D+E
	dGHq4zHJvOwkgcq3XZN+GlL+wLeJyE6eDtVx2fcuJ4cxunPQzGzLLyjHI+ZPMOYk
	xhcc24FdJY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B2517AD0E;
	Thu, 17 Apr 2014 14:25:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD7807AD09;
	Thu, 17 Apr 2014 14:25:30 -0400 (EDT)
In-Reply-To: <vpqsipc1gah.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Apr 2014 11:00:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A84618CC-C65D-11E3-AD7B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246433>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> The Git CodingGuidelines prefer the $(...) construct for command
>> substitution instead of using the backquotes `...`.
>
> For patches 1 to 14:
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> (reviewed the patches in my mailer, and the "diff --color-words=." after
> applying in addition)

Thanks both.

Ideally, we should keep these scripted Porcelain implementations in
the contrib/examples/ hierarchy up-to-date to still work with the
recent versions of Git as they used to.  We do not need to backport
new features, but they should follow the best-current-practice of
the use of plumbing features and scripting in general, and this
update is probably a step in the right direction.  It is somewhat
sad that these are not tested but I do not think of an unintrusive
easy way to keep them also in the test suite.

Will queue.
