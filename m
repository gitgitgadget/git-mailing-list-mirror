From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Tue, 5 Jul 2005 11:33:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051132530.3570@g5.osdl.org>
References: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org>
 <m1br5hywde.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 20:35:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpsFW-0002BZ-Fm
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 20:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVGESeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGESeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 14:34:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbVGESeM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 14:34:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j65IXsjA008762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 5 Jul 2005 11:33:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j65IXq6C016579;
	Tue, 5 Jul 2005 11:33:52 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1br5hywde.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 5 Jul 2005, Eric W. Biederman wrote:
> 
> True but if you can you will get multiple tags with the
> same suggested name.  So you need so way to find the one you
> care about.

I do agree that it would make sense to have a "tagger" field with the same 
semantics as the "committer" in a commit (including all the same fields: 
real name, email, and date).

		Linus
