From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Tue, 27 Nov 2012 23:01:20 -0800
Message-ID: <7vhaoai533.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
 <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
 <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
 <7vehjelizc.fsf@alter.siamese.dyndns.org>
 <CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
 <7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
 <CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com>
 <7vpq2yihaq.fsf@alter.siamese.dyndns.org>
 <CAMP44s23FfxQG6v+dfRGWHzxpWZ5BSGpAm=8Q8Bmj04tDwmwKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:01:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdbeN-0005PT-Au
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab2K1HBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:01:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2K1HBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:01:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9085C6D2D;
	Wed, 28 Nov 2012 02:01:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kB1jLDQnUfihdWlUTRtDjF4ZXow=; b=LfV9kT
	f4QArYSwChhgWPu8EhTEuS7FyJH5/dDjuH0R1CVBhCYINhJzp8tbwWsgJ62yMMgC
	vrLAUVcEn92BXtEJ2wndm7pn7pJpjxcvuIGdFvtjFR3piPrIn8RDHAz//Hsu54HK
	9JFbnoSJ71NLXJWl+zrWfQxIKO0AOPLV44LOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MCrLCVad+5/WZ07jcxWnjTfAXbWbP4t1
	NtGMu3lQyI68Y0M19IJymvVYV/46TcZRIuJXfLIDF0HOZeTe3cIoUZSQJCxyS7+/
	5gy3etGByCY2K7GkYLarGsEs3jHjVtiRoBa+wE3j4eGexQab3cktVatokR3hwyRy
	8ljvEWW9zS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DAE86D2C;
	Wed, 28 Nov 2012 02:01:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D35B16D2B; Wed, 28 Nov 2012
 02:01:21 -0500 (EST)
In-Reply-To: <CAMP44s23FfxQG6v+dfRGWHzxpWZ5BSGpAm=8Q8Bmj04tDwmwKw@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 28 Nov 2012 04:05:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A8F21DA-3929-11E2-B5A2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210709>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> People who have been bitten by bugs from *your* tree or versions in
>> 'next' do not count.  When I said "no existing users", I was talking
>> about the end users who need rock solid stable "releases" because
>> tagged versions are the only ones they use.
>
> If users you call "fringe" have noticed these compatibility issues,
> chances are your "existing users" are going to catch them as well.

There seems to be some misunderstanding.

I have never called them "fringe"; they are "early adopters" who are
expected to be capable of "git pull" to pick up fixes from
between-releases trees (or "git am" patches from the list) and
rebuild their Git.  

We cannot expect that from the real end users (who do not exist yet,
luckily) who only follow tagged releases.  Hitting them with bugs we
need to fix after the release is not "letting them notice and
report", but just "irresponsibly hurting the end users".  "Letting
them notice and report" is what "early adopter" population who run
'next' are for.  Quality expectations between these two populations
are quite different.

> ... That being said,
> I don't use remote-bzr really, and I don't know how many people have
> been using it, so I have no idea how ready it really is. ...
> ... Either way it's doubtful there will be a v4

OK; thanks for clarification.  If you are not using it actively, it
probably is a better idea to proceed with more caution, as low rate
of update necessity does not directly relate to maturity of the
tool.  I'd feel better to cook it longer in 'next' to recruit early
adopters so that we can hear positive feedbacks (or negative ones
that can result in fixes to whatever is still uncovered, if any).

I hate reverting anything from 'next', but for the above to work
smoothly, it seems to me that reverting the merge of v2 and queuing
v3 plus remainder sounds like the best course.

> I'm confident about remote-hg though.

Meaning unlike remote-bzr, at least you are using it more actively
(or you know people who are), right?  I've queued the two patches
(out of four) from you today, so we can merge it to 'master' before
1.8.1-rc0.

Thanks.
