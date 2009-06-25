From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 18:32:51 +0200
Message-ID: <4A43A6B3.5020407@gmx.de>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>	<7veit9m8cs.fsf@alter.siamese.dyndns.org> <863a9oz8lh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrsl-0005ol-7s
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZFYQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbZFYQcv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:32:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:53888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750964AbZFYQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:32:51 -0400
Received: (qmail invoked by alias); 25 Jun 2009 16:32:53 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp071) with SMTP; 25 Jun 2009 18:32:53 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+muXEJ2PGmvWGcucHp80kc9ST6qX2EbWHL3voY9E
	qieVpZGoiv33Fz
Received: from localhost ([127.0.0.1])
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KLSZAR-0003CO-E8; Thu, 25 Jun 2009 18:32:51 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
In-Reply-To: <863a9oz8lh.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122219>

Randal L. Schwartz schrieb:
>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
> 
> Junio> (5) Continue pretending to be Linus, complete the octopus.  The key is to
> Junio>     let the "fetch" phase of this to append to the FETCH_HEAD, not
> Junio>     replacing it.
> 
> Junio>     $ git pull --append \
> Junio>       git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current \
> Junio>       for-linus
> 
> The relatively current doc of "--append" looks like this:
> 
>        -a, --append
>            Append ref names and object names of fetched refs to the existing
>            contents of will be overwritten.
> 
> I read this three times, and still don't know what it means (and it doesn't
> even scan well as English), so I would have never known to use this strategy.
> Can you explain this more in detail, or point at something in the mailing list
> that does?

Greetings,

If I may: So the existing description is incomprehensible. I sort of believed I
understood it, but apparently I didn't understand enough of it.

Could we ditch the current git-pull --append description? Can then please
somebody rewrite this paragraph? This somebody must have completely understood

(1) what this feature is good for (practically speaking)

(2) how it works (technically speaking, to provide reference information)

That would be much more useful, and the use would last longer :-)

I don't dare ask Junio directly.

However, it appears to me that git-pull already does most of what Linus needs,
could take some final cosmetic touch-ups WRT logs. So could somebody please
rewrite this?

And if I may be so bold: Please rewrite before somebody starts polishing the
bisect facilities WRT octopus merges. These seem unrelated, as in: you don't
need to make bisect more convenient to be able to fix the description of
git-pull --append...

Thanks for not slashing me to pieces. 8-)

Best regards
MA
