From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trial git RPM's..
Date: Tue, 12 Jul 2005 10:01:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507120959550.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
 <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
 <20050711210309.GT5324@shell0.pdx.osdl.net> <m1zmssyq0r.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Wright <chrisw@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsOAF-0003gl-HJ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 19:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGLRC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 13:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGLRC5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 13:02:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261620AbVGLRBy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 13:01:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6CH1rjA012157
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 10:01:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6CH1pPv021243;
	Tue, 12 Jul 2005 10:01:52 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1zmssyq0r.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 12 Jul 2005, Eric W. Biederman wrote:
> 
> One last issue with building packages.  Some distros are still shipping
> GNU interactive tools so git as a package name for the rpm is problematic.
> At the very least it is extremely confusing that git-0.99 is a more
> recent package that git-4.3.20.

Ahh. Dang, I should have remembered this. We should call the rpm 
"git-core-0.99", not just "git-0.99".

Chris, I assume this is just changing the name in the spec-file from "git" 
to "git-core"?

		Linus
