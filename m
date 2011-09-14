From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 11:29:28 -0700
Message-ID: <7vehzjugdz.fsf@alter.siamese.dyndns.org>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eduardo D'Avila" <erdavila@gmail.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uDO-00064K-9E
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab1INS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:29:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261Ab1INS3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:29:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5624E27;
	Wed, 14 Sep 2011 14:29:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MXRM43/a7n6gcxvETsIQ5+POTzs=; b=eUk8Un
	TU2RfAJVH55dQCR2bn/4sv1t/s4XAPqBi5fNqu4pTzV3hC0if98hUFtvBVqU/Egm
	AikOfoF4Q6fpFaavmTKvTuG4LOf2QGdysdHSa34YRnjsE2vkxxqciP35nHDPEv5D
	ZfF+hlIcBHpiH2oLKXbIFijv9bTgGdbc1CzQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ndrhMJRnqMweeNyRo12X9BH1qB/39j7C
	vg9Gd4inxoUxvIK227WFRMXbxt6ituNiwttkSE5r41nfs6dL4b1DQ5qieGWfJdTc
	I3FssXTe7xDBOHHibyiqsnne9C1ePMwRTzrYzG/lTKepgVvyYFhSYxL8YCZYKHhX
	Op0Fdsqu0zg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3DA84E1C;
	Wed, 14 Sep 2011 14:29:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6348B4E1B; Wed, 14 Sep 2011
 14:29:32 -0400 (EDT)
In-Reply-To: <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 14 Sep 2011 15:16:32 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D786516-DEFF-11E0-A539-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181376>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 14 September 2011 13:05, Eduardo D'Avila <erdavila@gmail.com> wrote:
>> Hi,
>>
>> I have being using Git for some time now and I am very satisfied with it.
>> Now I'm considering giving back by helping on its development.
>> Is there any bug listing which I can check if there is some point I can help?
>> Any suggestions on other ways to help are also welcomed. :-)
>
> Hi Eduardo, as stated in the README,
>
> The messages titled "A note from the maintainer", "What's in git.git
> (stable)" and "What's cooking in git.git (topics)" and the discussion
> following them on the mailing list give a good reference for project
> status, development direction and remaining tasks.
>
> Additionally, I think the README should include something like
>
> If you are looking to contribute to the project, a good place to start
> is http://git-blame.blogspot.com/p/note-from-maintainer.html and in
> Documentation/howto/maintain-git.txt

I am moderately averse to hardcoding that URL that is guaranteed not to
survive the maintainer change in our README file. The howto/maintain-git
document mentions the periodical "A note from the maintainer" posting to
the list that has the same text, which is a more appropriate reference.

As to contributing to the project, right now, I think we have enough
people who want to write code and documentation for Git, but what we lack
are bandwidth to (this is not meant to be an exhaustive list):

 - review the patches on the list and help perfecting them;

 - distilling random wishes from the end user community while winnowing
   chaffs that are unrealistic or do not fit well with the grand scheme of
   things, to come up with a concrete proposal and a patch series to move
   the discussions forward in a productive way;

 - "on boarding" new contributors, helping them to become a useful member
   of the community, teaching how to write a good bug report and how to
   sell a new feature (i.e. "the perfect patch");

 - dig list archives to point people at age-old discussions to non-issues
   that have long been resolved to squelch noise; and

 - remind original submitter, people who were involved in the discussion,
   and people who should have been involved but who weren't, of a worthy
   but stalled topics from time to time.

The first two need to come from more experienced folks whose judgement I
can trust (iow, not a newbie task). Others are "project secretary" tasks
that can be helped by anybody who is good at tracking things, perhaps
except for the last one that needs a good taste when judging which topic
is worthy of reminders.
