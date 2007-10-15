From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 10:56:18 +0200
Message-ID: <86k5popxhp.fsf@lola.quinscape.zz>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
	<E1IhIwR-0006be-Ki@fencepost.gnu.org>
	<Pine.LNX.4.64.0710150936070.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: raa.lkml@gmail.com, make-w32@gnu.org, ae@op5.se, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 13:06:46 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNlv-0000eR-2a
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 13:06:07 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhNlo-0003k3-8s
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 07:06:00 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhLkO-0008Uf-2o
	for make-w32@gnu.org; Mon, 15 Oct 2007 04:56:24 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhLkL-0008Sg-JE
	for make-w32@gnu.org; Mon, 15 Oct 2007 04:56:22 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhLkK-0008SY-Vt
	for make-w32@gnu.org; Mon, 15 Oct 2007 04:56:21 -0400
Received: from pc3.berlin.powerweb.de ([62.67.228.11])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>) id 1IhLkK-0006M6-98
	for make-w32@gnu.org; Mon, 15 Oct 2007 04:56:20 -0400
Received: from quinscape.de (dslnet.212-29-44.ip210.dokom.de [212.29.44.210]
	(may be forged))
	by pc3.berlin.powerweb.de (8.9.3p3/8.9.3) with ESMTP id KAA08951
	for <make-w32@gnu.org>; Mon, 15 Oct 2007 10:56:17 +0200
X-Delivered-To: <make-w32@gnu.org>
Received: (qmail 14400 invoked from network); 15 Oct 2007 08:56:19 -0000
Received: from unknown (HELO lola.quinscape.zz) ([10.0.3.43])
	(envelope-sender <dak@gnu.org>)
	by ns.quinscape.de (qmail-ldap-1.03) with SMTP
	for <raa.lkml@gmail.com>; 15 Oct 2007 08:56:19 -0000
Received: by lola.quinscape.zz (Postfix, from userid 1001)
	id DF4288F264; Mon, 15 Oct 2007 10:56:18 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710150936070.25221@racer.site> (Johannes
	Schindelin's message of "Mon\,
	15 Oct 2007 09\:44\:12 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-detected-kernel: by monty-python.gnu.org: Linux 2.4-2.6
X-Mailman-Approved-At: Mon, 15 Oct 2007 07:05:27 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60982>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 15 Oct 2007, Eli Zaretskii wrote:
>
>> > Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
>> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr, 
>> >     git@vger.kernel.org, make-w32@gnu.org
>> > 
>> > The problem is not so much opening, but determining if an existing file 
>> > and a file in the index have the same name.
>> > 
>> > For example, "README" in the index, but "readme" in the working directory, 
>> > will be handled as "deleted/untracked" by the current machinery.  IOW git 
>> > will not know that what it gets from readdir() as "readme" really is the 
>> > same file as "README" in the index.
>> 
>> That's because you think file names are simple strings and can be
>> compared by simple string comparison.
>
> Almost...
>
>> This na?ve view is not true even on POSIX systems: "foo/bar" and 
>> "/a/b/foo/bar" can be the same file, as well as "/a/b/c/d" and "/x/y/z", 
>> given the right symlinks.
>
> ... not quite, ah ...
>
>> But for some reason that eludes me, people who are accustomed to POSIX
>> stop right there and in effect say "file names are strings, if we only
>> make them absolute and resolve links".
>
> ... yes!  There you have it.  Absolute filenames, resolved by
> readlink() are assumed to be the unique (!) identifiers for the
> contents.

They aren't.  One can mount the same file system several times in
different places.  In Linux, one can even mount directories and files
to several places at once.  Most Unices also support some
case-insensitive file systems, and readlink does not canonicalize the
casing.

> _Note:_ absolute paths _without_ readlink() resolving are _still_
> unique identifiers; this time for files/symlinks.

Not even that.  A unique identifier for files would imply that
touching the file does not affect, say, the access times of files with
other unique identifiers.

-- 
David Kastrup
