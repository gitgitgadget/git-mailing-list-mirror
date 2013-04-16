From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb/INSTALL: Simplify description of
 GITWEB_CONFIG_SYSTEM
Date: Mon, 15 Apr 2013 21:36:08 -0700
Message-ID: <7vobdfnlc7.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412064953.GB5710@elie.Belkin> <7vy5cnd0m4.fsf@alter.siamese.dyndns.org> <516888C0.90501@gmail.com> <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxcu-00058S-E2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab3DPEgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:36:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3DPEgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:36:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CA9310D5E;
	Tue, 16 Apr 2013 04:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtHpZ8HHZW5ubjO+X3bEAYqmpz8=; b=bQ+YHL
	y0iy2SxH4sRfdevhFNiLQXqLfDtXJ8w0z0AE43iHjVwJMF3y10ci1A4FPbJNBFzn
	Hfgfp3vRED3w9YntIVe2Tqi5eZTYEwxE7GV7e5XWQKbscbMIgY/AESSPRN05CDi+
	LEp2Sm3+TAgr/sLQLFSUum8eVHMxAWJIYV1hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXwPhvkQ4gTDTK+GENf5ZQs5BJv2o9Om
	yiCJypxkhkGufhWFSgDL+c+Smk5wFxj2nJwPIOGGym5mRYIt4lCdI5nc6BuF/iVf
	OvaQL+aoV4BuhlQQbdflmILznRuwAokQLglMZbZdnpA3jPnTUSYCW8bUGjdjkVmO
	fOuDGL1oLcI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105C510D5C;
	Tue, 16 Apr 2013 04:36:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C5FD10D59; Tue, 16 Apr
 2013 04:36:10 +0000 (UTC)
In-Reply-To: <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com> (Drew
 Northup's message of "Mon, 15 Apr 2013 23:10:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29876718-A64F-11E2-9D6D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221362>

Drew Northup <n1xim.email@gmail.com> writes:

>> +  Note that the GITWEB_CONFIG_SYSTEM system-wide configuration file is
>> +  only used for instances that lack per-instance configuration file.
>> +  You can use GITWEB_CONFIG_COMMON common system-wide configuration
>> +  file (normally /etc/gitweb-common.conf) to keep common default
>> +  settings that apply to all instances.  Settings from per-instance or
>>    system-wide configuration file override those from common system-wide
>>    configuration file.
>
> That's the point of explaining SPECIFICALLY why the then current
> behavior wasn't being replaced, and this other mechanism (which would
> otherwise have no obvious reason for existing) was being introduced.

In order to just pick and use the more appropriate one (or a useful
combination of the two), a clean description of what each of them do
without historical cruft is more readable and useful, isn't it?  I
would expect that most of them who are newly configuring a system
would pick COMMON one and override per instance as needed, without
touching the SYSTEM one (fallback default) after reading the above,
and that is what we want to happen.

Do you think sysadmins need a history lesson to understand why there
are two different possibilities?

For example, bash reads some but not all possible configuration
files. I would expect .bashrc to be read even for login shells after
reading .bash_login; alas, that is not what happens.  The manual
does not apologize that the authors now know better and understand
that it is a stupid behaviour.  The order the rc files are read is
just described matter-of-factly, and it gives sufficient information
without unnecessary backstory.

I think the new text conveys the necessary information to the
intended audience with more clarity without the history lesson or
the record of your past frustration. Am I mistaken?
