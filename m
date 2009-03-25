From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 16:41:10 -0700
Message-ID: <7vocvpw4q1.fsf@gitster.siamese.dyndns.org>
References: <49CA78BF.2020101@fastmail.fm>
 <7viqlxz9go.fsf@gitster.siamese.dyndns.org> <49CAAA16.1080401@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Mar 26 00:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmckb-0007F9-Uw
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 00:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZCYXlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 19:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbZCYXlU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 19:41:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbZCYXlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 19:41:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8755A5F52;
	Wed, 25 Mar 2009 19:41:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D0061A5F50; Wed,
 25 Mar 2009 19:41:12 -0400 (EDT)
In-Reply-To: <49CAAA16.1080401@fastmail.fm> (Raman Gupta's message of "Wed,
 25 Mar 2009 18:03:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E894092-1996-11DE-8E8F-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114692>

Raman Gupta <rocketraman@fastmail.fm> writes:

> Junio C Hamano wrote:
> ...
>> That is more-or-less correct, even though I'd actually do either
>> 
>> 	git branch -f next master
>> 
>> or
>> 
>> 	git checkout next
>>         git reset --hard master
>> 
>> instead of deleting and recreating.
>
> Is that a stylistic preference or does your approach have some
> advantage over the delete/create? Doesn't git branch -f internally
> delete and re-create?

No, yes, and no.  The last answer "no" relates to the fact that the
preservation of the reflog and per-branch configuration for "next", which
is the reason behind the second answer "yes".

> ... The only
> concern I had with this workflow was the difficult to understand
> visualization of the history. So to repeat my earlier question: Are
> there some canned gitk invocations, or other tips/tricks/approaches,...

I do not share the difficulty, and there is no answer from me to your
"earlier" question.  Perhaps other people have some tips.
