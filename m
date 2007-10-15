From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 02:08:03 -0400
Message-ID: <E1IhJ7T-0008AC-8b@fencepost.gnu.org>
References: <20071014221446.GC2776@steel.home>
	<023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
	<20071015000347.GA13033@old.davidb.org>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, make-w32@gnu.org, Johannes.Schindelin@gmx.de, ae@op5.se,
	git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 08:08:18 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhJ7h-0005nU-LA
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 08:08:17 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhJ7b-00020K-09
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 02:08:11 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhJ7W-000205-D2
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:08:06 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhJ7V-0001zt-2W
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:08:05 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhJ7U-0001zq-Rt
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:08:04 -0400
Received: from fencepost.gnu.org ([140.186.70.10])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhJ7U-0002bB-If
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:08:04 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhJ7T-0008AC-8b; Mon, 15 Oct 2007 02:08:03 -0400
In-reply-to: <20071015000347.GA13033@old.davidb.org> (message from David Brown
	on Sun, 14 Oct 2007 17:03:47 -0700)
X-detected-kernel: by monty-python.gnu.org: Linux 2.6, seldom 2.4 (older, 4)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60950>

> Date: Sun, 14 Oct 2007 17:03:47 -0700
> From: David Brown <git@davidb.org>
> Cc: 'Andreas Ericsson' <ae@op5.se>, 'Alex Riesen' <raa.lkml@gmail.com>,
> 	'git list' <git@vger.kernel.org>,
> 	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
> 	'Make Windows' <make-w32@gnu.org>
> 
> The MS exec* calls just concatenate all of the argv arguments, separating
> them with a space into a single buffer.

True.

> If you know what the library on the other end is doing to re-parse the
> arguments back into separate strings, it might be possible to quote things
> enough to handle names with spaces, but it is hard.

It's not hard, it's just a bit of work.  And it needs to be done
exactly once.
