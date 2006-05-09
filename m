From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 20:08:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 05:08:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdIai-0004UV-TW
	for gcvg-git@gmane.org; Tue, 09 May 2006 05:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWEIDIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 23:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEIDIt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 23:08:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751344AbWEIDIt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 23:08:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4938gtH013073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 20:08:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4938f1b029600;
	Mon, 8 May 2006 20:08:41 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19812>



On Mon, 8 May 2006, sean wrote:
> 
> What's the advantage of section quotation marks over just allowing these
> characters in regular section names?  To be specific, what is wrong with:
> 
>    [jc/show-branch-dense]

This would _suck_

What if you have a branch called "core"? Not all all unlikely. 

Think about what a section like

	[core]

really means.

Plus I really want to not be case sensitive by default. Case sensitivity 
really is _not_ normal for this kind of config file syntax.

			Linus
