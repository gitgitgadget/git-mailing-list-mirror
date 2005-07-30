From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 14:32:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507301428300.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
 <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org> <m3fytwm313.fsf@telia.com>
 <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org> <Pine.LNX.4.58.0507302259140.26128@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 23:36:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyz0H-0002ei-1N
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbVG3Vdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVG3Vdd
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 17:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262946AbVG3Vcz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 17:32:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6ULWmjA011231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 14:32:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6ULWl7t013874;
	Sat, 30 Jul 2005 14:32:47 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <Pine.LNX.4.58.0507302259140.26128@telia.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Peter Osterlund wrote:
> >
> > Can you send me your HEAD and MERGE_HEAD (don't do the merge).
> 
> HEAD      : 33ac02aa4cef417871e128ab4a6565e751e5f3b2
> MERGE_HEAD: b0825488a642cadcf39709961dde61440cb0731c

Bingo.

Yup, it's git-merge-base, and it is confused by the same thing that 
confused git-rev-list.

Thanks, I'll fix it.

		Linus
