From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 15:20:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021517220.8247@g5.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
 <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com>
 <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com>
 <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com>
 <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com>
 <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com>
 <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com>
 <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com>
 <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com>
 <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com>
 <42C70EEF.6050207@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 00:21:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoqMV-0006sV-7V
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 00:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGBWVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 18:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVGBWVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 18:21:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261308AbVGBWUz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 18:20:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j62MKhjA028071
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 15:20:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j62MKaID012341;
	Sat, 2 Jul 2005 15:20:39 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <42C70EEF.6050207@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 2 Jul 2005, A Large Angry SCM wrote:
> 
> Why have tag objects at all?

Trust.

None of git itself normally has any "trust". The SHA1 means that the 
_integrity_ of the archive is ensured, but for some things (notably 
releases), you want to have something else. That's the "tag object".

And I really should probably have called them something else. _I_
personally tend to want to have a 1:1 relationship between my "tag
references" (ie the 20-byte SHA1 pointer) and my "tag objects", but that's
because my releases are things that I envision people may actually want to
verify are mine.

In many cases, you'd never use a "tag object", and the "tag reference" 
would just point directly to a commit, with no extra indirect object.

		Linus
