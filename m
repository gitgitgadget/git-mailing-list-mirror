From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Validate nicknames of remote branches to prohibit
 confusing ones
Date: Sat, 16 Feb 2008 00:08:37 -0800
Message-ID: <7v1w7dcohm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802151412390.13593@iabervon.org>
 <7vskztg8rr.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802152209560.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQI7C-0002FD-Fh
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbYBPIIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 03:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbYBPIIs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:08:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYBPIIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 03:08:47 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 611EB3E1B;
	Sat, 16 Feb 2008 03:08:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 9D9013E19; Sat, 16 Feb 2008 03:08:40 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802152209560.13593@iabervon.org> (Daniel
 Barkalow's message of "Fri, 15 Feb 2008 22:11:38 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74027>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 15 Feb 2008, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> ...
>> > I was sort of expecting you to just put this in yourself, but since you 
>> > haven't, I wrote it up as an actual patch and fixed the polarity of the 
>> > test for slashes.
>> 
>> Thanks.  I am bogged down in day-job these days and have been
>> down-sick for the past 36 hours.
>
> No problem. It's an easy enough patch, and the test suite found the bug in 
> the original version. I just wanted to make sure it didn't get forgotten 
> on account of never getting a patch emailled to the list.

Actually I have been slowly trying to give up on being in the
business of tying up loose ends left by everybody.  I used to
touch-up and finish obvious loose ends and add tests myself to
patches from many people, and I still try to do so when able,
but as contributor base gets larger, doing so to all incoming
patches is starting to become unfeasible, and it is not quite
fair to me (and my wife ;-)).

So in that sense, yes it was getting forgotten, waiting for a
"this is the final revision, apply it" message from you.
