From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] merge-one-file: remove empty directories
Date: Sun, 20 Nov 2005 09:17:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com>
	<20051119140736.GA24901@lst.de>
	<Pine.LNX.4.64.0511190957320.13959@g5.osdl.org>
	<7v4q683qhe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, linuxppc64-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Git Mailing List <git@vger.kernel.org>
X-From: linuxppc64-dev-bounces@ozlabs.org Sun Nov 20 18:18:17 2005
Return-path: <linuxppc64-dev-bounces@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdspG-0008NL-68
	for glppd-linuxppc64-dev@m.gmane.org; Sun, 20 Nov 2005 18:18:03 +0100
Received: from ozlabs.org (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 24FA9687A5;
	Mon, 21 Nov 2005 04:17:57 +1100 (EST)
X-Original-To: linuxppc64-dev@ozlabs.org
Delivered-To: linuxppc64-dev@ozlabs.org
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A2CA681C2
	for <linuxppc64-dev@ozlabs.org>; Mon, 21 Nov 2005 04:17:55 +1100 (EST)
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAKHHenO007357
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 20 Nov 2005 09:17:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAKHHcEA010022;
	Sun, 20 Nov 2005 09:17:39 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q683qhe.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: linuxppc64-dev@ozlabs.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: 64-bit Linux on PowerPC Developers Mail List
	<linuxppc64-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc64-dev>
List-Post: <mailto:linuxppc64-dev@ozlabs.org>
List-Help: <mailto:linuxppc64-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc64-dev-bounces@ozlabs.org
Errors-To: linuxppc64-dev-bounces@ozlabs.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12387>



On Sat, 19 Nov 2005, Junio C Hamano wrote:
> 
> [jc: We probably could use "rmdir -p", but for now we do that by
> hand for portability.]

Some googling seems to imply that "-p" is pretty much globally available.

It's in POSIX.1, but more importantly, it seems to actually be actively 
used in BSD projects, and I found a man-page with copyright date in -92 
(SCO of all places) which mentiones AT&T SVID2 - but not the more modern 
standards.

Even VMS seems to have it (although if git is ever ported to VMS, I'll 
just have to shoot myself. I used VMS in -88, and the scars are _still_ 
fresh).

			Linus
