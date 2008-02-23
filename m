From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more verbose when checkout takes a long time
Date: Sat, 23 Feb 2008 14:37:46 -0800
Message-ID: <7vzltrz4cl.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
 <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT312-0007TO-5T
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbYBWWiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbYBWWiI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:38:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYBWWiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:38:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C16BA1A31;
	Sat, 23 Feb 2008 17:38:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EC4AE1A30; Sat, 23 Feb 2008 17:37:59 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sat, 23 Feb 2008 14:32:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74868>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 23 Feb 2008, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > So I find it irritating when git thinks for a long time without telling me 
>> > what's taking so long. And by "long time" I definitely mean less than two 
>> > seconds, which is already way too long for me.
>> 
>> Do you mean more than two or less than two?
>
> I mean that "long time" starts at a point that is less than two seconds.
>
> Anything over a second is a long time for me.
>
>> Geez you are impatient ;-).
>
> I like to call it "discerning in my time usage".
>
>> The other user of start_progress_delay uses 95% as cutoff.  and
>> probably 50% was too low, but that may just be bikeshedding.
>
> I did think that 50% was a bit low, and considered upping it to 75, but 
> with the one-second thing it wasn't as much of a deal any more. 
>
>> I agree.  Perhaps we can add some message when "-m" codepath
>> falls back to the three-way merge to make "merge-error" less
>> scary.  Perhaps like:
>
> Sounds sane to me.

Ok, then.

Unfortunately it will be short-lived on 'master' as I have been
planning to merge Daniel's rewrite soon ;-)
