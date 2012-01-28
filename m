From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #06; Fri, 27)
Date: Fri, 27 Jan 2012 21:37:57 -0800
Message-ID: <7vfwf0xu8a.fsf@alter.siamese.dyndns.org>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
 <7v7h0czur2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 06:38:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rr0zh-0004q1-Ho
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 06:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab2A1FiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 00:38:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab2A1FiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 00:38:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E840B6C90;
	Sat, 28 Jan 2012 00:37:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C3MWjBapQEXGwjyF+8FNzrTfcVA=; b=CqqwE3
	QsVlhr2e2zQdVr0eKGfHzLlxulN64IoHnCy0BTzQ6NdjrPxwfQJj/UZU27xRGWFA
	6bB4+KKeBcI/mQGRC5VCm9/X3tVNbZNTreQrHYgaSMtUSin09IuntmIUaz14n7VE
	unAk1C0uYWzyKyWiH061LJAHbsTbzn1EwFDq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BfSxT/t3jRWS+DjavjW+4wI5pucwxoOV
	bM7o0zQDNCVO3F7uCwH7hTNcFwFyuGK57pjbdIk6ThKxOjW+9ousKL3JELEcTAQJ
	hUsks9YJleEmI52802VyJd2uN+3otkdYOxT/hYiH+a6FCMZVfc20w2mF2MySdjb6
	P68IF6/fw6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE6276C8F;
	Sat, 28 Jan 2012 00:37:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75CF66C8D; Sat, 28 Jan 2012
 00:37:59 -0500 (EST)
In-Reply-To: <7v7h0czur2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 Jan 2012 13:43:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CEA9EBE-4972-11E1-8DE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189250>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/zsh-completion-regression-fix (2012-01-17) 1 commit
>   (merged to 'next' on 2012-01-23 at 7bc2e0a)
>  + bash-completion: don't add quoted space for ZSH (fix regression)
>
> Will merge early in the next cycle and deal with any fallout in 'master'.

This topic has been superseded by Felipe's f15026b (git-completion:
workaround zsh COMPREPLY bug, 2012-01-25) to use "typeset -h IFS", so I
should drop this.

Am I mistaken?
