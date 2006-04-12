From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Adding color to git diff output.
Date: Wed, 12 Apr 2006 08:46:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604120846000.14565@g5.osdl.org>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE> 
 <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
  <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE> 
 <Pine.LNX.4.64.0604111801270.14565@g5.osdl.org>
 <81b0412b0604120038q2e4aef8cn55ba4cfa68e18b34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 17:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FThYL-0000BI-LP
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 17:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWDLPqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWDLPqi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 11:46:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750846AbWDLPqh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 11:46:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3CFkTtH021470
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Apr 2006 08:46:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3CFkSiY008537;
	Wed, 12 Apr 2006 08:46:28 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0604120038q2e4aef8cn55ba4cfa68e18b34@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18632>



On Wed, 12 Apr 2006, Alex Riesen wrote:
>
> Maybe use "-t" here? I have at least one system which has no tty installed.
> Like this:
> 
>   if [ -n "$GIT_DIFF_PAGER" -a -t ]; then

I assume you mean "-t 1". It needs the FD number. But yes.

		Linus
