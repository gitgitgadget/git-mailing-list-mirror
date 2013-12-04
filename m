From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 04 Dec 2013 12:28:53 -0800
Message-ID: <xmqqwqjkjr7e.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-2-git-send-email-krzesimir@endocode.com>
	<CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
	<1386171977.2173.23.camel@localhost.localdomain>
	<CACPiFCJON33dz64qSZDnrCo8hbVpbxk7k65xmW1oBiZ4Muzcbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	Jakub =?utf-8?Q?Nar=C4=99bs?= =?utf-8?Q?ki?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoJ49-0004kb-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab3LDU25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 15:28:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3LDU24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 15:28:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1717A56FBF;
	Wed,  4 Dec 2013 15:28:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4p982DOzNpsC
	bzSX19yvCSn+fNw=; b=LPxomdZg+JtjFvkRa3amzY3bKO94ayEFj6yhmJgFS/23
	aFezv6hQ5B/97dEy+Lqxk/BicHI36Q9fRBR+pSZtr7uMvpcVW7N9YbzBK6ekhRNf
	C7LEXDyzzrs6b48c+dTNqdHKA32pnW+9YaIEDHm+r7umqi+XnbePqMwBbEwTWvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fQ8uPG
	AWviWXvnQQ0i/iceSBLFY6B1DuufixOHV/f5ICxRlPBZ1lQxGYQ8W4p8UW1klify
	i4urnH7HT9xFbGCT6UUM7LMOAo4SULWGeZFBhWKW8ABHcJ95Y2fmhLHHpUC8G1Yg
	lGdlYn19VwEW0NrLkCE5S8vDCGENpmbh1daZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03F2C56FBE;
	Wed,  4 Dec 2013 15:28:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43A8756FBA;
	Wed,  4 Dec 2013 15:28:55 -0500 (EST)
In-Reply-To: <CACPiFCJON33dz64qSZDnrCo8hbVpbxk7k65xmW1oBiZ4Muzcbg@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 4 Dec 2013 11:19:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B24C5BE6-5D22-11E3-B7F5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238810>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Wed, Dec 4, 2013 at 10:46 AM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:
>> On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
>>> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode=
=2Ecom> wrote:
>>>
>>> > So future reader will know what does it mean without running "per=
ldoc
>>> > perlvar".
>>>
>>> Hmmm... shouldn't future reader know it anyway?  It is not that cry=
ptic.
>>> I'd say it is idiomatic Perl.
>>
>> It's plainly obscure. And I think it is not that often used -
>
> It's classic Perl.
>
> Perhaps you'd want to "use English;" and call it
> $INPUT_RECORD_SEPARATOR in a patch titled "Make things readable to
> non-Perl natives".

Hmm, but do we want to see "use English" there in the first place?
