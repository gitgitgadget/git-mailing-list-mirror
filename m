From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 17:45:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191744550.2553@g5.osdl.org>
References: <200509172141.31591.dtor_core@ameritech.net>
 <200509182333.58227.dtor_core@ameritech.net> <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
 <200509191909.22026.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:46:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWGl-0005d5-FV
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVITAps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVITAps
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:45:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbVITAps (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:45:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K0jkBo021795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 17:45:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K0jiY8026822;
	Mon, 19 Sep 2005 17:45:45 -0700
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200509191909.22026.dtor_core@ameritech.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8939>



On Mon, 19 Sep 2005, Dmitry Torokhov wrote:
>
> Yes, plain git-init-db produces the garbage.

Hmm. It doesn't do it for me, but I suspect it will be obvious where it
happens if you send us the output from "strace git-init-db"

Thanks,

		Linus
