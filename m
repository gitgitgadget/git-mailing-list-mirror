From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT push to sftp (feature request)
Date: Mon, 06 Aug 2007 10:59:56 +0200
Message-ID: <vpq8x8pjawj.fsf@bauges.imag.fr>
References: <200708051105.44376.pavlix@pavlix.net>
	<46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com>
	<vpqir7t8vy0.fsf@bauges.imag.fr>
	<46a038f90708051700t7a758f8fwdf7c63c8aeef9ee8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pavlix <pavlix@pavlix.net>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHyVV-0001VN-2C
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759960AbXHFJEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759888AbXHFJEE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:04:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:40542 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723AbXHFJEC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:04:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l768xuMS003560
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Aug 2007 10:59:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IHyRQ-0006l8-5Y; Mon, 06 Aug 2007 10:59:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IHyRQ-0007iv-3B; Mon, 06 Aug 2007 10:59:56 +0200
Mail-Followup-To: "Martin Langhoff" <martin.langhoff@gmail.com>, pavlix <pavlix@pavlix.net>,  git@vger.kernel.org
In-Reply-To: <46a038f90708051700t7a758f8fwdf7c63c8aeef9ee8@mail.gmail.com> (Martin Langhoff's message of "Mon\, 6 Aug 2007 12\:00\:03 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Aug 2007 10:59:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55127>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 8/6/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> > Using dumb protocols it's impossible to do either.
>>
>> That's not exactly true. You can't be as efficient with dumb protocols
>
> You are right -- I should have said: it's pretty hard, and we haven't
> put the effort ;-)

Yes, that seems more accurate.

>> (its ancestor,
>> GNU Arch, also had a way to be network-efficient on dumb protocols).
>
> Do I remember your name from gnuarch-users?

Possibly so, yes. I also remembered yours from the old good time where
people started explaining why they unsubscribed the list and migrated
to something better ;-).

> -- that Arch/tla was never particularly efficient, and fetches of
> large updates were slow and painful. Surely it was efficient on
> paper though :-p

It was actually efficient in terms of bandwidth. You downloaded only
the needed pieces (this has to do with the fact that the original
author wrote it at a time when he had only a slow modem connection).
But badly pipelined, and local operations were slow, so the result was
obviously _very_ far from what git can do.

-- 
Matthieu
