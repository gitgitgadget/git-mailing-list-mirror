From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:33:45 +0200
Message-ID: <vpqzm01v4li.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
	<7vbqchjx9f.fsf@gitster.siamese.dyndns.org>
	<46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISrHD-00083y-BG
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbXIEJeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbXIEJeT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:34:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:61700 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909AbXIEJeS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:34:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l859XjWw005668
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2007 11:33:45 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ISrGb-0006kA-Dn; Wed, 05 Sep 2007 11:33:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1ISrGb-0008AU-BP; Wed, 05 Sep 2007 11:33:45 +0200
In-Reply-To: <46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com> (Martin Langhoff's message of "Wed\, 5 Sep 2007 21\:27\:23 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Sep 2007 11:33:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57702>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 9/5/07, Junio C Hamano <gitster@pobox.com> wrote:
>> [alias]
>>         begin = gc
>>         leave = gc
>>
>> That is, the user's manual says 'at the beginning of the day,
>> run "git begin" to start the day, and at the end of day, run
>> "git leave" to conclude your day', without saying why ;-)
>
> I actually like that one ;-)

There's indeed a real idea behind that. The issue is that the alias
shouldn't be just "gc", but "find-all-repositories-and-do-gc-there".

Currently, AFAIK, that can only be done with a (trivial) script
external to git. I suppose this can easily be added to the core git
porcelain. Perhaps a "git gc --recursive" would do.

It doesn't solve the problem, but makes it easier to solve it (git gc
--recursive in cron for example).

-- 
Matthieu
