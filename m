From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Thu, 01 May 2008 12:04:38 -0700
Message-ID: <7vy76tyhfd.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 01 21:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jre6I-0007Jl-Dz
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763591AbYEATE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763443AbYEATEz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:04:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761900AbYEATEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:04:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BAAF4A3A;
	Thu,  1 May 2008 15:04:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B4D684A37; Thu,  1 May 2008 15:04:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AB3CC12-17B1-11DD-8823-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80933>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The idea I hinted at was to refer to them by another name than the short 
> name.  Then we can use the sequencer machinery.
>
> I still maintain that it is such a rare need (even if you are a power user 
> of it) that it makes sense to cater for other, simpler uses.

As usual, I am greedy and I would want to have both supported in such a
way that (1) simple things are simple and (2) the language is expressive
enough that complex things are possible.  And I try to stress that while
we are still in the drawing board phase, because it would be painful to
change once we start with a language without enough expressiveness.

And that was where my "Can the approach to use the original commit ID to
stand for rewritten one express everything we would want to do in the
future, not just limited to 'rebase -i -p'" series of questions came
from.
