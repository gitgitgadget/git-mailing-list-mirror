From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: OT: data destruction classics (was: Re: Error converting from
 1.4.4.1 to 1.5.0?)
Date: Wed, 14 Feb 2007 18:51:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
References: <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
 <17875.36879.872210.264473@lisa.zopyra.com> <45D3B4E7.8050408@fs.ei.tum.de>
 <20070215021345.GB29732@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHWlg-0001M3-FQ
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbXBOCy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbXBOCy2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:54:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59581 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880AbXBOCy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:54:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1F2pAhB026202
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 18:51:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1F2p9pw018019;
	Wed, 14 Feb 2007 18:51:09 -0800
In-Reply-To: <20070215021345.GB29732@spearce.org>
X-Spam-Status: No, hits=-0.411 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39794>



On Wed, 14 Feb 2007, Shawn O. Pearce wrote:

> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> > Bill Lear wrote:
> > >I'm still muttering to myself that I could be that dumb...
> > 
> > Still better than trying to backup with
> > 
> > tar czvf data* destfile.tar.gz
> > 
> > automatic tape backup is a real helper then :)
> 
> or manual backup to "tape", where the tape device supplied was
> the only disk...  SunOS 4 did not take too kindly to its kernel,
> swap space, root fs being overwritten...

Hey, I can beat that (stop me at any time you've heard this story. No? Ok, 
then..)

I auto-dialed my harddisk. 

I had this auto-dialer, that would send "+++" + "atz" + "atdt..." to dial 
the number to the university dial-in farm that was always busy for hours 
at a time, and since I've never been much of a user interface person ("No 
really? Linus, please tell more! I would never have guessed!"), it was 
basically

	autodial /dev/ttyS1

or something very similar. It was really stupid too, so if it got some 
other answer than "BUSY" or "CONNECTED" back (or timed out), it would just 
go on to the next number and try again.

Anyway, the smarter among you will already see how I by mistake filled up 
one of my harddisk partitions with Hayes "AT" modem commands, and deleted 
my Minix installation. AND THE BASTARD NEVER ANSWERED!

That was one big (perhaps _the_) impetus for just deciding to make Linux 
good enough that I wouldn't need to actually reinstall Minix. Happily, it 
was already able to bootstrap itself at that point, it just wasn't quite 
as good yet. I fixed that in short order, and indeed, I never did end up 
feeding the 17 floppy disks into my computer to reinstall Minix.

Moral of the story: "Stupidity is what makes the world go round."

Or something like that.

			Linus
