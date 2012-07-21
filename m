From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pushing branches
Date: Sat, 21 Jul 2012 12:33:40 -0700
Message-ID: <7v7gtwucx7.fsf@alter.siamese.dyndns.org>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
 <7vhat2toz8.fsf@alter.siamese.dyndns.org>
 <CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
 <CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
 <CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
 <CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
 <CACnwZYdUzk74znPs4F+xz3haA3QhA9-DbR3mWWEVMfnztp-oCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 21:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsfR1-0007Yp-Ao
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 21:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2GUTdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 15:33:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab2GUTdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 15:33:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613E78F31;
	Sat, 21 Jul 2012 15:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1nsqSIHEaoJd1tINnpMzkC7Lxg4=; b=PqH4ue
	yRsn/Pm65HH6lUA53aoq2aIimawmxU5EUaYRrJoS3VZ4oMYn9U0Py3hEQ8Y0oaL0
	+UG+VrSvou+uYeyYQImsr5IahZK9fmCg09vRGkEMdFd2YMBiA3Api/kiAetyFz2c
	OieyHTFhvYcWTSqDTjbxhdxaDXJU8y7L79A2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gZbE8sAaYO4+2XtuWECcor2jeCI87B8O
	nkiVUjKiiW2RrUxK9NouXq8evzvMLXV724ubhWwCV6tsZHPhaiV2qAns78B4eBT3
	tlBlYrPjt1cyxAfVs34das1XfTBPd4Rq54AJq6IWr6dktyCTqG6a6GjRG5n5F6GZ
	aBAaoWzZC0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EDDC8F30;
	Sat, 21 Jul 2012 15:33:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A84848F2F; Sat, 21 Jul 2012
 15:33:41 -0400 (EDT)
In-Reply-To: <CACnwZYdUzk74znPs4F+xz3haA3QhA9-DbR3mWWEVMfnztp-oCA@mail.gmail.com> (Thiago
 Farina's message of "Fri, 20 Jul 2012 23:10:56 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA49EFD2-D36A-11E1-98C8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201830>

Thiago Farina <tfransosi@gmail.com> writes:

> Do'h, now I can see the idiocy that I was doing.
>
> If I'm understanding this better,
> $ git push origin master
> tells git to push to remote origin, the contents of my master branch.

Yes, add "to the 'master' at the 'origin'" at the end of the
sentence and you are perfect.

> And then,
>
> $ git push origin feature-work
> tells git to push to remote origin to push the contents of feature-work branch.

Yes.

> Hence does not make sense to ask git to do "push origin master" while
> inside feature-work branch.

No.  As long as you know your master is ready and suitable to be
published when you ask "push", the command perfectly makes sense; it
does not matter on what branch you are on.

You may say

	$ git checkout master
        ... work work work ...
        $ make test
        ... ahh, perfection! ...
        $ git checkout -b feature
        ... let's build a bit more ..
        ... while I am having fun, let's not forget to push the
        ... part that is already solid out
        $ git push origin master

and that is perfectly fine without "git checkout master" before
pushing (and "git checkout feature" after to come back to what you
were doing).
