From: Paul Smith <psmith@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 14:29:38 -0400
Organization: GNU's Not UNIX!
Message-ID: <1192472978.8299.155.camel@homebase.localnet>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
	<4712B616.165BBF8D@dessent.net>
	<Pine.LNX.4.64.0710150217120.25221@racer.site>
	<Pine.LNX.4.64.0710150223230.25221@racer.site>
	<E1IhJ4K-00086x-5U@fencepost.gnu.org>
	<AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de>
	<E1IhLBW-0006uw-19@fencepost.gnu.org>
	<Pine.LNX.4.64.0710150946500.25221@racer.site>
	<E1IhNox-0004n2-N5@fencepost.gnu.org> <47135D85.50701@viscovery.net>
	<E1IhPCo-0004ZO-N9@fencepost.gnu.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: raa.lkml@gmail.com, prohaska@zib.de, make-w32@gnu.org,
	Johannes.Schindelin@gmx.de, ae@op5.se,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 21:40:03 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhUhd-0007cZ-JK
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 20:30:09 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhUhW-0006T3-OD
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 14:30:02 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhUhR-0006SD-Ro
	for make-w32@gnu.org; Mon, 15 Oct 2007 14:29:57 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhUhQ-0006Qg-1m
	for make-w32@gnu.org; Mon, 15 Oct 2007 14:29:57 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhUhP-0006QZ-U5
	for make-w32@gnu.org; Mon, 15 Oct 2007 14:29:55 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <psmith@gnu.org>)
	id 1IhUhJ-0003WL-IF; Mon, 15 Oct 2007 14:29:49 -0400
Received: from mr02.lnh.mail.rcn.net ([207.172.157.22])
	by smtp02.lnh.mail.rcn.net with ESMTP; 15 Oct 2007 14:29:41 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr02.lnh.mail.rcn.net (MOS 3.8.3-GA) with ESMTP id NXB65381;
	Mon, 15 Oct 2007 14:29:41 -0400 (EDT)
Received: from 65-78-30-67.c3-0.lex-ubr3.sbo-lex.ma.cable.rcn.com (HELO
	homebase.localnet) ([65.78.30.67])
	by smtp01.lnh.mail.rcn.net with ESMTP; 15 Oct 2007 14:31:19 -0400
Received: from psmith by homebase.localnet with local (Exim 4.67)
	(envelope-from <psmith@gnu.org>)
	id 1IhUh9-0003eQ-72; Mon, 15 Oct 2007 14:29:39 -0400
In-Reply-To: <E1IhPCo-0004ZO-N9@fencepost.gnu.org>
X-Mailer: Evolution 2.12.0 
X-Junkmail-Status: score=10/50, host=mr02.lnh.mail.rcn.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090204.4713B195.0179,ss=1,fgs=0,
	ip=207.172.4.11, so=2006-12-09 10:45:40,
	dmn=5.4.3/2007-09-06
X-detected-kernel: by monty-python.gnu.org: Genre and OS details not
	recognized.
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61026>

OK, enough.  I am extremely grateful for the porting and maintenance
efforts of the GNU make porting team (since I have no Windows--or Amiga,
or OS/2, or OpenVMS--systems to maintain these ports myself) and I'm not
going to choose a tool unless it supports their environment and helps
them to work more efficiently (or at least no less efficiently).  I'm
not interested in getting into a pissing match over which operating
system is better or worse, and I'm certainly not interested in unfounded
inferences as to the character and quality of my porting team based on
the operating system they are using.

For those who have provided details and pointers regarding the state of
GIT on Windows, thank you very much for your help: it's been very useful
and Eli and others sound like they have enough information to be getting
on with for now.  If you'd like to discuss some Windows porting issues
further there are a number of extremely knowledgeable Windows / FLOSS
programmers on the make-w32@gnu.org list--although they are generally
very busy.

If what you're interested in is self-congratulatory back-slapping over
the superiority of Linux/POSIX, please keep that on the GIT mailing
list, or else an advocacy forum somewhere.


I'm setting followups to the GIT list.

Cheers all!

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.mad-scientist.us
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
