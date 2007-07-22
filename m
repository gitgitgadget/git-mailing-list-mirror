From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 18:41:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
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
 <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
 <85644dqoig.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
 <85r6n1p7sb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICQS5-0003pF-CS
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 03:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbXGVBli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXGVBli
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 21:41:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58933 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739AbXGVBlh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 21:41:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6M1fXEN009847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 18:41:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6M1fRO9011342;
	Sat, 21 Jul 2007 18:41:27 -0700
In-Reply-To: <85r6n1p7sb.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53212>



On Sun, 22 Jul 2007, David Kastrup wrote:
>  Make it have an empty reference, and it is unique.

I *really* don't see the point.

And you seem to have igored totally my treatise on "content" and how the 
stuff git tracks must be stuff that is visible and detectable in the 
trees. And if I understand you correctly, you also wouldn't be backwards 
compatible. 

IOW, there's a lot of "why's" at all levels.

I don't see the *point*. What's the problem you're trying to solve?

		Linus
