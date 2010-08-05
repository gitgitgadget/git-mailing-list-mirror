From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 09:29:34 -0700
Message-ID: <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3Kp-0003jO-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695Ab0HEQaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:30:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933679Ab0HEQ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:29:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD9B6CA7DD;
	Thu,  5 Aug 2010 12:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q7sqZTpEh/ZBMbGdxAmEotRVDJg=; b=BG71Oz
	YdYOPwqI8R6BjXnEmN/Q1ockenffmP6fGaN7MGb7BMIzWFvy1B/+X4cOF/Eam79m
	Le/dvQozmKRC0mzfTIFcB7W8faI8LOdlLcB1U9sN/irLHSrafhDHAcTM5UOBSfPl
	Y1KPj6kliH0kQzw0HKR8umI+mBJ3c//1kOWOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJX9uUDrTR9S1u2F6E9Jt+Y2NxL9GcLn
	wBHCiPN+RV8UexsDhk70G4SO/o1r7MEdQKGKmgDsdJNySsYos+mHgUjqE5SvxLA2
	A87vVP8Ldj0bjdNnfiLG8b3BE/h645tdYSSmUsFlpbHgU7CxtaNyhahQs8T15GJo
	bjiYoG28L7I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42061CA7DB;
	Thu,  5 Aug 2010 12:29:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99E0CCA7D7; Thu,  5 Aug
 2010 12:29:36 -0400 (EDT)
In-Reply-To: <20100805001629.GC2901@thunk.org> (Ted Ts'o's message of "Wed\,
 4 Aug 2010 20\:16\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4B4252E-A0AE-11DF-A45C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152686>

Ted Ts'o <tytso@mit.edu> writes:

> On Wed, Aug 04, 2010 at 03:24:23PM -0700, Junio C Hamano wrote:
>> 
>> * jk/tag-contains (2010-07-05) 4 commits
>>  - Why is "git tag --contains" so slow?
>>  - default core.clockskew variable to one day
>>  - limit "contains" traversals based on commit timestamp
>>  - tag: speed up --contains calculation
>
> What needs to be fixed up before this effort can graduate?  I find the
> fixups here to be really helpful, even without the automated skew
> detection that has been proposed.  And even if we fix the root problem
> with some new all-singing pack format, I suspect that may be a ways
> out, so it would be nice if these patches could get included for now....

I agree in principle; the log messages need to be cleaned up first
at the least, though.
