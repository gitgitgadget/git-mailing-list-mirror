From: David Kastrup <dak@gnu.org>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 14:43:22 +0100
Message-ID: <867ihgubk5.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
	<CFB8A272-863C-4758-91F7-E9669D70A200@zib.de>
	<20080207123108.GA12009@bit.office.eurotux.com>
	<alpine.LSU.1.00.0802071255110.8543@racer.site>
	<20080207130715.GA14000@bit.office.eurotux.com>
	<alpine.LSU.1.00.0802071324460.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 14:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN72v-0007MY-7Q
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbYBGNng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYBGNng
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:43:36 -0500
Received: from main.gmane.org ([80.91.229.2]:58178 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYBGNnf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:43:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JN72I-0003Cg-OH
	for git@vger.kernel.org; Thu, 07 Feb 2008 13:43:30 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:43:30 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:43:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:X31UPBdltjnqLGZG8qYs4JJvWNY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72944>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>
>> On Thu, Feb 07, 2008 at 12:55:58PM +0000, Johannes Schindelin wrote:
>> 
>> > On Thu, 7 Feb 2008, Luciano Rocha wrote:
>> > 
>> > > Why do I have to accept the GPL to install msysgit?
>> > 
>> > Because that's the only license you have to use git.
>> 
>> Again, GPL governs distribution, not use.
>
> The fine points on why installing it onto your computer is not a 
> distribution are just lost on me.

The GPLv3 might explain it better.

> Besides, if you do not like that our installer shows the GPL, just go
> and make your own (but be sure to shell out money to your lawyer of
> choice to confirm that the GPL allows you to do that).
>
> The Git installer of msysGit will always show the GPL, and have the
> user accept it.

What happens if the user does not accept it?  The license explicitly
states

    Activities other than copying, distribution and modification are not
    covered by this License; they are outside its scope.  The act of
    running the Program is not restricted, [...]

Obviously, one can't run the program without installing it.  The license
also states:

      5. You are not required to accept this License, since you have not
    signed it.  However, nothing else grants you permission to modify or
    distribute the Program or its derivative works.  These actions are
    prohibited by law if you do not accept this License.  Therefore, by
    modifying or distributing the Program (or any work based on the
    Program), you indicate your acceptance of this License to do so, and
    all its terms and conditions for copying, distributing or modifying
    the Program or works based on it.

Again, only modification and distribution are affected by
non-acceptance.  Talking about unrestricted running of the program would
be utterly non-sensical if you were not allowed to install it.

Of course, you can read this in the GPL FAQ if you want to.  There was a
similar problem for the Windows installer of Emacs IIRC (the underlying
program does not even consider the possibility of not agreeing to a
license) and there were proposals of changing the button texts to "This
is great" and something else.  I don't know what the people converged on
finally, not using Windows myself.

-- 
David Kastrup
