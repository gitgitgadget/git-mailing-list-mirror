From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 07:49:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170747280.10823@g5.osdl.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> 
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>  <8aa486160605161542u704ccf03w@mail.gmail.com>
  <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
 <8aa486160605170641p2ab8704o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 16:49:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgNKw-00033P-QI
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWEQOtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWEQOtP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:49:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbWEQOtP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:49:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HEn4tH024826
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:49:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HEn3eT015475;
	Wed, 17 May 2006 07:49:04 -0700
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605170641p2ab8704o@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20205>



On Wed, 17 May 2006, Santi wrote:
> 
> In the other way, now I find the value of being able to say:
> 
> $ git add t*

Exactly. The shell will expand the path, so the fact that the path exists 
on the command line does not mean that "git add" should just trust it.

> and be sure that it does not add an ignored file. Unfortunately
> git-add cannot distinguish between both. So what I propose is to
> document it explicitly, something like:

Documenting this more clearly (and the workaround of forcing it with 
"git-update-index --add" by hand) is certainly a good idea.

			Linus
