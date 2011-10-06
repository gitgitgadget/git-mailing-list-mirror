From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Prompt for merge message?
Date: Thu, 06 Oct 2011 15:02:38 -0700
Message-ID: <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBw1e-0007tr-R0
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 00:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335Ab1JFWCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 18:02:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758929Ab1JFWCl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 18:02:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D38C45158;
	Thu,  6 Oct 2011 18:02:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GiT8nMDjr6tQeJxMiCgQf8MzhSg=; b=NgPTdc
	aNCZPy2ju3vV0y578gdM9YT0oUlljb7Szuzu0JXzF43YvaBSgZezoPH4MGP5IV61
	rnAwHtqpJG4FfEZGf/zsKRDeT5GB6T0Y8OKGeUS1hXGzXgc4JHCQBf6qaNU6kERO
	vY0YE5o6Mgu6wGZ/SwxzsRt4gUEV7AazTnZBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UqjkCGKaBsFaEjSkHZ8M3B1G2FghR57q
	Irdh4RYuQTiast6mhiCGlTQcsjS3XEtKYNHQ1hQu5/s1wEY6PaeAM0bq9Qdi9Jop
	7X20IMPXSvmIy6EI2o6yWCARnpS2uaq1zPJgcElrKQbXraEOoRRsU+7gJ9THumrK
	yeuROqs1o2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8FD65157;
	Thu,  6 Oct 2011 18:02:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BBFA5155; Thu,  6 Oct 2011
 18:02:40 -0400 (EDT)
In-Reply-To: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com> (Todd A.
 Jacobs's message of "Thu, 6 Oct 2011 10:49:02 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8A9FDEA-F066-11E0-9C37-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183042>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> I often find myself using "--no-ff -m foo" for merging short-lived
> branches, because the merge commit usually needs to say something
> about having finished a feature rather than referring to a branch that
> will be deleted shortly anyway....
> ... Is there currently a way to get git to prompt for the merge message,
> rather than using the default or requiring the -m flag? If not, isn't
> this a common-enough use case to have that ability added to the merge
> function?

Others commented on the current practices and gave their own useful tips
already, but an additional hint is to name your branch more sensibly, so
that you do not feel it is useless to record it in the history.

As to a real longer-term solution, I wouldn't mind a patch that teaches
"git merge" an "-e" option just like "git commit" has.

    $ git commit -m "Finish frotz feature" -e -a
    ... editor opens with the first line filled already here ...

is something I find myself using fairly often.

Thanks.

[offtopic: It is annoying that my MUA warns me

    "nospam+listmail@domain" may be bogus; do you really want to send?

Could you do something about it please?]
