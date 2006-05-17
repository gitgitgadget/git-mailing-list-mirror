From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 12:42:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171239420.10823@g5.osdl.org>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
 <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> <7vejythvkr.fsf@assigned-by-dhcp.cox.net>
 <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
 <4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
 <7vhd3ofsyv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171109170.10823@g5.osdl.org>
 <7vodxwcwa1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:43:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRvH-0007V8-Ok
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWEQTnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWEQTnE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:43:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751035AbWEQTnC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 15:43:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HJgwtH006390
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 12:42:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HJgsrV024044;
	Wed, 17 May 2006 12:42:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodxwcwa1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20232>



On Wed, 17 May 2006, Junio C Hamano wrote:
> 
> This makes -c misbehave in a subtle way.
> 
> 	git grep -c -e no-such-string-anywhere | head -n 1
> 
> But I do not think we care.

Ahh, yes. That appears to be unfixable without using special GNU 
extensions.

I agree that we probably don't care, though.

		Linus
