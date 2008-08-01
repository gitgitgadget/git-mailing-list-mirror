From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:44:53 -0700
Message-ID: <20080801154453.921bb50f.akpm@linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
	<20080801131127.20b3acfd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
	<20080801132415.0b0314e4.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
	<20080801135421.5ca0f6af.akpm@linux-foundation.org>
	<7vvdykqub6.fsf@gitster.siamese.dyndns.org>
	<20080801145804.85041bbd.akpm@linux-foundation.org>
	<20080801221539.GA8617@mit.edu>
	<20080801152720.56dbff09.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3OT-000432-E5
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761113AbYHAWpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761120AbYHAWpj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:45:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47935 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760921AbYHAWpg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:45:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Mis6t013588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:44:55 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71Miris007723;
	Fri, 1 Aug 2008 15:44:53 -0700
In-Reply-To: <alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91116>

On Fri, 1 Aug 2008 15:34:16 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 1 Aug 2008, Andrew Morton wrote:
> > 
> > And the existing .mailmap appears to have taken care that all the
> > "name" parts are in an MUA-usable form.  There are no periods or
> > commas.
> 
> Umm. Or quotes? I don't think so. Or even periods? You must not have 
> looked at things, I found one at the very first screenful.
> 
> 	Ed L. Cashin <ecashin@coraid.com>
> 	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 	S.__a__lar Onur <caglar@pardus.org.tr>

oh.  So .mailmap isn't usable either.  Argh.

I guess it'd be fairly simple to slap quotes around anything which
contains fishy characters.

> adn that's just basically ignoring the fact that we only add mailmap 
> entries for people who can't get it right other ways (where admittedly 
> sometimes the "can't get it right" comes from the people in between: poor 
> __a__lar has had his name corrupted so many times that it's funny).
  ^^^^^^^^ (lol)
