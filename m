From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 07:50:29 -0700
Message-ID: <7vvcjb3x3e.fsf@alter.siamese.dyndns.org>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
 <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr> <vpqzk8ngz6k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: konglu@minatec.inpg.fr, Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaTBU-0004u3-3I
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 16:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368Ab2FAOuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 10:50:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933193Ab2FAOub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 10:50:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B438F1B;
	Fri,  1 Jun 2012 10:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aFP9fMmnZs3VjUtSdKv3PoBH4xk=; b=IXMAGJ
	ln3tD4e7mx6CshsFeKTxdDu79PQ1HR5Uj7qqkM8gU9fWtJsftu1RsWVuEtfl0LXh
	zPZQhEE6q2BgJqPoYSjTE666XT5y/lEBg1LjdQ3kyJHgExZh26Dd54u1gebwTXh5
	UOzLXOD/dbkGdxPA+ES/RlU7m+w0d2h6zbSM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dn6IcCy8f0Cprt8jL/ALEw/L1kKmDaR3
	LeFDhu6S0et1WC0w7RnFS6fCe2bgfYtPY4+yrTpSkdXJqhx7gObzreyxgXl3P3gD
	SwSCqYN+ByP8Fpe/x+8FY9YxPcu99bPrK+z6oLHKHfrzdGwAZxUf1ojqghg+8dtu
	gK5Zs0D6s28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09FE58F1A;
	Fri,  1 Jun 2012 10:50:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 899C08F17; Fri,  1 Jun 2012
 10:50:30 -0400 (EDT)
In-Reply-To: <vpqzk8ngz6k.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 01 Jun 2012 11:26:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2227D378-ABF9-11E1-BCE1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198994>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Just an addition: I'm not really a co-author of the work, but I'm the
> one who authorize the students to contribute their code to Git (they are
> normally not allowed to distribute the code they develop for school
> projects).
>
> I think this implies that I should appear in the Signed-off-by: of the
> patches.

Glad I asked.  Yes, it would very much help if you sign off these
patches if that is the case.
