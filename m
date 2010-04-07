From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 07 Apr 2010 13:02:54 -0700
Message-ID: <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
 <1270668793-2187-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:03:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbTB-00055C-95
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab0DGUDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:03:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab0DGUDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F52A8239;
	Wed,  7 Apr 2010 16:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2xQl3JDYF234CkzAxE8ku6YwcN0=; b=huYhS2
	Tu0AxxHugSNk81dGeYmPfjg4+E41wADH96XgW+0TKXPZWIYd1qVFlu4WUiRHJf/D
	jHvaUu0+qfmfCULoL97xaUFV1qolLdhIunV1beseJP7/z2WM6gi9I2yJId9i6R0z
	ZBNeZhIxFSWqfKinB68oU4tu4zbD9xo7JJnZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0v06hxH9qIz9ayCnEaKrulvMEBN0PFO
	JI+C5WbklEo3nw5Q+lWVvsaZD7nFzOHhlbLHmyKXkM+QCvl3CZFEDGbrkk3FASF0
	7gtQchp5MER93mEPjm5LgH4AMGGZUhQhE8lm94nMlgGJyBQvmcz25nenlSUMbVxe
	4SGtvY9iHBc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB37A8225;
	Wed,  7 Apr 2010 16:03:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C450A821A; Wed,  7 Apr
 2010 16:02:55 -0400 (EDT)
In-Reply-To: <1270668793-2187-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu\,  8 Apr 2010 01\:03\:13 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95AA826C-4280-11DF-AEE3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144280>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The web interface mangles patches no matter what. Replace paragraph
> about "git imap-send" with another one about "git send-email".

My impression has been that people are using MUAs that do not corrupt
patches and are capable of using IMAP drafts folders with Gmail, without
ever touching their patch-breaking web interface, and the description you
removed was meant for them.

Is the web interface the _only_ way to interact with IMAP drafts on Gmail?
If that is the case, your patch (or Aaron's earlier attempt) to make the
document not to talk about imap-send in the context of Gmail makes sense.

Even if it were not the case, as long as only very few people use IMAP
drafts on Gmail via MUAs not their web interface, I am fine with your
change to add send-email recipe to help Gmail users.

> +GMail does not have any way to turn off line wrapping in the web
> +interface, so this will mangle any emails that you send.  You can
> +either configure an email client that that doesn't break lines to use
> +the GMail SMTP server, or use "git send-email" to achieve the same
> +effect.
> +
> +To use "git send-email", edit ~/.gitconfig to specify your account
> +settings:
> +
> +[sendemail]
> +	smtpencryption = tls
> +	smtpserver = smtp.gmail.com
> +	smtpuser = user@gmail.com
> +	smtppass = p4ssw0rd
> +	smtpserverport = 587
> +
> +Once your commits are ready to send to the mailing list, run the
> +following commands:
> +
> +	$ git format-patch --no-color -C -M origin/master -o outgoing/
> +	$ git send-email --compose outgoing/*
