From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Fri, 23 Jun 2006 16:16:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606231615150.6483@g5.osdl.org>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:16:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftut4-0003hi-T1
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbWFWXQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbWFWXQ2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:16:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752171AbWFWXQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 19:16:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5NNGNUT029802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Jun 2006 16:16:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5NNGMZF001723;
	Fri, 23 Jun 2006 16:16:22 -0700
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624011538.9bb179e7.tihirvon@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22453>



On Sat, 24 Jun 2006, Timo Hirvonen wrote:
>
> This patch series cleans up diff output format options.
> 
> This makes it possible to use any combination of --raw, -p, --stat and
> --summary options and they work as you would expect.

Looks good to me. I'll be very happy never having to remember the option 
(or type) --patch-with-stat ever again. Doing just "-p --stat" is just 
_so_ much better.

		Linus
