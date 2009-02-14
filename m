From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 12:35:35 -0800
Message-ID: <7v8wo8sqnc.fsf@gitster.siamese.dyndns.org>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRGA-0008Oz-NI
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZBNUfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZBNUfn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:35:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZBNUfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:35:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C81B2B226;
	Sat, 14 Feb 2009 15:35:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E89982B225; Sat,
 14 Feb 2009 15:35:36 -0500 (EST)
In-Reply-To: <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 14 Feb 2009 22:09:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BA11C8A-FAD7-11DD-9A28-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109923>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I personally do not think "I rewrote this command's option parser using
>> parseopt" earns any "trust point".  I think the latter is a *great* thing
>> to do, though.
>
> I disagree. Making a patch pass through all the filters must mean
> something, and the more patches the more trust.

Why are you arguing?

I am saying I do not feel more trust in people _merely because_ they
rewrote command parser to use parseopt.  Telling me that I am wrong and I
should trust you more for such a patch would not help.

>> Mistakes made in the past and resulting flaws that remain in the current
>> source do not justify a new patch adding more mistakes to the codebase.
>> Reviewers help the author from adding more.
>>
>> One bad thing about the current process (and I am certainly one of the
>> guilty parties because I do a lot of reviews) around this area is that a
>> review comment that points out a mistake similar to the ones made in the
>> past sound to the author of the patch as if the reviewer is telling that
>> the patch will not be accepted unless the existing mistakes are also fixed
>> by the patch author.  Such a review certainly does not mean that ...
>> ...
> But, if there's code that already has the same issues the patch has,
> it doesn't look like a good argument for patch rejection. Perhaps the
> quality standards increased, but on the other hand things wouldn't get
> worst by applying the patch.

If you read the above quoted block again, you will notice that we are
almost in full agreement, *if* you change "by applying the patch" in your
last sentence to "by applying a patch that is revised to fix the problem
pointed out during the review in it, even if it does not address the
similar ones in the existing code".

Adding more breakages of the same kind may not increase the number of
classes of breakages, but surely it increases the number of places that
need to be fixed later, and it is actively wrong to discard time and
energy somebody already spent to prevent one more instance of known
breakage to get into the codebase.
