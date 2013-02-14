From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 13:51:26 -0800
Message-ID: <7vtxpey36p.fsf@alter.siamese.dyndns.org>
References: <511D3C33.6070902@hell.org.pl>
 <7vy5eqy6z3.fsf@alter.siamese.dyndns.org>
 <20130214210910.GA6660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 22:51:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U66ih-0000ZJ-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 22:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934968Ab3BNVvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 16:51:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934909Ab3BNVva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 16:51:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EED8BBA0;
	Thu, 14 Feb 2013 16:51:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/t1rtv+ttYCYnFqL6u/qqRGUlHI=; b=e7NJdA
	79QtA42EEM527dptnyKZC76Akvpba5BzcVcxrRe+NGynYpdZrOdzu8uMA4CvIxg4
	AmVlVQFfz29riIm2mc9FNhPPvggaltNIzSgEfHex1f1rmXWUTyqkua3LL7dTaGJn
	kREvgno0U5q1gG8wvGyQnX3+9ZjUBq5V9SqDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nXVBp3M1NIRwcvvYgS9rvyUNZrIPo2HK
	VSYc+bxMIuWhWAaGY8C732yU+3dPAx5LqBVRUaNH8vjq3+9n2bbjeujPi8LuKM8l
	+79FLitprgVZZ/hznLENgnt/J9BAN3EdfXBWmgooXcnD+Ebb4ch51taggZSD0l0O
	xqSD5R1mRIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23357BB9E;
	Thu, 14 Feb 2013 16:51:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AE8CBB9C; Thu, 14 Feb 2013
 16:51:28 -0500 (EST)
In-Reply-To: <20130214210910.GA6660@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Feb 2013 16:09:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFA7C10A-76F0-11E2-8C2A-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216335>

Jeff King <peff@peff.net> writes:

> I think it has always been the case that we export them after setting
> them; just look at the preimage from 3c730fab, and you can see exports
> there.

Yeah, I think the only difference is a broken commit case where sed
expression did not find what it was looking for, in which case we do
not do the export.

> I think the advice in the documentation about re-exporting is because
> some versions of the bourne shell will not reliably pass the new version
> of the variable ...

Ahh, old and painful memory of Solaris days comes back to me.  OK,
let's keep the export then.

Thanks.
