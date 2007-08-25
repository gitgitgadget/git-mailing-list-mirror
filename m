From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bisect / history preserving on rename + update
Date: Sat, 25 Aug 2007 10:23:05 -0700
Message-ID: <7vd4xb5y12.fsf@gitster.siamese.dyndns.org>
References: <1187080681.12828.174.camel@chaos>
	<alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
	<7vmywgb45c.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708250819360.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 19:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOzMK-0006ED-Ek
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbXHYRXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 13:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbXHYRXO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 13:23:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbXHYRXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 13:23:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FD371283B4;
	Sat, 25 Aug 2007 13:23:29 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708250819360.25853@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 25 Aug 2007 08:38:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56645>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> It was corrected into the current behaviour, following the guiding 
>> principle described in this message:
>> 
>> 	http://thread.gmane.org/gmane.comp.version-control.git/3807
>
> Ahh, you're a wily one. Using my own words against me.

I am not being wily.  I usually do not remember nor quote too
old histories, but June 2005 was somewhat special to me.  Those
two weeks of 18-hour-straight-doing-git-and-nothing-else,
working with git and with you in particular, were what taught me
how fun open source development and working with brilliant
others is.

> Ie, the true "guiding principle" should be the principle of minizing the 
> final diff - that's how diff is supposed to act within a single file, and 
> I think it's how the rename/copy detection is supposed to act too.

Ok, I would agree with that in principle, but that would be
rather intrusive change that I am sure would have fallout to
git-apply side (and anybody who interprets "git diff" output,
especially gitweb), too.  I am not rejecting the idea, but I
won't be able to look into it myself for some time.
