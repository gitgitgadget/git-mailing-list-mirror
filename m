From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 16:40:45 -0700
Message-ID: <7vk5flo0si.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807170100320.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJGd5-0004jk-RX
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 01:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbYGPXkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 19:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbYGPXkx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 19:40:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbYGPXkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 19:40:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A99E2F74E;
	Wed, 16 Jul 2008 19:40:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EEA52F74D; Wed, 16 Jul 2008 19:40:47 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807170100320.4318@eeepc-johanness> (Johannes
 Schindelin's message of "Thu, 17 Jul 2008 01:05:21 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F5AFF16-5390-11DD-B5C2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88785>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 16 Jul 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Am I the only one who deems teaching plumbing to users ("I like it raw!  
>> > So I teach it the same way!") harmful?
>> 
>> I think that justification is harmful.
>> 
>> More productive way to think about it is to identify cases where we 
>> _need_ to go down to combination of the plumbing commands in our daily 
>> workflow, with today's command set.  That would give us a good 
>> indication that some Porcelain may need to be enhanced.
>> 
>> An example. I find myself running "git read-tree -m -u $another_state" 
>> while redoing a series inside a "rebase -i" session to move commit 
>> boundaries.  There may need an insn that says "use that tree" instead of 
>> "edit" and running "read-tree -m -u" by hand.  This does not bother me 
>> too much, but there probably are other examples.
>> 
>> Another example.  I often run "git ls-files -u" while looking at which 
>> paths are conflicting.  ls-files is classified as plumbing, but it does 
>> not bother me as much as having to see the staged long object names in 
>> this output.  Other people, however, might find it yucky, and we might 
>> want "git merge --unmerged" or something that lists the paths (and only 
>> paths, no stage information) that still have conflicts.
>
> I agree that if you know Git internals -- and you and me do -- it comes in 
> _right_ handy to know the 100+ commands with many options by heart.
>
> However, my point was about telling users, especially new ones.

Perhaps you did not read my first paragraph?
