From: Christopher Faylor <cgf-use-the-mailinglist-please@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:06:32 -0400
Message-ID: <20071016180632.GA24953@ednor.casa.cgf.cx>
References: <20071016155608.GA10603@old.davidb.org>
	<03f401c81010$d8833de0$2e08a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: 'Andreas Ericsson' <ae@op5.se>, barkalow@iabervon.org,
	raa.lkml@gmail.com, make-w32@gnu.org, git@vger.kernel.org,
	'Eli Zaretskii' <eliz@gnu.org>, Dave Korn <dave.korn@artimi.com>,
	Joh
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Tue Oct 16 20:07:22 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihqoa-0005ot-JD
	for gnu-make-w32@m.gmane.org; Tue, 16 Oct 2007 20:06:48 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhqoT-00034L-MI
	for gnu-make-w32@m.gmane.org; Tue, 16 Oct 2007 14:06:41 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhqoP-000342-68
	for make-w32@gnu.org; Tue, 16 Oct 2007 14:06:37 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhqoN-00033J-OC
	for make-w32@gnu.org; Tue, 16 Oct 2007 14:06:36 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhqoN-00033F-L1
	for make-w32@gnu.org; Tue, 16 Oct 2007 14:06:35 -0400
Received: from pool-70-20-17-24.bstnma.fios.verizon.net ([70.20.17.24]
	helo=cgf.cx) by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <cgf@cgf.cx>)
	id 1IhqoL-0006C6-A2; Tue, 16 Oct 2007 14:06:33 -0400
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])
	by cgf.cx (Postfix) with ESMTP id DF6A713C305;
	Tue, 16 Oct 2007 14:06:32 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)
	id DBEBB2B353; Tue, 16 Oct 2007 14:06:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <03f401c81010$d8833de0$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-detected-kernel: by monty-python.gnu.org: Linux 2.6 (newer, 1)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61234>

On Tue, Oct 16, 2007 at 05:23:11PM +0100, Dave Korn wrote:
>On 16 October 2007 16:56, David Brown wrote:
>
>> On Tue, Oct 16, 2007 at 02:25:21AM -0400, Eli Zaretskii wrote:
>> 
>>> On the other hand, what packages have 100K files?  If there's only one
>>> -- the Linux kernel -- then I think this kind of performance is for
>>> all practical purposes unimportant on Windows, because while it is
>>> reasonable to assume that someone would like to use git on Windows,
>>> assuming that someone will develop the Linux kernel on Windows is --
>>> how should I put it -- _really_ far-fetched ;-)
>> 
>> Oh, I wish others could think this clearly.  Quoting a serious line off of
>> a task list at an unnamed company:
>> 
>>    - Make Linux kernel compile under windows.
>> 
>> I don't think it will move past just being a wish list item, but there seem
>> to be people that think it should be done.
>> 
>> Admittedly, they don't want developers doing it on windows, but want to
>> integrate kernel building into a windows-heavy build and release process.
>
>  Do that kind of thing here all the time, hence my previous post.  Apart from
>the netfilter stuff with the filenames-that-match-in-all-but-case, no real
>problems, took me a couple of hours one afternoon.

Ditto.

Coincidentially enough this is the reason I wrote managed mode for cygwin's
mount.

But, we're pretty far off-topic aren't we?

cgf
