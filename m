From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Sat, 03 May 2008 10:09:26 -0700
Message-ID: <7vtzhfuxfd.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
 <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net>
 <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
 <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness>
 <7v63u05khw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
 <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
 <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804301253520.2136@eeepc-johanness>
 <7vy76tyhfd.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805031340550.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 19:10:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLFr-0002F3-8F
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760330AbYECRJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759543AbYECRJj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:09:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419AbYECRJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 13:09:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6BAA25C5;
	Sat,  3 May 2008 13:09:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0DD1825C4; Sat,  3 May 2008 13:09:30 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805031340550.30431@racer> (Johannes
 Schindelin's message of "Sat, 3 May 2008 13:45:40 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B60314C0-1933-11DD-89BF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81102>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And I try to stress that while we are still in the drawing board phase, 
>> because it would be painful to change once we start with a language 
>> without enough expressiveness.
>
> Unfortunately, we are no longer in the drawing board phase, because the 
> offending code is already in 'next'.

What does that mean?  "Now we are committed to it, so I will stop
complaining and work within the overall design in a more constructive
way"?

We have precedence of even reverting the whole series from 'next'. When
there is a better design available, I think it is perfectly fine to
improve what is in 'next' in a way that is not backward compatible with
stuff that has not hit 'master'.  That is what 'next' is for.
