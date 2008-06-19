From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Simplify git-rev-parse's example
Date: Thu, 19 Jun 2008 16:28:48 -0700
Message-ID: <7v63s5rolr.fsf@gitster.siamese.dyndns.org>
References: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl>
 <485AAF82.3030209@freescale.com> <7v8wx1te20.fsf@gitster.siamese.dyndns.org>
 <D6812FD2-F61D-4813-95B4-4FCCDE35C418@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TZp-0007qe-Ou
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbYFSX3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbYFSX3G
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:29:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbYFSX3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:29:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB3831B5E1;
	Thu, 19 Jun 2008 19:28:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2EF851B5E0; Thu, 19 Jun 2008 19:28:51 -0400 (EDT)
In-Reply-To: <D6812FD2-F61D-4813-95B4-4FCCDE35C418@ai.rug.nl> (Pieter de
 Bie's message of "Fri, 20 Jun 2008 01:02:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7CE5B82A-3E57-11DD-B5BC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85576>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On 19 jun 2008, at 21:33, Junio C Hamano wrote:
>
>>> How is this a vast improvement?
>>>
>>> I could see that inverting it top-to-bottom would
>>> be more consistent with gitk or show-branch output.
>>> Your example doesn't have a 3-parent commit, though,
>>> and it isn't _that_ much simpler otherwise...
>>>
>>> So this is really better _how_?
>>>
>>> Oh, right, of course.  It removes my name.  Got it. :-)
>>
>> I agree that the patch should have just flipped the tree upside down
>> without changing the shape of the history the section talks about.
>
> I tried to make it less of a monster while still keeping examples of
> all possibilities, which is why I removed two of the nodes.

I do not care _that_ deeply myself, but judging from how often the word
Octopus comes up on this list (even though I do not think we would want to
especially encourage the practice), I think it is a disservice to drop an
octopus from the section that teaches how to name a commit in an ancestry
graph.
