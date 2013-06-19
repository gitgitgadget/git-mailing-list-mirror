From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Wed, 19 Jun 2013 15:23:34 -0700
Message-ID: <7v4nctyc2h.fsf@alter.siamese.dyndns.org>
References: <7v38sgb9o8.fsf@alter.siamese.dyndns.org>
	<1371667567-1907-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 00:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQn2-0007cX-2u
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 00:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935215Ab3FSWXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 18:23:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934961Ab3FSWXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 18:23:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A62929C78;
	Wed, 19 Jun 2013 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A5vM3XJCHbegWaMwuwz6FgOt+38=; b=AGeVbc
	d6kv3krKDV5t3A7fWlL7s1iFXMVgdKoBRcot69oSY/LWko/0Gr3aDXJ624Cw1j2r
	e6CTMTqOFhoWRkGrFfVkViW2K33eChNbYve6q/7nZ05jaOtg1c+8c4Z6eVz+uAvd
	B0yXjIBMOPPIdieN9iDyjCyyZdsXae3RWysGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vsTyCy56QTC8KKhWN288ElmPtcvxRsWl
	URS0BGAmc/4JtODTkLJcmZ1RKZ0t5MUGwg/0qaLPoN7Zq7mqUBLsMBGW4GOT9eL8
	vnMdMqLRWooVGR/3NQqlj+7OqeHCJ2S+k+0PSPH+ahnstMqOzzvLGmbjCLsZa8E5
	lSsJUjS5Nv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 979B529C75;
	Wed, 19 Jun 2013 22:23:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA96029C72;
	Wed, 19 Jun 2013 22:23:35 +0000 (UTC)
In-Reply-To: <1371667567-1907-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Wed, 19 Jun 2013 20:46:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E20AD614-D92E-11E2-BB41-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228429>

Antoine Pelisse <apelisse@gmail.com> writes:

> So here is a more thorough description of the option:
> - real changes are interesting
> - blank lines that are close enough (less than context size) to
> interesting changes are considered interesting (recursive definition)
> - "context" lines are used around each hunk of interesting changes
> - If two hunks are separated by less than "inter-hunk-context", they
> will be merged into one.

Thanks; will replace what is queued in 'pu'.  Let's advance this
version to 'next' soonish.
