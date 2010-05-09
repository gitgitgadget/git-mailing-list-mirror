From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sun, 09 May 2010 10:45:35 -0700
Message-ID: <7v632x9dfk.fsf@alter.siamese.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 19:48:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBAby-0000bj-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab0EIRqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 13:46:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0EIRqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 13:46:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25699B2348;
	Sun,  9 May 2010 13:46:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tvD8VbYFV8AswiLE4p9K5BnvlQ8=; b=FwdFzs
	eNxZ5omEsMw6EN5liTGQkeHTKwmZOGEoJylCRzGEh2b2IbIqNsUw/qBFgr9Opisr
	i5AEpX5QROq3L8rv8jBiKJYQFja+Fdd0ClrjM9OLcBdi8zZKYqSeLDrzxXKYqXYF
	3ogotlhz5JJSb349D2ABYwjsCs/oW5dXoIsDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HsS3yZlV8ROmdH9vWM4XjJVD0ILNoolL
	eqc7XuXatM9zOXMZhNGK0AeR0T3yhdwMJrlGFDWLH5ILRS1s8XiLP8blPYVk2bTv
	AMeNO7PTE7tpm6D+5WI+nQn7OS7ZSLfwf05cXFhygre//rIIE5asxvhIhWeqs2C0
	e327QmWd9Dc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76C84B2344;
	Sun,  9 May 2010 13:46:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB51EB2343; Sun,  9 May
 2010 13:45:47 -0400 (EDT)
In-Reply-To: <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> (Eyvind
 Bernhardsen's message of "Sun\, 9 May 2010 12\:42\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAF80C26-5B92-11DF-ADED-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146732>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> My user interface would have been:
>
> - an attribute "eolconv" that enables or disables line ending conversion
> - a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
> - a config variable "core.localeol" that decides whether LF or CRLF is preferred

I am puzzled about this second item; what is its type and what is its
purpose?  If it is to allow project-wide default to be specified, then
isn't having "* eolconv=true" in .gitattributes a much better option and
is already supported by the first item?
