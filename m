From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bulgarian translation of git
Date: Wed, 15 Feb 2012 10:09:37 -0800
Message-ID: <7vehtw0xzy.fsf@alter.siamese.dyndns.org>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
 <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
 <7vy5s7idxb.fsf@alter.siamese.dyndns.org> <20120213133957.GA4838@burratino>
 <7vehtyftwf.fsf@alter.siamese.dyndns.org>
 <CANYiYbF-M0SLP=XFkD+nEVRth05pf3hohPLyqQ75qjtNGqANMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxjIW-0007pL-7l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab2BOSJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 13:09:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab2BOSJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 13:09:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1837A6104;
	Wed, 15 Feb 2012 13:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RaNB7CQ9Re7xobGIxxcbGsT3qAk=; b=hdCF/9
	o84dFkBe4MS27n8AJ3Om8IO2cqLgJtgPgHVv7FEQtabANs03LWDcZsjCcW4yhhCi
	CbMXiFqsqj4qvzhbEP3T3QcqnCAnwsIlSNvC8djmT+odrs6lPPUswbVAghxwWX9X
	Wq2QFPFyCMa+/R6bKtVT+Dtq6iZd7lfl15wDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ur0kCF4dJ9vq/WdHcKQ2c4b6LIB3Id3R
	1iNfsi7Cd/oj2XitUstVNKUq1ezH97CBhyVZSUqeft6KJfyiv2CeVLW9XJ+eaXDP
	KwcvQeB4voQPfX0OzUxv/PH1PUjQ6CLPSG0Hz3IMWuUaVp6WzVRt25qBK76Xpyb6
	poGrjdNP6oU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E85C6102;
	Wed, 15 Feb 2012 13:09:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D6A96101; Wed, 15 Feb 2012
 13:09:38 -0500 (EST)
In-Reply-To: <CANYiYbF-M0SLP=XFkD+nEVRth05pf3hohPLyqQ75qjtNGqANMA@mail.gmail.com> (Jiang
 Xin's message of "Wed, 15 Feb 2012 11:28:28 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39782516-5800-11E1-A231-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190843>

Jiang Xin <worldhello.net@gmail.com> writes:

> I squash the following in the pot initial commit, and update the commit log.
> commit:  https://github.com/gotgit/git-po/commit/master%5E
>
> diff --git a/Makefile b/Makefile
> index 87fb3..88268 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2576,7 +2576,6 @@ dist-doc:
>
>  distclean: clean
>         $(RM) configure
> -       $(RM) po/git.pot

Yeah, that change is very sensible.  I am surprised that nobody noticed it
so far while this topic was discussed.
