From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Latest cogito broken with bash-3.1
Date: Mon, 12 Dec 2005 07:32:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512120725350.15597@g5.osdl.org>
References: <1134220724.15125.4.camel@blade>  <20051211001106.GV22159@pasky.or.cz>
 <1134289867.9541.9.camel@blade>  <20051212002631.GW22159@pasky.or.cz>
 <1134379801.1468.5.camel@blade>  <20051212104039.GJ10680@pasky.or.cz>
 <1134385342.1468.27.camel@blade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 16:32:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElpfA-0004Qn-Sy
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 16:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVLLPc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 10:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVLLPc0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 10:32:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751082AbVLLPcY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 10:32:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBCFW9DZ015901
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 07:32:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBCFW83u000987;
	Mon, 12 Dec 2005 07:32:08 -0800
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1134385342.1468.27.camel@blade>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13519>



On Mon, 12 Dec 2005, Marcel Holtmann wrote:
> 
> I just verified that on my Ubuntu Dapper system where I had a copy of
> the old bash package lying around. The bash-3.0 works fine, but the
> bash-3.1 produces this error. So it is definitely bash related.

It's been around forever, and it's a bash default installation issue. It's 
just that all sane distributions will change the default.

Sounds like debian forgot to do that when upgrading to bash-3.1.

The magic incantation is hidden in the bash FAQ (E2):

	You can build a version of bash that will not report SIGPIPE errors
	by uncommenting the definition of DONT_REPORT_SIGPIPE in the file
	config-top.h.

and I still don't understand why it's not the default. Oh, well.

		Linus
