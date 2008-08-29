From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Thu, 28 Aug 2008 18:07:01 -0700
Message-ID: <7vmyiwbpe2.fsf@gitster.siamese.dyndns.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org>
 <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 03:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYsTK-00028g-9o
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 03:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYH2BHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 21:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYH2BHM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 21:07:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYH2BHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 21:07:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B25686CB36;
	Thu, 28 Aug 2008 21:07:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D67B6CB35; Thu, 28 Aug 2008 21:07:04 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 28 Aug 2008 17:34:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE2D97B6-7566-11DD-991E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94239>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 28 Aug 2008, Junio C Hamano wrote:
>> 
>> Some poeple find it easier to be able to understand what is going on when
>> they can view the common ancestor's version, which is used by "diff3 -m",
>> which shows:
>> 
>>  <<<<<<<
>>  postimage from one side;
>>  |||||||
>>  shared preimage;
>>  =======
>>  postimage of the other side; and
>>  >>>>>>>
>> 
>> This is an initial step to bring that as an optional feature to git.
>> Only "git merge-file" has been converted, with "--diff3" option.
>
> If you have the common ancestor, why would you ever want this format, and 
> not a nice conflict entry in the index?

We already have that, don't we?  You can think of it as how to present
that information without resorting to "diff :1:path :2:path".

> Anyway, that's irrelevant for my real question, which is:

... the same thing as I already said after three-dashes, hence RFH/WIP.
