From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Sun, 21 May 2006 18:40:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605211840210.3649@g5.osdl.org>
References: <4470FC21.6010104@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 22 03:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhzPc-0005TX-HL
	for gcvg-git@gmane.org; Mon, 22 May 2006 03:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWEVBkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 21:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWEVBkq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 21:40:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964977AbWEVBkp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 21:40:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4M1eitH011104
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 May 2006 18:40:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4M1efgF011789;
	Sun, 21 May 2006 18:40:42 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4470FC21.6010104@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20475>



On Sun, 21 May 2006, H. Peter Anvin wrote:
>
> It appears that doing a *local* -- meaning using a file path or file URL -- 
> clone or fetch with cogito is just glacial when the repository has an even
> moderate number of tags (and it's fetching the tags that takes all the time.)
> That's a really serious problem for me.

I think this is purely a cogito problem. 

Use "git clone" instead.

		Linus
