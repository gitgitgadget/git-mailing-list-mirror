From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4203 (mailmap): stop hardcoding commit ids and dates
Date: Tue, 19 Oct 2010 23:29:06 -0700
Message-ID: <7vsk01wf65.fsf@alter.siamese.dyndns.org>
References: <87tyksd9er.fsf@meyering.net> <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
 <20101015061821.GE21830@burratino> <20101015075954.GA8557@burratino>
 <20101015171219.GC10204@burratino> <7vpqv95szu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	git list <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 08:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8SAx-0001d1-EM
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 08:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab0JTG3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 02:29:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160Ab0JTG3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 02:29:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76BBFE0E5E;
	Wed, 20 Oct 2010 02:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=n8DIkwSCK0gQ
	S8jIju/Sl/4ylUQ=; b=mRt/yP+BY52QMUbwCpp/AQ/0gwaCb6QXZA1QZRrCDAcZ
	xb8eqmAK8HO4XcZB0+Y9PcgKHHURXFYhbDkh3fe+dM4761UIRcgljo4j7lVgbhpr
	86kafc9BVG9ZH7yVKe0DECKz+mwPF3Cb/2883gNTMuJPaTP0Jo0Wj5+ToR1Wakc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X80w0v
	X1Jb6IQY5hRwkkpACljmmY+1DZDOsNM7urp4Kifz+ha3H3KBy4arRaVx3vSA98qb
	I5JEBPEprkU85wgz1bt2LHGkNRhAtWCAbx+rFPX6lXSmrQHu3jHuXMFBDeHTKWIP
	7rIxXvXaPSupYXm7+6o0RQfnIwVvZ3xeW7Umc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBF80E0E5D;
	Wed, 20 Oct 2010 02:29:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03139E0E5C; Wed, 20 Oct
 2010 02:29:07 -0400 (EDT)
In-Reply-To: <7vpqv95szu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 16 Oct 2010 21\:43\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B578024-DC13-11DF-9A41-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159395>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Here's a better fix.  Still no idea about the other failures =C3=86v=
ar
>> and Thomas were seeing.
>
> I saw intermittent failures too.  Thanks for the objid fix.

I found a way to reliably make this fail at test #7.

 $ sh t4203-mailmap.sh </dev/null

Without the input redirection, things seem to work Ok.

Still puzzled...
