From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [kernel.org users] [RFC] "clone --naked"?
Date: Mon, 16 Jan 2006 11:17:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601161114080.13339@g5.osdl.org>
References: <Pine.LNX.4.64.0601121556240.3535@g5.osdl.org>
 <43CB57A0.29999.F89D30F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <7vfynoy5p5.fsf_-_@assigned-by-dhcp.cox.net> <1137402365.3034.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	git@vger.kernel.org, users@kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 20:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZrI-00057s-B9
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 20:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWAPTRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 14:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWAPTRh
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 14:17:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWAPTRg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 14:17:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0GJHNDZ009003
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 11:17:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0GJHIZi002018;
	Mon, 16 Jan 2006 11:17:20 -0800
To: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1137402365.3034.5.camel@laptopd505.fenrus.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14756>



On Mon, 16 Jan 2006, Arjan van de Ven wrote:
> 
> While I don't give a rats bottom about the "21"-ness of naked, "naked"
> is more likely to trigger spam traps than "bare" though... just a side
> consideration but unfortunately needed nowadays ;(

Yeah. I've had spamassassin kill patches to the aic7xxx driver because the 
subject said "aic7xxx", and the "xxx" triggered as being a bad word.

Now, "naked" doesn't seem to trigger anything for spamassassin, but I 
wouldn't be entirely surprised if some web-content blocker were to be 
over-eager at times. So "bare" might be safer.

		Linus
