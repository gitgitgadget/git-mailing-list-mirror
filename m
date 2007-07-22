From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 20:43:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181?=
	=?ISO-8859-1?Q?004330.=04=0427353@w?= =?ISO-8859-1?Q?oody.linux-found?=
	=?ISO-8859-1?Q?ation.org>?=
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=04?=
	=?ISO-8859-1?Q?02135450.27249@w?= =?ISO-8859-1?Q?oody.linux-found?=
	=?ISO-8859-1?Q?ation.org>?=
 <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
 <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
 <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
 <85644dqoig.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
 <85r6n1p7sb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
 <85fy3hp3f2.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 05:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICSM6-0003rg-5w
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 05:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbXGVDnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 23:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbXGVDnX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 23:43:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43757 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754208AbXGVDnW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 23:43:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6M3hH6m013740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 20:43:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6M3hBKV018531;
	Sat, 21 Jul 2007 20:43:12 -0700
In-Reply-To: <85fy3hp3f2.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53215>



On Sun, 22 Jul 2007, David Kastrup wrote:
>
> "." _is_ visible and detectable in every tree.

I'm going to add you to my "clueless" filter, because it's not worth my 
time to answr you any more.

I told you. Several times. That "." is pointless exactly because it's in 
_every_ tree, and as such is no longer "content". It's not something that 
the user can care about, because it has no meaning. There's no point in 
tracking it, because even if we do *not* track it, it's there, and we 
cannot do anything about it.

That was the whole difference between "." and ".gitignore", and I 
explicitly pointed out that that was the difference (and the _only_ one), 
and why it mattered.

And you didn't listen. And now you claim that I don't read your emails. I 
do. They just don't make any sense.

Consider this discussion ended. I simply don't care any more.

		Linus
