From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 19:19:03 +0200
Message-ID: <4A43B187.7080509@drmicha.warpmail.net>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>	<7veit9m8cs.fsf@alter.siamese.dyndns.org> <863a9oz8lh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJsbl-0000td-7H
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbZFYRTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbZFYRTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 13:19:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42088 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600AbZFYRTI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 13:19:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 16258382094;
	Thu, 25 Jun 2009 13:19:11 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 25 Jun 2009 13:19:10 -0400
X-Sasl-enc: TKwtWrnrHNlhx/rTmlKK2wH3LoZDUnDiMxilcF1pEZK3 1245950350
Received: from localhost.localdomain (p4FC21214.dip0.t-ipconnect.de [79.194.18.20])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 32A8431F86;
	Thu, 25 Jun 2009 13:19:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090625 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <863a9oz8lh.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122224>

Randal L. Schwartz venit, vidit, dixit 25.06.2009 16:33:
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

Uhm,
my version of git-fetch.1 has

       -a, --append
           Append ref names and object names of fetched refs to the
existing contents of .git/FETCH_HEAD. Without this option
           old data in .git/FETCH_HEAD will be overwritten.

That at least scans better in English. It does not make it very clear
what the consequences are, though.

Michael
