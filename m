From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Fri, 27 Feb 2009 09:34:07 -0800
Message-ID: <7vy6vrkcmo.fsf@gitster.siamese.dyndns.org>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
 <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
 <49A66057.1050501@drmicha.warpmail.net>
 <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
 <49A7C3A7.6060202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 18:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld6cg-0002V0-Kv
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZB0ReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbZB0ReO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:34:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbZB0ReO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 12:34:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96D2E2AD2;
	Fri, 27 Feb 2009 12:34:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8D8F2AD1; Fri,
 27 Feb 2009 12:34:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8F3D9E4-04F4-11DE-9F5B-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111686>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 26.02.2009 18:09:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> First of all: I define good/bad as matching the documentation.
>> 
>> Ok, I was primarily working from this:
>> 
>> commit bcc785f611dc6084be75999a3b6bafcc950e21d6
>> Author: Linus Torvalds <torvalds@osdl.org>
>> Date:   Mon Oct 30 08:28:59 2006 -0800
>
>
> [snip]
>> You will see that:
>> 
>>  (1) bf07cc5 (i.e. J6t's documentation) passes your tests;
>
> Hmm, I don't see that, we must be doing something differently, see below.

No, I didn't even know if the commit passed your tests.  Before the [snip]
I think I had something like:

	If your claim that this is a bug is true, it might have happened
	this way: Linus originally wrote it, behaviour changed, J6t
	documented the updated behaviour, behaviour changed again.

and after (1)/(2)/..., I have:

>> if the above conjecture is true, and we may want to fix that regression to
>> match the documentation.

So if you don't see that, it merely proves that the conjecture is false.
The updated documentation didn't describe correctly what should happen and
there is no bug other than in the documentation.

It's a different matter if we want to update the semantics, but I am not
sure if people agree with "the documented version is more natural".  I'm
neutral right now.  I may have more to say after I re-read the detailed
analysis part of your message.
