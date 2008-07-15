From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 15:33:05 -0700
Message-ID: <7vd4lezske.fsf@gitster.siamese.dyndns.org>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
 <20080715092023.GO10151@machine.or.cz>
 <20080715150626.GA2925@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807151623120.8950@racer>
 <7v3amb0ymg.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160005540.2990@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIt6J-00005s-F2
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763440AbYGOWdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761950AbYGOWdT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:33:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763405AbYGOWdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:33:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C23252DE74;
	Tue, 15 Jul 2008 18:33:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9D0A72DE73; Tue, 15 Jul 2008 18:33:07 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807160005540.2990@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 16 Jul 2008 00:10:42 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04260FB8-52BE-11DD-8CEF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88612>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 15 Jul 2008, Junio C Hamano wrote:
>
>> What troubles me the most is that you seem to be forgetting that we are 
>> using git to manage our codebase.
>
> I don't.  I have vivid memories of updating an ancient git repository of 
> Git itself, which had some almost forgotten changes in it.  That was in 
> the bad old days, when the version number did not even have a "1" in it.
>
> It could not even fetch the current git.git.
>
> I do _not_ want that to happen to anybody else, _even if_ we leave 1.4.4.4 
> Behind as if it was an American Child.

My reference to "git" was about "forking is easy".  We seem to have to
agree that talking is even cheaper, though ;-)

> Having said that, I do not have the resources to test and fix everything 
> that may arise from Debian being seemingly unable to update to Git 1.5.  

Heh, what happent to your earlier "a few minutes for Junio to change and
commit"?
