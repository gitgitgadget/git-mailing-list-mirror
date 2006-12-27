From: Junio C Hamano <junkio@cox.net>
Subject: Re: http git and curl 7.16.0
Date: Wed, 27 Dec 2006 11:53:58 -0800
Message-ID: <7vlkkt5d49.fsf@assigned-by-dhcp.cox.net>
References: <skimo@kotnet.org>
	<200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>,
	George Sherwood <pilot@beernabeer.com>, skimo@liacs.nl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 20:54:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzeql-0001ZK-AO
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 20:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWL0TyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 14:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWL0TyD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 14:54:03 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42629 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbWL0TyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 14:54:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227195400.KMLL16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 14:54:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3vuC1W00P1kojtg0000000; Wed, 27 Dec 2006 14:54:14 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 27 Dec 2006 11:57:46 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35477>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Sven Verdoolaege <skimo@kotnet.org> wrote:
>> On Sat, Nov 18, 2006 at 08:07:08AM +0400, George Sherwood wrote:
>> > I seem to be having a problem doing an http checkout with git built
>> > with curl 7.16.0 enabled.  If I build against curl 7.16.0 and try a
>> > clone, I get:
> ...
>> > git clone http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git
>> > error: Unable to start request error: Could not interpret heads/master
>> > as something to pull
>> > 
>> > If I rebuild git against curl 7.15.5 then I get:
>> [..]
>> > and the checkout finishes.
>> > 
>> > Has any one else seen this?
>
>> FWIW, I've seen the same with curl 7.16.0 on a Solaris 9 machine.
>> It worked fine with curl 7.15.0.
>
> It works fine for me on Aurora Corona (sparc) with curl-7.15.5-1.al3, while
> it fails as above on Fedora rawhide (i386) with curl-7.16.0-4.fc7.
>
> Furthermore, with new curl pulling from HTTP repos when there are updates
> gives double free errors and a crash.

Hmmm.  Could somebody please run http-fetch under gdb and see
where it breaks?  The exact command line you need to use would
be obtainable by running "sh -x git-clone" once.

[jc: Nick CC'ed, although I haven't seen him on the list for
some time...]
