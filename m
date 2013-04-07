From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] glossary: remove outdated/misleading/irrelevant
 entries
Date: Sun, 07 Apr 2013 10:24:17 -0700
Message-ID: <7vobdq45ku.fsf@alter.siamese.dyndns.org>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
 <2094586774.1719611.1365347377194.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtKS-0003VQ-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132Ab3DGRY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:24:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934124Ab3DGRY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:24:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4A81320A;
	Sun,  7 Apr 2013 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S7h/9o8CD84GLm3l87MOKekOQAI=; b=LpbQm0q8FbRQNfggmh5Q
	LRZa8VytC2hHmAt1s1mCSm0Ls49oyGEhOmLH+brAJ8T8JN1Tv8PJyjuOlzlkRS/G
	OygbYFDK+KtQsCeuZppHV0pxm/A4spM3f0hiNNr1/OzpUJVAiMAZFU2+dnJCKpSt
	IhWJC/4OJbUvrQG+wmRdFow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aqQdN064IPqNbESPszixRjI/7PLTDsyDPVidgFj9Uxv7VD
	4VwoLbQQcIhZ0Tzluv0iI7Esp+jOjdiskFyjoQv7t+kXmt+qArOELuFYcQUsk5e2
	tkzWEgXWDZWpnhYdO/YJSxT8n1Xno92M0Kc4fXBGwYrsQZ4+cUtPMczAHGVgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4AF713209;
	Sun,  7 Apr 2013 17:24:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4979913207; Sun,  7 Apr
 2013 17:24:27 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFB74276-9FA7-11E2-9267-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220335>

Thomas Ackermann <th.acker@arcor.de> writes:

> -[[def_dircache]]dircache::
> -	You are *waaaaay* behind. See <<def_index,index>>.
> -
> ...
> -[[def_ent]]ent::
> -	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. See
> -	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
> -	explanation. Avoid this term, not to confuse people.
> -
> ...
>  [[def_octopus]]octopus::
> -	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
> -	intelligent predator.
> +	To <<def_merge,merge>> more than two <<def_branch,branches>>.


I agree that these are distracting and confusing than useful
historical references to our target audience.  People from an
earlier days of the project may miss the occasional entries with
these "fun" phrasing, but we are no longer the primary target of
glossary.

Will queue unless others object.  Thanks.
