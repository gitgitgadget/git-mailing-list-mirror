From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 01 Jun 2012 13:52:16 -0700
Message-ID: <7vhauu21rz.fsf@alter.siamese.dyndns.org>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org>
 <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org>
 <7v4nqu3lhy.fsf@alter.siamese.dyndns.org> <20120601203836.GB19987@thunk.org>
 <CA+55aFyqN2OJkSKVLERtMr-P6OKWEfjrS6eP8OtDyoZB0mmR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:52:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaYpy-0005Zu-7o
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab2FAUwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 16:52:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab2FAUwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 16:52:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1509E9FE1;
	Fri,  1 Jun 2012 16:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pFisiRUy+As9
	Z11Mgkv6bkLJsJk=; b=gfZtZduceM0+zah0sVP9zlm8GSy9zx72P1XbX+v10bNP
	fTHI3IKqtmMda6QG4TSCJxRTrqsoTiMBSVZv7F12gWCzD32cACEJiRYotnCsaBtr
	Dsj/OUPFnO4itclHSF8SbfdbXZoUgwk4vXPtaIV+YiYqhGG3YIbf/jyejSAMKug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vit9bc
	hXioA8wWlAnvzzUc73C0Z0sBGdzPYMGfTn4EBGzC0KjBcSbAcP6Z8dYa1sW/7gpM
	ypF7H4cOVUsy9JnvfXkgCYZk3xp3ASW0FK7iLi4CGKH7OBq3dY+OA/CD4hQw3Tbx
	0qNZkeGXeKFKNxI15cY70W1vm/hCpi/LDyV/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CA739FE0;
	Fri,  1 Jun 2012 16:52:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 946969FDF; Fri,  1 Jun 2012
 16:52:18 -0400 (EDT)
In-Reply-To: <CA+55aFyqN2OJkSKVLERtMr-P6OKWEfjrS6eP8OtDyoZB0mmR3w@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 1 Jun 2012 13:43:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD238B7A-AC2B-11E1-A1E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199023>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 1, 2012 at 1:38 PM, Ted Ts'o <tytso@mit.edu> wrote:
>> One other thought. =C2=A0One of the reasons why I used "dev" and not
>> "ext4_for_linus" in my git request-pull command line was because tha=
t
>> several months ago I had created a branch called ext4_for_linus, and=
 I
>> hadn't gotten around to deleting it, so I figured I'd just use "dev"
>> instead, since it was non-ambiguous.
>
> You can always just use "tags/xyzzy" to disambiguate..

Not only that, the "look at the ls-remote output and guess what you
are teeling the recipient to pull" code gives tags/ext4_for_linus
even if there is not ext4-for-linus branch; if I recall correctly we
did this on purpose so that older git that did not DWIM "git pull
ext4_for_linus" to look at targs/ext4_for_linus.
