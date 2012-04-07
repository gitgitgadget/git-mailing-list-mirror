From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Fri, 06 Apr 2012 22:00:04 -0700
Message-ID: <7vy5q8xhkb.fsf@alter.siamese.dyndns.org>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Adam Roben" <aroben@apple.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 07:00:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGNl5-0003MT-7N
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 07:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab2DGFAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 01:00:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab2DGFAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 01:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDF342C4;
	Sat,  7 Apr 2012 01:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bnk4D1zVVf68/xGqEHTWB/eTEX4=; b=uRjxJm
	sdy1DBVgzRyfavq2/YfORhNOoKf82H0MC7wD92fTA6pf3WSbAUo4NhSz0TbZGy6H
	zhTr8hcJNn3RRN4zDvZsrrwJX1iXguv6XgdKGU9zz70KVDTvyqMDCOGGW7uC2xUy
	0dG3no0YEHXNHbD5I5SoL5K/3IaDL+ivfLric=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfVMe67rKDx3n8XIldlrRjN7aKbGEyTW
	izGaV0qkTSnu2VuHESTw56Ruv3JA2yplGswd9AtJLRUp9JWSBH5tLiAT8+xurBQe
	oPkSuJa9n/5W0QjTo+2GE35Dto14Ei5FUbOXRtEvOkWfJT9FIdRwyBvTY0I53Xve
	ImvMVlDcjjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE3542C2;
	Sat,  7 Apr 2012 01:00:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0022342B9; Sat,  7 Apr 2012
 01:00:05 -0400 (EDT)
In-Reply-To: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 7 Apr 2012 03:29:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ABBE8D6-806E-11E1-B6D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194935>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some people always do --annotate, lets not force them to always type
> that.

Thanks.

As long as there is --no-annotate to cancel a configured value for
one-shot invocation (I didn't check, but it should be added if there isn't
already one), I think this change makes sense (I admit that I do not use
the --annotate option myself, though).

Are there any other bool-ish command line option that deserves to have
corresponding configuration variable?  Is this the only one that is
missing the configuration counterpart?
