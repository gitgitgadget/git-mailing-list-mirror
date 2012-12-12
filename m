From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Wed, 12 Dec 2012 09:50:11 -0800
Message-ID: <7vlid35fe4.fsf@alter.siamese.dyndns.org>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
 <20121128132033.GA10082@xs4all.nl>
 <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl> <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl> <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
 <7vy5h45e7b.fsf@alter.siamese.dyndns.org> <20121212085507.GA32187@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqS3-0001e2-32
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab2LLRuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:50:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab2LLRuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:50:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC2C59F7F;
	Wed, 12 Dec 2012 12:50:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/OwfPwNnbM4nXQ+LPe7ypbVg4cY=; b=ehiZSo
	LndT58PoNLN42kkaADox5fSegXLSqq3sy65fC9UTl5tPEjCi4NhdbSPh8e0+ghUr
	GM4n4mtNm+8XG8d0lZ8nj/LOEUztOzlTzO/K9oWQQf70nhylhrz7xJteiTnWA/bQ
	ueS7uHPSNVZazqS2KVS0AMlCynmbOrfWYQnKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uC2AcPE6Z/Y0/achofMesjrk4iOXNERW
	bzQQ9YYeM1CQXSfcX3UDukv25BbMhfMq6ln6uIkEF/5AeNHMPbRhKT2JxjhqlcYU
	1KBMOoVnG31Cfe1zaj62yOdjDMeurBQ8yQb0aCrXBbO5/u/Kj0yFU+4LZHn/n+B3
	B6KEsqAdO4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D9B9F7E;
	Wed, 12 Dec 2012 12:50:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411589F7C; Wed, 12 Dec 2012
 12:50:13 -0500 (EST)
In-Reply-To: <20121212085507.GA32187@xs4all.nl> (Simon Oosthoek's message of
 "Wed, 12 Dec 2012 09:55:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6143D272-4484-11E2-94EF-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211373>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> This removes most of the ambiguities :-)
> Ack from me!

OK, as this is a low-impact finishing touch for a new feature, I'll
fast-track this to 'master' before the final release.

Thanks.
