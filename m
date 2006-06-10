From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Fri, 9 Jun 2006 17:46:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091743410.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
 <7virnam435.fsf@assigned-by-dhcp.cox.net> <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Post, Mark K" <mark.post@eds.com>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ForcX-0006Q3-3d
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbWFJAqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWFJAqM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:46:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030566AbWFJAqL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 20:46:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A0k5gt010496
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 17:46:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A0k45o004380;
	Fri, 9 Jun 2006 17:46:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21576>



On Fri, 9 Jun 2006, Junio C Hamano wrote:
>
> This lets you say:
> 
> 	[core]
> 		sharedrepository = 075

I really think it's better to express this as some more traditional 
number.

I had to think about what 075 meant, while saying

	[core]
		sharedrepository = 0644

just makes sense more or less automatically (and yes, for directories, the 
read bit should obviously be expanded as an execute bit).

The difference is just that the latter is how you _usually_ express 
permissions, so people are used to it. 

And "being used to it" is what "ease of use" really all boils down to.

		Linus
