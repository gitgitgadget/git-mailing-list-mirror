From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3-wip] revision traversal: show full history with merge
 simplification
Date: Fri, 01 Aug 2008 00:50:28 -0700
Message-ID: <7vhca5tbqz.fsf@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
 <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
 <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807311513020.3277@nehalem.linux-foundation.org>
 <7vabfxv3px.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807312044240.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpQT-0007C4-K3
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYHAHus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbYHAHus
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:50:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbYHAHur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:50:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 54A7E4464B;
	Fri,  1 Aug 2008 03:50:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 867454464A; Fri,  1 Aug 2008 03:50:40 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807312044240.3277@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 31 Jul 2008 20:48:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8CD6BCC6-5F9E-11DD-A997-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91040>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 31 Jul 2008, Junio C Hamano wrote:
>>
>> It was even worse than that.
>> 
>> The output from v3 is incorrect
>
> Ok. I'm really not surprised. Incrementally is really hard. I'm reminded 
> of all the problems we had with just the "trivial" issue of just knowing 
> when to consider something uninteresting or not, that ended up depending 
> on commit timestamps etc, and had problems with people having their clocks 
> set incorrectly.
>
> Doing the ops once you have the full DAG is usually _trivial_ by 
> comparison. 

Surely.  I wasn't productive tonight anyway, and I'll give up for now and
keep the post-processing version in 'pu', perhaps queued in 'next' during
the 1.6.0-rc period.  Perhaps somebody cleverer than me will feel itchy
enough to make an incremental version someday ;-)
