From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 10:57:50 -0800
Message-ID: <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
 <20130120125838.GK31172@serenity.lan>
 <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
 <20130120152857.GM31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx05v-0005iT-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab3ATS5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:57:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214Ab3ATS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:57:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE70FA5DA;
	Sun, 20 Jan 2013 13:57:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zgi+p/YpTJhwMXIi2HxQ12F1jDg=; b=kzOHhr
	/8yL/wbyArMNxvesr9aJ0hmz/rxhSTpWjrYKIQ8Jeb8aM0/bpShJ5mr4cWPnAWK4
	ezX7nPzSw1DxRxUw7HNW+owZ+vI3JtA3cpWHOF6SQLMOqKIxqI4ikPae7knj+sY4
	O5fycEMAodHgwZVaOZkTL2OBxOiupDoh984ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hjc9izsMjWBl8rUnP88UYXZ/qtU2SBbf
	8B3YHkywXJGbgKRIkGXKgrOS5qTRr1pdYq9nZ5Gi8azxNSosd9nNYbbU6e27NinS
	EBwnozjD0owyKW2D6dsecCleEEr6MSgF2jpuNYgtLph3m6hXZhjI/vjj5celwIto
	fSqJ3KZRSLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28CFA5D9;
	Sun, 20 Jan 2013 13:57:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C9ADA5D7; Sun, 20 Jan 2013
 13:57:52 -0500 (EST)
In-Reply-To: <20130120152857.GM31172@serenity.lan> (John Keeping's message of
 "Sun, 20 Jan 2013 15:28:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC17658-6333-11E2-BC49-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214033>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 20, 2013 at 09:22:03AM -0600, Chris Rorvick wrote:
>> On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
>>> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>>>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>>>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>>>> to Eric (fixes revision map.)
>>>
>>> Did you post the fix for the revision map publicly anywhere?
>> 
>> It's in Eric's repo and included in version 3.8:
>> 
>> https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6
>
> Thanks.  For some reason I thought the fix would be to
> git-cvsimport-3.py.  Obviously I should have read more carefully.
>
> Sorry for the noise.

This is not a noise, though.

Chris, how would we want to proceed?  I'd prefer at some point to
see cvsimport-3 to be in sync when the one patched and tested in
Eric's repository is proven enough.  Will Eric be the gatekeeper, or
will you be sending patches this way as well?
