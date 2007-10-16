From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:47:52 +0200
Message-ID: <86sl4bjkef.fsf@lola.quinscape.zz>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710151859590.7638@iabervon.org>
	<uodezisvg.fsf@gnu.org>
	<Pine.LNX.4.64.0710160032020.7638@iabervon.org>
	<E1IhgT2-0000bg-O6@fencepost.gnu.org>
	<Pine.LNX.4.64.0710161335260.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 15:09:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmAN-0002iv-7R
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbXJPNIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbXJPNIo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:08:44 -0400
Received: from main.gmane.org ([80.91.229.2]:47226 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152AbXJPNIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:08:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ihm2w-00064w-JU
	for git@vger.kernel.org; Tue, 16 Oct 2007 13:01:19 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 13:01:18 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 13:01:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:9qzkEau0QYh2JjSKiQC9buW7Fxg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61162>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> [culled make-w32, as per explicit request]
>
> On Tue, 16 Oct 2007, Eli Zaretskii wrote:
>
>> > Date: Tue, 16 Oct 2007 01:56:46 -0400 (EDT)
>> > From: Daniel Barkalow <barkalow@iabervon.org>
>> > cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se, 
>> >     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
>> > 
>> > Ah, that's helpful. We don't actually care too much about the 
>> > particular info in stat; we just want to know quickly if the file has 
>> > changed, so we can hash only the ones that have been touched and get 
>> > the actual content changes.
>> 
>> As I wrote in my other message, using native APIs improves
>> performance by at least a factor of two.
>
> Somehow this does not appeal to my "portability is good" side.  You
> know, if we had to do such trickeries for every platform we support,
> we'd soon be as big as Subversion *cough*.

With a reasonable way of factoring out things, the per-platform
overhead should be tolerable.

> For me, this is the most annoying part about programming Win32.
> They went out of their way to make it incompatible with everything
> else, and as a consequence it is a PITA to maintain crossplatform
> programs.

Well, they certainly score high on the "almost, but not quite,
entirely unlike tea" metric.  Enough compatibility to make it into
projects with cross-platform specifications, and enough
incompatibility to make it inconvenient to support anything but
Windows once they made it into the door.

-- 
David Kastrup
