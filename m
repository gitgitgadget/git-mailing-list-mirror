From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 resend] gitk: Use an external icon file on Windows
Date: Thu, 09 Aug 2012 08:54:43 -0700
Message-ID: <7vmx24oybg.fsf@alter.siamese.dyndns.org>
References: <500CEF06.2030501@gmail.com> <5022CDFC.4090900@gmail.com>
 <7v628trsry.fsf@alter.siamese.dyndns.org>
 <CAHGBnuOKsPJoRADfukCJ8abSVVKUy5vbuh18S7UD8rLScVq=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 17:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzV4h-0006Cm-K2
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 17:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031466Ab2HIPys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 11:54:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031456Ab2HIPyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 11:54:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 576E05A02;
	Thu,  9 Aug 2012 11:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5BsG7EPGApcE1iJFZyacSPw8Lxc=; b=juStnE
	UF2SWo+Erm7pwnv218mBxjZzHXlq/Z7cv/rJuDkwXOnJz4gwOSyLPWsofKwMJ8Vo
	Ltt+8AVqP2geP50AhGIYChu/EUNCQssR26sGryqqaeMkAhQdlU87Io/9xczp2Kcy
	b4sgy2yynw1lHpcMFtg0nQHQ+9623ma7EscA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZr+edjmbdfjC5BjGKquy2BcHHWQ8zkL
	xR4sfd/Fc1+eonP5oCybFze5XOjYE/nUiPIr58zPsJXNZxh0vUbA2dgJXQkv8ZTS
	73tXMyu38bDN1FkxH24cLx6CiJ42Q2q5QUTGYWWOfYZtub74p9XCu6EVnKKOL14L
	XfLsknHVWmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448E55A01;
	Thu,  9 Aug 2012 11:54:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CB7259F7; Thu,  9 Aug 2012
 11:54:44 -0400 (EDT)
In-Reply-To: <CAHGBnuOKsPJoRADfukCJ8abSVVKUy5vbuh18S7UD8rLScVq=GQ@mail.gmail.com>
 (Sebastian Schuberth's message of "Thu, 9 Aug 2012 08:54:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89D8DC2A-E23A-11E1-BB76-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203160>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, Aug 8, 2012 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Forwarding a misdirected patch to the maintainer who is free to pick
>> or ignore.
>
> How am I supposed to know if a patch has been ignored as an oversight
> (in which case I would resend), or because the maintainer decided not
> to include it (in which case I would not resend in order to not annoy
> the maintainer)?

By hearing from Paul (or asking directly), perhaps?

>> Personally I am negative on it (nobody on the list asked for the
>> "new" Git icon as far as I recall), but my voice on this counts just
>> as little as others.
>
> I guess most patches on the list come in unasked, so I cannot follow
> your negative attitude because of this.

Many patches do come after a thread of discussion, and at the end of
such a discussion I do not often explicitly ask "yeah, that sounds
like a good way to go, please make it so", so technically it is
correct that many patches come unasked, but my "nobody asked for"
was not about your patch.  It was about the "new logo".

  Cf. http://thread.gmane.org/gmane.comp.version-control.git/197082

The site may be called "official", but Scott exercises fairly large
amount of editorial discretion without community input on occasions,
and because he is such a nice guy, we let some questionable things
go from time to time.  Some things on that site are not always the
community concensus, not necessarily in the sense that Scott decided
against community concensus but in the sense that the community did
not feel a need to even have a concensus and Scott chose to go one
way.  The new logo is one of these things.  Some in the community
may not be enthusiastic about it and prefer the original, but they
do not feel strongly enough to send in patches and gather the
community support to "fix" it.

And that goes both ways.  If the logo of the "official" site is not
something so important that git-scm.com can change without gaining
community consensus first, then it equally is within the editorial
discretion of individual git package's maintainer to keep using the
original not the updated logo.
