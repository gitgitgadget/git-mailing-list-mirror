From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 10:33:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707221031050.3607@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz>
  =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181004330.?= =?ISO-8859-1?Q?=04=0427?=
	=?ISO-8859-1?Q?353@woody.linux-?= =?ISO-8859-1?Q?foundation.org>?=
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
 <85fy3hp3f2.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
 <85abtpoydg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 19:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfJo-0002Vx-A7
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 19:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762012AbXGVRdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 13:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759194AbXGVRdl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 13:33:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53254 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762291AbXGVRdj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 13:33:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MHXaEA015362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 10:33:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MHXUh2015641;
	Sun, 22 Jul 2007 10:33:31 -0700
In-Reply-To: <85abtpoydg.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.216 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53280>



On Sun, 22 Jul 2007, David Kastrup wrote:
>
> So  when we are talking about a repository tree _becoming_ empty, we 
> need the information whether or whether not we should remove it upon
> becoming empty.

You don't seem to realize - although I've told you now abotu a million 
times - that what you are talking about is:

 - technically exactly the same as ".gitignore", which for some 
   unfathomable reason you cannot seem to accept.

 - except your use of "." is 100% INFERIOR exactly because the "." entry 
   has no meaning in the target filesystem, so it means that the bit of 
   information is no longer something that is trackable in the working 
   tree.

Quite frankly, Junio would be a total idiot to take any patches that do 
what you want to do. Happily, he is anything but.

		Linus
