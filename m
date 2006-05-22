From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Sun, 21 May 2006 18:45:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605211844080.3649@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
 <20060520203911.GI6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 22 03:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhzU5-00062q-PV
	for gcvg-git@gmane.org; Mon, 22 May 2006 03:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEVBpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 21:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWEVBpW
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 21:45:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964978AbWEVBpV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 21:45:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4M1jItH011264
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 May 2006 18:45:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4M1jEc7011894;
	Sun, 21 May 2006 18:45:17 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060520203911.GI6535@nowhere.earth>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20476>



On Sat, 20 May 2006, Yann Dirson wrote:
> 
> FWIW, I have mentionned a problem that may be the same, under
> Message-ID <20060107090148.GB32585@nowhere.earth>, that was on January
> 7th.  Namely, when importing a repository with very large files over
> pserver or ssh, timeouts can occur and prevent the import from
> working.  But, as you said, it's not easy to get precise info from the
> logs :)

For big repositories, you really shouldn't use pserver or ssh anyway. You 
should try really really hard to just get a local copy, and do it that 
way. It's going to be tons faster, and will avoid a lot of the problems, 
including network timeouts etc.

		Linus
