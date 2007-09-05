From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 19:31:44 +0200
Message-ID: <vpq1wddkohr.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
	<7vbqchjx9f.fsf@gitster.siamese.dyndns.org>
	<46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com>
	<vpqzm01v4li.fsf@bauges.imag.fr>
	<D32A7C27-EAF5-4156-BE0E-99FE3D948AE8@wgaf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Johan De Messemaeker <johan.demessemaeker@wgaf.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISykV-00075l-Fq
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbXIERdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbXIERdB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:33:01 -0400
Received: from imag.imag.fr ([129.88.30.1]:58240 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363AbXIERc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:32:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l85HViIs024465
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2007 19:31:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ISyjA-0006ns-FK; Wed, 05 Sep 2007 19:31:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1ISyjA-0000ef-Cn; Wed, 05 Sep 2007 19:31:44 +0200
In-Reply-To: <D32A7C27-EAF5-4156-BE0E-99FE3D948AE8@wgaf.org> (Johan De Messemaeker's message of "Wed\, 5 Sep 2007 16\:17\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Sep 2007 19:31:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57725>

Johan De Messemaeker <johan.demessemaeker@wgaf.org> writes:

>> Currently, AFAIK, that can only be done with a (trivial) script
>> external to git. I suppose this can easily be added to the core git
>> porcelain. Perhaps a "git gc --recursive" would do.
>>
>> It doesn't solve the problem, but makes it easier to solve it (git gc
>> --recursive in cron for example).
>
> I'm a git newb so I can be wrong here but ...
>
> Why --recursive? Why not use the submodule-information ?

all projects are not necessarily subprojects of each others.

I have ~/teaching/some-course/.git (well, almost) and ~/etc/.git which
are two unrelated projects, and to "git gc" both of them, I need
either a script, or two manual invocations.

(yes, I'm really talking about something trivial)

-- 
Matthieu
