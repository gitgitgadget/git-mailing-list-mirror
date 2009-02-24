From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Mon, 23 Feb 2009 22:59:26 -0800
Message-ID: <7v63j0mib5.fsf@gitster.siamese.dyndns.org>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
 <20090222230620.GB19011@coredump.intra.peff.net>
 <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org>
 <20090223031631.GC22348@coredump.intra.peff.net>
 <7v8wnxun8e.fsf@gitster.siamese.dyndns.org>
 <20090224054216.GD4615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrHt-0003W2-EM
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbZBXG7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbZBXG7i
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:59:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZBXG7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:59:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 192D32BD02;
	Tue, 24 Feb 2009 01:59:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0C7472BD04; Tue,
 24 Feb 2009 01:59:27 -0500 (EST)
In-Reply-To: <20090224054216.GD4615@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 24 Feb 2009 00:42:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1BDE330-0240-11DE-AAEE-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111226>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 23, 2009 at 08:33:37AM -0800, Junio C Hamano wrote:
>
>> Yes, "75 months" is unacceptable.  I suspect people's mind would not work
>> well with anything larger than 60 months.  I've actually thought about
>> "don't care about months" point, but 12 months is a long time.  You
>> certainly remember there still was a noticeable maturity difference
>> between classmates who were born in the earliest months of the school year
>> and in the last months before graduating grade school.  Perhaps after 20
>> years.
>
> I'm not sure human and code development necessarily follow the same
> timelines. Git wouldn't even be in kindergarten yet. ;)
>
>> > Another option would to give higher resolution in number of years, like
>> > "3.5 years" or even "3.1 years".
>> 
>> But I do not think people think of years in terms of decimal fraction.
>
> I think decimal fraction is overkill. Halves or quarters are more
> reasonable.
>
> But after sleeping on it, I think "Y years, M months" is not that bad.

That was what I thought.  There may be some very convincing reasoning I am
not seeing in the proposals to make it ultra-short like "Y yr M mo" or
"Y.x years" (i.e. "we _have_ to keep it under N characters"threshold), but
I doubt there is a particular place "Y years, M months" would make the
output too long to be acceptable.
