From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] glossary: add 'treeish' as a synonym for 'tree-ish'
Date: Wed, 19 Jun 2013 14:46:48 -0700
Message-ID: <7vli65ydrr.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-2-git-send-email-rhansen@bbn.com>
	<7vli6610yg.fsf@alter.siamese.dyndns.org> <51C20287.3060301@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 23:46:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQDP-0001Oq-P3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 23:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934936Ab3FSVqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 17:46:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934566Ab3FSVqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 17:46:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF53C2983A;
	Wed, 19 Jun 2013 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vhao8W8pMuDlVkPCjdrlEj8rXKw=; b=ix5zkW
	pyYsKSyZmS8aRr1Ccqrs4Cl5H0+k5oP58gdDyl5BshZinFcbOeKUwF5Q/zKSm4S3
	DXOUpCmIVnGXHbQeE12SllUdGWfPQ2r40oRDzsCBwRTBa5SG02V7d/W1LM+LI1+J
	PH7dAL1lgGWU5+SSeJdLbWfYVHYqB7GenkxPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TL5413yP4cPbSDw+QjC1g+9uAxZcuuyQ
	vR4ZeCpLFB4VwLl25d/wo2kjdlJ3QARMtagi3UEL0G8Usi99ppfwomoJwspV+6WX
	XIoNw5PhBnc8WB92Utf4lONkYYrpnGt0xVL52zC8ZhaZcbfckuMh2xyc1mWSvowd
	NWYsmJhiSmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2B3229838;
	Wed, 19 Jun 2013 21:46:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4774C29835;
	Wed, 19 Jun 2013 21:46:50 +0000 (UTC)
In-Reply-To: <51C20287.3060301@bbn.com> (Richard Hansen's message of "Wed, 19
	Jun 2013 15:12:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF6D0E1A-D929-11E2-B9FB-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228426>

Richard Hansen <rhansen@bbn.com> writes:

> Perhaps something like:
>
> -[[def_tree-ish]]tree-ish::
> +[[def_tree-ish]]tree-ish (sometimes misspelled treeish)::
>
> would be satisfactory?

If it is a misspelling, I do not think we need to list both.  An
entry "tree-ish" can be found if you were looking for treeish.

If it is not, then "sometimes misspelled" should perhaps is better
"aka".

I do not personally have a very strong preference between the dashed
and dashless forms, but if I really have to pick one over the other,
I would probably go with tree-ish, commit-ish, as these are not real
words.  I do have mild preference of not listing both to keep things
shorter and cleaner.
