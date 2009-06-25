From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 07:33:30 -0700
Message-ID: <863a9oz8lh.fsf@blue.stonehenge.com>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 16:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJq1D-0005UJ-0b
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 16:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbZFYOd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbZFYOd1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 10:33:27 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:12267 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbZFYOd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 10:33:27 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 415551DE345; Thu, 25 Jun 2009 07:33:30 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.8.5; tzolkin = 3 Chicchan; haab = 3 Tzec
In-Reply-To: <7veit9m8cs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed, 24 Jun 2009 18:04:51 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122213>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> (5) Continue pretending to be Linus, complete the octopus.  The key is to
Junio>     let the "fetch" phase of this to append to the FETCH_HEAD, not
Junio>     replacing it.

Junio>     $ git pull --append \
Junio>       git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current \
Junio>       for-linus

The relatively current doc of "--append" looks like this:

       -a, --append
           Append ref names and object names of fetched refs to the existing
           contents of will be overwritten.

I read this three times, and still don't know what it means (and it doesn't
even scan well as English), so I would have never known to use this strategy.
Can you explain this more in detail, or point at something in the mailing list
that does?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
