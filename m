From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Thu, 20 Sep 2012 21:34:27 -0700
Message-ID: <7vobl0804s.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <7v4nms9yja.fsf@alter.siamese.dyndns.org>
 <7vsjac8j52.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-28Lf8_AO3g8SkiemAhT5OzU=AU+c6rUWB0yPWj-kF2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 06:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEuwr-0003Au-D5
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 06:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab2IUEeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 00:34:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab2IUEea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 00:34:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF4494BB;
	Fri, 21 Sep 2012 00:34:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ACMgfhizpkCMADrH66WHktR0fy0=; b=RKochq
	RIlvUPskxBGLh/hT/pbvBzE/UQ7dBbWHMZvw3RTnBH8piWSs1Xb6lzHzjBJ2HXPv
	CS+/DZhsRP6rmBe7T19Mzm77f/+hZpBOnBkIeEX5eHasB9baDwd0nfKKlmel0fOT
	A+RvzSvJQ/58cOqZA9nY49QoUygcnHIll55N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+9R91VOvZzAJWwlRBYiiNvIHdqi1Nvb
	VU0gzLJdcoptP4MPDdCpndvw+2jhnyYimqmQvjtgcGPOs5iLDO+jcXoj9g4EyGzH
	F5EHo+7Lr1g+diKYHfna0j5FTer2GTrlGcsAn5MzDQz8Bn9YZ+PnfAm1ibV04YfL
	q9MDZMn8Rwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9FF94BA;
	Fri, 21 Sep 2012 00:34:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C857F94B9; Fri, 21 Sep 2012
 00:34:28 -0400 (EDT)
In-Reply-To: <CAOkDyE-28Lf8_AO3g8SkiemAhT5OzU=AU+c6rUWB0yPWj-kF2w@mail.gmail.com> (Adam
 Spiers's message of "Fri, 21 Sep 2012 00:45:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A17C1E6E-03A5-11E2-B6CE-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206103>

Adam Spiers <git@adamspiers.org> writes:

> Sure, I can do that, but shouldn't this convention be documented in
> SubmittingPatches?

People must have learned this by imitating what senior contributors
send to the list, but the "[Subject] area: title" thing does not
appear in that document.  I agree it should (patches welcome).

>> I saw quite a few decl-after-statement in new code.  Please fix
>> them.
>
> Again, I can do that no problem, but again this convention is
> undocumented and I am not psychic.

Yeah, when there is no code that does decl-after-statement, with the
"imitate surrounding code" rule alone, I agree that it is a bit hard
to tell we do not allow it (as opposed to seeing a construct is
often used and assuming that the construct is permitted, which is
much easier).

> I see that a patch was provided
> 5 years ago to document this, but was apparently never pulled in:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/47843/focus=48015

I just read SubmittingPatches again and looked for 1a as found in
that patch, and it is there.

> I also see in the same thread that a patch to add
> -Wdeclaration-after-statement to CFLAGS was also offered but never
> pulled in,

There is no guarantee your CC would understand it; you don't even
know if it is a gcc in the first place.

> I'm also curious to know why this convention exists.  Are people
> really still compiling git with compilers which don't support C99?

See 6d62c98 (Makefile: Change the default compiler from "gcc" to
"cc", 2011-12-20).
