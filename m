From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 02:18:16 -0800
Message-ID: <7vd4guzmdz.fsf@gitster.siamese.dyndns.org>
References: <200811121029.34841.thomas@koch.ro>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> <7vtza95h01.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org> <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21D9-0001Gz-DL
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYKQKSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYKQKSs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:18:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYKQKSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:18:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0694716DC8;
	Mon, 17 Nov 2008 05:18:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D716E16E3D; Mon,
 17 Nov 2008 05:18:17 -0500 (EST)
In-Reply-To: <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
 (Mike Ralphson's message of "Mon, 17 Nov 2008 10:03:18 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EC01C08-B491-11DD-AFC2-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101208>

"Mike Ralphson" <mike.ralphson@gmail.com> writes:

> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>>
>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>>
>>> This introduces make variable NO_PTHREADS for platforms that lack the
>>> support for pthreads library or people who do not want to use it for
>>> whatever reason.  When defined, it makes the multi-threaded index
>>> preloading into a no-op, and also disables threaded delta searching by
>>> pack-objects.
>>
>> Ack. Makes sense.
>
> I'd be minded to make this the default on AIX to keep the prerequisite
> list as small as possible, then people can opt-in for the performance
> benefits if required.
>
> I'll wait a little while to see if anyone else reports the same for
> other platforms and then submit a patch.

Thanks.

I expect to be slow this week til just before Thanksgiving, so the more
people we have to keep an eye on the areas they excel at, the better for
all of us and certainly it would help me a lot.
