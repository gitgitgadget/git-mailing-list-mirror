From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 08:04:01 -0700
Message-ID: <7v4p536exq.fsf@gitster.siamese.dyndns.org>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
 <81b0412b0808290246j299371b0k7895308368266a01@mail.gmail.com>
 <38b2ab8a0808290517l75296521rf99f724cb1594f69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 17:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ5XI-0003Ms-DZ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 17:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbYH2PEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 11:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYH2PEL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 11:04:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYH2PEK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 11:04:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B21157C4E;
	Fri, 29 Aug 2008 11:04:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8EDAC57C4D; Fri, 29 Aug 2008 11:04:05 -0400 (EDT)
In-Reply-To: <38b2ab8a0808290517l75296521rf99f724cb1594f69@mail.gmail.com>
 (Francis Moreau's message of "Fri, 29 Aug 2008 14:17:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB60CC6E-75DB-11DD-A7D8-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Francis Moreau" <francis.moro@gmail.com> writes:

> On Fri, Aug 29, 2008 at 11:46 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>>
>> Dunno. I never needed that explicitly. What do you want to do with it?
>>
>
> I'd like to create branches as Junio did for html, man and todo ones.

If that is the objective...

There is no reason whatsoever for these unrelated branches to _ORIGINATE_
from the same source repository.  The repositories you see at kernel.org
and repo.or.cz are merely public distribution points, and I push them into
a single repository at each of these places merely for downloaders
convenience, from separate repositories.
