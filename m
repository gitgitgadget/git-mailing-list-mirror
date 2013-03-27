From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS
 X
Date: Wed, 27 Mar 2013 07:43:56 -0700
Message-ID: <7vfvzgrjgz.fsf@alter.siamese.dyndns.org>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
 <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
 <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
 <CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
 <CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
 <CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
 <20130325101318.GA31409@yoda.local> <7vtxnzw3wu.fsf@alter.siamese.dyndns.org>
 <CAEBDL5Vx0vjAKUeFrXgpx7mYxk8B+OQC5yrEii9RMP-5-Sjhsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 15:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKraY-0006SR-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab3C0OoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 10:44:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3C0OoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 10:44:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EB17ABDA;
	Wed, 27 Mar 2013 10:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8RoZr2ZKUWIsHXAlSGlGdcYQWp8=; b=VQ8XL0
	A4XusgO3nbd3D0vzu0HcOa/S1ZjapjeK6g/FaFVgNpSzdVVBP8YDfHK5qBGzMOEl
	ZdgNvP12H5yMdHzDG7SSD4tk4TmB7GB7C14E/aC0pcmje/57saSNQtp785YTHYux
	p9zOVYTqd76ed0b/mWcVjPLlqf3a2AJkCNW0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPSPpctEy0Vn9TTvjmSgJsiPuox65Du5
	zeyelcmxbQbprUssmuFyPJDBa0b0EZi44w4ibSM/y5mad5nGX4tC3SLLLcvHmLg+
	YCz5T6eNHYnH7HEKVGEWZ1n8jFSR6CduMvgdVrT1K5ULIrIue4+A7nl3ViPXGVtj
	UVBADCA7VOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5300DABD2;
	Wed, 27 Mar 2013 10:43:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B894FABCD; Wed, 27 Mar 2013
 10:43:58 -0400 (EDT)
In-Reply-To: <CAEBDL5Vx0vjAKUeFrXgpx7mYxk8B+OQC5yrEii9RMP-5-Sjhsw@mail.gmail.com> (John
 Szakmeister's message of "Tue, 26 Mar 2013 04:54:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C21CADD4-96EC-11E2-978E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219252>

John Szakmeister <john@szakmeister.net> writes:

> Sorry about the repeat Junio, I meant to hit "Reply to All".
>
> On Mon, Mar 25, 2013 at 5:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
>> Your patch makes me wonder if
>>
>>         test -n "$TERM_PROGRAM"
>>
>> without any SECURITYSESSIONID or explicit program name checks should
>> suffice, though.
>
> So, after downloading a couple of other terminals and trying things
> out, I think you're suggestion does suffice.  Should I send an updated
> patch?

If that approach is better than what you originally sent, then yes.

But I do not use OS X, so you may need to pay attention to possible
complaints and comments from other Mac users on this list for a
while---there may be people who run the program in question without
that environment variable.
