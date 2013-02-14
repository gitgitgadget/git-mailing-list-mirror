From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Thu, 14 Feb 2013 15:17:37 -0800
Message-ID: <7vvc9uwkmm.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
 <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
 <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
 <7vtxpf341w.fsf@alter.siamese.dyndns.org>
 <CAH5451mMG-U8qETAy_6pRJLbtOjtAPhbapVA9RLbrrS2yy7rCw@mail.gmail.com>
 <7vd2w23k7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:18:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6847-0003ah-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 00:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251Ab3BNXRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 18:17:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934976Ab3BNXRm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 18:17:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADAF3C181;
	Thu, 14 Feb 2013 18:17:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgbuqrX+7T2nETkLU0leFhIT104=; b=QHx389
	nyPpg78PLGrE21AQCFTbCRzwEH6Wr2wFmj9+hZLdt3AnC1KMsOuvefAwUQtxxP8r
	G+FmrllWyJE9KHmrfqzs+v71Ui0gRtRhKMjuFNceXJ+scZeFdEL1a2eEAvr4xwSV
	k7LC/TQxv4f/3avyJuWMBHJnN6oKvh7hDmOVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FpPBE7T6DnraQy6KxQvAoKMwgkQ1FKwC
	EFF8Lz/SYD0omMeRRGDs1qD7sp67+B32DteJQXNOeS/oHBf8lLzeBuqrJfBEby6s
	jNoFErkQFt9rOwab33x5CQl6H7fyxCwmtTMu4lPNIQlL5sHgALUwmgc9QkE9LiFk
	+sw3n/GjJCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B33C180;
	Thu, 14 Feb 2013 18:17:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 146DCC17F; Thu, 14 Feb 2013
 18:17:38 -0500 (EST)
In-Reply-To: <7vd2w23k7k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Feb 2013 08:59:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B985B306-76FC-11E2-B3EE-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216337>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>>> If that is the change we are going to make, and if you can guarantee
>>> that nobody who is used to the historical behaviour will complain,
>>> then I am fine with it, but I think the latter part of the condition
>>> will not hold.
>>
>> Does the impossibility of asserting that no-one will complain put this
>> in the 'too hard' bucket?
>
> Basically, yes.  "Cannot be done without UI regression."
>
> It could be a Git 2.0 item, if you plan the transition right, though.

I have been staring at the patch again, but I do not think of an
easy way out without retraining the old timers to introduce this "if
we knew better, we would have done so from day one and the world
would have been a much better place" change.  If we were to have
this in the longer term, we would need a proper transition plan,
similar to the one we devised to change the default used for a lazy
"git push" (and "git push $there") from the traditional "matching"
to "simple" at Git 2.0 boundary.

The transition would go like this:

 * Introduce "git add --ignore-removal" option in the release after
   the current cycle (a new feature is too late for this cycle):

   - when "git add <pathspec>" is given without "--ignore-removal",
     give a warning about upcoming default change, and advise people
     to use either "--ignore-removal" or "--all" option, but behave
     as if "--ignore-removal" were given.

   - when "git add --ignore-removal <pathspec>" is given, only add
     additions and modifications, just like the current behaviour.

   - obviously, "-u", "-A", and "--ignore-removal" are mutually
     exclusive.

 * Run with the above for a few releases.

 * Change the behaviour of "git add <pathspec>" without "-u", "-A"
   nor "--ignore-removal" to error out with the same warning and
   advise.

 * Run with the above for a few releases.

 * At Git 2.0, change "git add <pathspec>" without "-u", "-A" nor
   "--ignore-removal" to behave as if "git add -A <pathspec>" were
   given.

At any point during the above transtion, "git add" without any
pathspec will not change its meaning; it will stay a no-op.
