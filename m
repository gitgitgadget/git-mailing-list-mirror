From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/4] add parent rewrite feature to line level log
Date: Tue, 13 Jul 2010 13:47:51 -0700
Message-ID: <7vy6df2jns.fsf@alter.siamese.dyndns.org>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829657-26607-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 22:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmOh-0007sH-4R
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 22:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0GMUsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 16:48:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0GMUsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 16:48:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DB67C41D1;
	Tue, 13 Jul 2010 16:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=egruDDYqzIh/Ns0SgI3rMTbpzv0=; b=IYYQqP
	t+sxHHuGjLf8Jrni903EjN0tovEFTiWthWbJOi7029CgUWoOiXKQERkfkD2cslQ/
	D94ifW6ZncbFDJnOEWLwDjVqw8X2dfUcVIpLBAFgHj1mvrYzp2ECzZYTa3wCtUtd
	mmA3wp2xNJ7LCKlCrjkC0o+nj9PlZ49CrSw38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGlgY1rXgzGsItT58vbuISa2OqaoTjls
	dVZaTpjP82/SQ9IOi5lXvw/9hM9r2afYy3cDxSc6bUP+qo/EdTCcTAXt98Nq70AT
	7acnZEe9sfyDskCaTHqpxuMDRYcWrCmkRu6wufDaj36f5eO0dSEWbQ2mgaoaMtpm
	Aq1MiDLkQj8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6BCC41CC;
	Tue, 13 Jul 2010 16:47:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EFEEC41C8; Tue, 13 Jul
 2010 16:47:52 -0400 (EDT)
In-Reply-To: <1278829657-26607-3-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sun\, 11 Jul 2010 14\:27\:35 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB18F7C0-8EBF-11DF-AB2C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150910>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Two kinds of commit are qualified as a parent:
>  1. The commit touch some lines of the current
>     interesting range;
>  2. The commit is a merge commit.
>
> So, there will be more commits output than the
> situation which parent rewrite is not set on.

Sorry, but -ECANTPARSEATALL.  What do you mean by "qualified" and in what
context?  What makes these two conditions significant?
