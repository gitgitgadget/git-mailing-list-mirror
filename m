From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
Date: Wed, 17 Apr 2013 18:44:27 -0700
Message-ID: <7v61zkd344.fsf@alter.siamese.dyndns.org>
References: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org> <516888C0.90501@gmail.com>
	<CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
	<7vobdfnlc7.fsf@alter.siamese.dyndns.org>
	<CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
	<516D4359.2070501@gmail.com>
	<CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
	<20130416222600.GG29773@google.com>
	<CAM9Z-nkG0YbudBnhcu6du824aEcXRVLCx406=kVbG83g3rFPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 03:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USdty-00010D-MH
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 03:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993Ab3DRBoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 21:44:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964827Ab3DRBoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 21:44:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A699EF00;
	Thu, 18 Apr 2013 01:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EG3qKvpwclrPWlvnLWLdKCWRkc8=; b=d8ZP2Y
	TtPoSPnRAWqhR18ej8GCNtQ5SG2Fj80SeBDxuKXRRykd/c1Z8LE7qr6hBlwcQ2gv
	JTjydzgV9itgQ86HyTLrIGGUnF/GZ/LgDWvn5mWXJbpsjm6ClFylJ/+WEGon+7It
	GqhplUzG7R8aMXfdWR2biTuAx88sqmvE7/Lnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iuD6SHSzyvtKBSKwjJTaZwh4snYq3HHd
	ZqEfRXJEfLfT5fuT4LfmDkjkLaAObkm3j/X0ntfCJ5kf3k6gjhKJ5+f9VUMlgkKJ
	XcfvzBZmE6i5sikQNBY5nT0Q/hwlAbjgTOSyhW2mIBzLEZRUeuJeLdTzSNKSld9F
	W8Ns0IHByak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115E4EEFE;
	Thu, 18 Apr 2013 01:44:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56F0FEEFB;
	Thu, 18 Apr 2013 01:44:29 +0000 (UTC)
In-Reply-To: <CAM9Z-nkG0YbudBnhcu6du824aEcXRVLCx406=kVbG83g3rFPdQ@mail.gmail.com>
	(Drew Northup's message of "Wed, 17 Apr 2013 21:00:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 827717F8-A7C9-11E2-9C03-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221598>

Drew Northup <n1xim.email@gmail.com> writes:

>> That makes it sound like the "per instance overrides common overrides
>> built-in" cascading is what is unusual and what we need to apologize
>> for.
>
> I don't think were apologizing for anything. It is helpful to say "we
> do some things differently here and don't plan on changing for a very
> important reason.

My biggest resistance against this whole thing is that word
"differently".

It really depends on who reads this document.  For some, it may be
different.  For others, it may not be unexpected at all.  "We do
things differently" may help the former but I do not want the latter
to try to find "difference" that does not exist elsewhere and get
confused.

>>
>> +BUGS
>> +----
>> +Debugging would be easier if the fallback configuration file
>> +(`/etc/gitweb.conf`) and environment variable to override its location
>> +('GITWEB_CONFIG_SYSTEM') had names reflecting their "fallback" role.
>> +The current names are kept to avoid breaking working setups.
>> +
>>  ENVIRONMENT
>>  -----------
>>  The location of per-instance and system-wide configuration files can be
>
> I don't disagree with this, as some would consider the naming to be a
> bug, but after having been given a good schooling on the git list a
> while back as to why it is the way it is I'm hesitant to label "has
> history" as a bug.

BUGS section being traditionally where you would throw this kind of
thing, either a bug, non-bug, or wai-but-some-may-not-agree, I think
this is a good description.
