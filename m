From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: remove CR/LF from .gitignore
Date: Wed, 2 Nov 2005 08:02:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511020759500.27915@g5.osdl.org>
References: <81b0412b0511020505u1b6b7649l924e252d561b8e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 17:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXL45-0006F2-TM
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 17:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVKBQCO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 11:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVKBQCO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 11:02:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965106AbVKBQCN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 11:02:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA2G24W6004470
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 2 Nov 2005 08:02:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA2G23Id025023;
	Wed, 2 Nov 2005 08:02:03 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511020505u1b6b7649l924e252d561b8e9e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11026>



On Wed, 2 Nov 2005, Alex Riesen wrote:
>
> For everyone cursed by dos/windows line endings (aka CRLF):

Btw, it would be good if somebody verified that the .git/config file also 
works with CR/LF. 

I'm pretty sure "\" at the end of line will break, but I didn't care 
enough. And maybe nobody does. Normal config files _should_ work, but 
you can guess how eager I'm to test it ;)

		Linus
