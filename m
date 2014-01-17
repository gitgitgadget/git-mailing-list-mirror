From: Junio C Hamano <gitster@pobox.com>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such ref: ''" for branches without an upstream
Date: Fri, 17 Jan 2014 12:02:32 -0800
Message-ID: <xmqqeh46wf53.fsf@gitster.dls.corp.google.com>
References: <52D8827E.3060007@fb.com>
	<20140117022152.GB12444@sigill.intra.peff.net>
	<xmqq8uuexwp7.fsf@gitster.dls.corp.google.com>
	<20140117192619.GP7608@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Siddharth Agarwal <sid0@fb.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Fcn-0005Kx-GE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbaAQUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:02:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300AbaAQUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:02:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B24762AF8;
	Fri, 17 Jan 2014 15:02:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t0ijOOyoURmOUqbh2vZNKXJXAJU=; b=hTJspI
	7yoklTXH8oOJlQTzqySSYb8Wp87y0XrPm4axT5FCXRpDq8XgPZa1SYLyx1eAfZ84
	FwtofWEhLEfV1EcL2/M9tP0wUTUlGomhLoY4JpFqbUUU/5WabC8klQv84xMj23rX
	3vWzDXesEVVME7T9JWn7dy8hj9AlJtJ8CdSdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oj43tPAh0ewAYHAgQA05mHgZjLLAz2v1
	sVxFbTzB+fXM4BNSpubpUtJYZGzcEEFk119nE2mefioX7pmXAMTFtNJqsArJIRn2
	Iv/vUA5Ox9zaE7Tg1fqH9v2h2w6vOpO57e9yUT9+INhnfKmK8Oap5s7vk7ZJHgtx
	piiIkTXANQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E4C62AF7;
	Fri, 17 Jan 2014 15:02:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E02F62AF0;
	Fri, 17 Jan 2014 15:02:35 -0500 (EST)
In-Reply-To: <20140117192619.GP7608@serenity.lan> (John Keeping's message of
	"Fri, 17 Jan 2014 19:26:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EDCDBD2-7FB2-11E3-B9B8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240622>

John Keeping <john@keeping.me.uk> writes:

>> Perhaps something like this is needed?
>>  ...
> Either that or "2>/dev/null" like in the original, yes.

Ah, that makes sense.  I see you already followed-up with a patch,
so I'll pick it up.

Thanks.
