From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t3701 if core.filemode disabled
Date: Thu, 22 May 2008 10:49:09 -0700
Message-ID: <7vzlqiut4a.fsf@gitster.siamese.dyndns.org>
References: <20080518152337.GB3058@steel.home>
 <20080518190839.GC15506@sigill.intra.peff.net>
 <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home>
 <20080519205550.GA24246@sigill.intra.peff.net>
 <20080520215932.GB10437@steel.home>
 <20080521143607.GA3575@sigill.intra.peff.net>
 <20080522132042.GF3206@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:51:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzEva-0004I9-4W
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 19:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbYEVRtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbYEVRtV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 13:49:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbYEVRtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 13:49:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A77C18C5;
	Thu, 22 May 2008 13:49:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BAD0E161F; Thu, 22 May 2008 13:49:12 -0400 (EDT)
In-Reply-To: <20080522132042.GF3206@steel.home> (Alex Riesen's message of
 "Thu, 22 May 2008 15:20:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 672F05FE-2827-11DD-A026-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82642>

Alex Riesen <raa.lkml@gmail.com> writes:

> Jeff King, Wed, May 21, 2008 16:36:07 +0200:
>> 2. It's a little hard to see which tests are affected. I would have done
>>    something more like:
>> 
>>   if test "$(git config --bool core.filemode)" = true
>>     test_filemode=
>>   else
>>     test_filemode=:
>>   fi
>> 
>>   $test_filemode test_expect_success ...
>> 
>>   But maybe that is just overengineering.
>
> But a nice one. I like the idea but Junio already did your other
> suggestions in master, so I just keep it in mind for the next one

If you like that, I think you would like the way t0050 does even better
;-).  It is Steffen Prohaska's invention, IIRC.
