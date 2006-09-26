From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: your mail
Date: Tue, 26 Sep 2006 12:56:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609261249310.3952@g5.osdl.org>
References: <C8DBC54F2A9BAD4FA7F445CC7ADD963B0232474F@sslmexchange1.paymentech.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Whitcroft <apw@shadowen.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 26 21:57:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJ2u-0001SC-8T
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 21:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWIZT4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWIZT4p
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 15:56:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWIZT4o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 15:56:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8QJudnW013383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Sep 2006 12:56:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8QJucCM031250;
	Tue, 26 Sep 2006 12:56:39 -0700
To: "Zhao, Jing" <Jing.Zhao@chasepaymentech.com>
In-Reply-To: <C8DBC54F2A9BAD4FA7F445CC7ADD963B0232474F@sslmexchange1.paymentech.us>
X-Spam-Status: No, hits=-0.478 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27814>



On Tue, 26 Sep 2006, Zhao, Jing wrote:
> 
>  I subscribed git emailing list (git@vger.kernel.org). I don't know for 
> what reason, my post emails all have been rejected. Could you post this 
> for me and shed some light on this issue? thanks,

The vger.kernel.org lists have various spam detectors, and I suspect a 
combination of your email address and the signature you use just triggers 
that system to believe that you are trying to sell us house payment plans 
or something..

So I would suggest removing your signature in particular, that points to a 
web-site that is associated with an industry that has over-used the email 
medium for selling their services...

> I tried to port git to VOS system (Stratus). When i compiled it, i 
> found it did not have 'regex.h' and its library. Do you know any 
> workaround for this problem? Or which package contains these code i can 
> port at first?

I do not know if stratus has regex libraries anywhere, but googling for 
"VOS Stratus regex" seems to be saying that this isn't the first time that 
platform has had problems compiling various programs.

I suspect you'd just have to compile one of the regex libraries that are 
out there as source. I think Henry Spencer's libraries are likely the 
canonical ones, but there's a "GNU regex" too, and that's probably the 
basis for the ones that are used in glibc. Dunno.

Google for either of those, you'll find them. It's not new code, but I 
doubt it needs to be ;)

			Linus
