From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 21:19:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
 <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 06:20:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGXx-0007cP-Vw
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWDCEUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWDCEUF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:20:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964809AbWDCEUC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 00:20:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k334JwEX004221
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 21:19:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k334JvTt002374;
	Sun, 2 Apr 2006 21:19:58 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18308>



On Sun, 2 Apr 2006, Davide Libenzi wrote:
> 
> Tomorrow I'll take a look at it.

Thanks. I've made the first "release" (2.6.17-rc1) with the new built-in 
diff, let's see if somebody has any issues.

But just the fact that I could do an almost 24MB diff (6MB compressed) 
with 738 _thousand_ lines in about 4 seconds is damn nice. The script I 
use to cut releases (logs, diffstats, tar-files etc) used to take a long 
time with BK, these days it's a couple of seconds.

		Linus
