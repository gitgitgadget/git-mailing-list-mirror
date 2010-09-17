From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 11:21:16 -0700
Message-ID: <7vzkvg2pur.fsf@alter.siamese.dyndns.org>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
 <1284687596-236-2-git-send-email-patnotz@gmail.com>
 <4C93288B.7000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Notz <patnotz@gmail.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 20:21:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwfZ1-0003rS-7K
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 20:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab0IQSV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 14:21:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab0IQSV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 14:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5365DD6C63;
	Fri, 17 Sep 2010 14:21:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I4EmBh4CvX2bimcjSGLr0+O4wws=; b=S2z+MS
	F0XeLvEeQDM8KCqVVxiqC+Tm30u+LrNzelO0laCz2AFsKEMyNSfvI+2W93Jr+o59
	RI3f/cCOsCNcFu5oWmmqlokuZ9eW3LdnUShzmeqNBSTix6Yh+O8BM3jif+PZ/Dnp
	zCghjjdISggKc9nWsnvJhsjmm46TMniTPJAKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DBbL2aDYsWVSx+56wnIBn93Si3VS4/hJ
	WOdpJ4oakKy3vcxXBkQ15I5wAbRznM3kPwydttqwO10Ela9ZNzcdpfvNUW6YgYUE
	dtwOtv/jAzzlcUc4G8loE/1EljURL3ZaYQvBfkrEaKnupnD2UZj8vnkWfFJn06OT
	O8JkrZP+eZk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0C5D6C3D;
	Fri, 17 Sep 2010 14:21:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59495D6C39; Fri, 17 Sep
 2010 14:21:18 -0400 (EDT)
In-Reply-To: <4C93288B.7000908@gmail.com> (Stephen Boyd's message of "Fri\,
 17 Sep 2010 01\:36\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5FAB6892-C288-11DF-A5E5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156406>

Stephen Boyd <bebarino@gmail.com> writes:

> The whole point of squash is to combine two commit texts, right?
> Otherwise wouldn't you use --fixup where you throw away the text
> eventually and thus don't want to open an editor?

You mentioned almost everything I wanted to say.  I think --fixup makes
sense, but I doubt --squash does, _unless_ its interactactions with other
message pre-filling options, e.g. -m, -F, -c, are really well thought
out.
