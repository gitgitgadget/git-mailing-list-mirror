From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 16:50:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
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
 <85tzrxslms.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 01:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICOja-0003wZ-D0
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 01:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbXGUXvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 19:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXGUXvZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 19:51:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51916 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbXGUXvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 19:51:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6LNomUv006128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 16:50:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6LNogtI007743;
	Sat, 21 Jul 2007 16:50:43 -0700
In-Reply-To: <85tzrxslms.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.212 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53198>



On Sat, 21 Jul 2007, David Kastrup wrote:
> 
> tree1:
>      0?0000 .   -> dir1
>      100644 a.c -> blob1
>      040000 a   -> tree2
>      100644 abc -> blob3

No. Totally broken. That "." entry not only doesn't buy you anything, it 
is *impossible*. You  cannot make an object point to itself. Not possible.

Tell me how to calculate the SHA1 for the result. Also, tell me what the 
*point*  is. There is none.

> Linus, a directory is simply non-existent inside of git. 

You need to learn git first.

A directory doesn't exist IN THE INDEX (until my patches). But you need to 
learn about the object database and the SHA1's. That's the real meat of 
git, and it sure as hell knows about directories.

		Linus
