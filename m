From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-mktree: reverse of git-ls-tree.
Date: Tue, 21 Feb 2006 09:57:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602210952321.30245@g5.osdl.org>
References: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net> 
 <1140504750.16926.111.camel@evo.keithp.com> <43FAD35E.5080401@op5.se> 
 <7vr75x11or.fsf@assigned-by-dhcp.cox.net> <1140542628.16926.125.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1903541438-1140544634=:30245"
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 18:57:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBblm-00032m-K0
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBUR5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 12:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBUR5c
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 12:57:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932096AbWBUR5b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 12:57:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1LHvIDZ031775
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Feb 2006 09:57:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1LHvEcR028107;
	Tue, 21 Feb 2006 09:57:16 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1140542628.16926.125.camel@evo.keithp.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16537>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1903541438-1140544634=:30245
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 21 Feb 2006, Keith Packard wrote:
> 
> Precisely. I'd say either remove the (c) or replace it with the correct
> symbol.

Taking that to its logical conclusion, you should remove the whole line, 
since none of it is in any way required and it's all unnecessary.

The thing is, the string "(c)" is a _lot_ more readable than the sanest 
alternative for © (\c2\a9, ie the appropriate UTF8 string). Because even 
that sane representation will actually show up as something else in a 
_lot_ of editors, and is often hard to type for people. 

There's a reason people use "(c)" rather "©".

		Linus
--21872808-1903541438-1140544634=:30245--
