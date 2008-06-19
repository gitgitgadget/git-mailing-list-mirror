From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Simplify git-rev-parse's example
Date: Thu, 19 Jun 2008 12:33:43 -0700
Message-ID: <7v8wx1te20.fsf@gitster.siamese.dyndns.org>
References: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl>
 <485AAF82.3030209@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Puo-0002km-G7
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYFSTd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 15:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYFSTd7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:33:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYFSTd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 15:33:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A11231BCCC;
	Thu, 19 Jun 2008 15:33:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AA8551BCCA; Thu, 19 Jun 2008 15:33:51 -0400 (EDT)
In-Reply-To: <485AAF82.3030209@freescale.com> (Jon Loeliger's message of
 "Thu, 19 Jun 2008 14:12:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A90E76A6-3E36-11DD-8D88-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85518>

Jon Loeliger <jdl@freescale.com> writes:

> Pieter de Bie wrote:
>> This example was overly complex and therefore confusing.
>> The commits have been renamed to start the oldest commit with "A"
>> and working up from there. Also, this removes some commits so the graph
>> is simpler. Finally the graph has been reversed in direction to make it
>> more like gitk.
>>
>> Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
>> ---
>>
>> This was created after some discussion in #git about how this was confusing.
>> The consesus was that this example is better.
>
> How is this a vast improvement?
>
> I could see that inverting it top-to-bottom would
> be more consistent with gitk or show-branch output.
> Your example doesn't have a 3-parent commit, though,
> and it isn't _that_ much simpler otherwise...
>
> So this is really better _how_?
>
> Oh, right, of course.  It removes my name.  Got it. :-)

I agree that the patch should have just flipped the tree upside down
without changing the shape of the history the section talks about.

Yet another improvement would have been turning it sideways, not upside
down, because that is how we typically write history in our documentation
(time flows from left to right -- see e.g. git-rebase.txt).

I happen to think the last point you raise is an improvement.  It will
quickly become unreadble after a while if we credit individual authors for
every paragraph in-text, and it always bothered me to see somebody's name
(don't get me wrong -- this is not because it is your name nor because it
is not my name, but because it _is_ a name), there but I wasn't bold
enough to remove it without discussion.
