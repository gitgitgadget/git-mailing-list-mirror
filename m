From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 15:54:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151545050.5498@g5.osdl.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
 <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth>
 <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615211454.GK7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 00:54:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr0jh-00038y-10
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 00:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFOWyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 18:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFOWyn
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 18:54:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750726AbWFOWyn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 18:54:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5FMsagt026125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 15:54:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5FMsY4L030224;
	Thu, 15 Jun 2006 15:54:35 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060615211454.GK7766@nowhere.earth>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21919>



On Thu, 15 Jun 2006, Yann Dirson wrote:
> 
> In tha case of jam, the doc issue can certainly be raised, but the
> most prominent problem is probably that everyone and their dog knows
> make,

Oh, I agree. A "simpler" thing that people don't know is often much 
inferior to a complex thing that people are generally intimately familiar 
with.

I just personally believe that autoconf/automake are the worst of both 
worlds (ie it's a _complex_ thing that a lot of people don't know).

GNU make in many ways is actually not that bad. Yeah, the makefiles get 
more complex, but it's usually not totally unreadable, and you can do some 
clever stuff with it. 

The kernel makefiles are a pretty extreme example (and it hides a lot of 
the complexity in files that get included and that most people never ever 
need to look at). I suspect that git could more easily do something like 
that (on a _much_ smaller scale - don't get me wrong).

			Linus
