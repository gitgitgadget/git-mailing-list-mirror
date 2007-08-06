From: Miles Bader <miles.bader@necel.com>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 12:45:19 +0900
Message-ID: <buovebtwckw.fsf@dhapc248.dev.necel.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<200708051411.25238.johan@herland.net>
	<20070805161117.GE28263@thunk.org>
	<200708052116.04140.johan@herland.net>
	<Pine.LNX.4.64.0708060112330.14781@racer.site>
	<buo1wehxssa.fsf@dhapc248.dev.necel.com>
	<Pine.LNX.4.64.0708060419230.14781@racer.site>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 05:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHtXX-0000Li-O0
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 05:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbXHFDpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 23:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbXHFDpk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 23:45:40 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35256 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbXHFDpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 23:45:39 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l763jKpd004153;
	Mon, 6 Aug 2007 12:45:20 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Mon, 6 Aug 2007 12:45:20 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Mon, 6 Aug 2007 12:45:20 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 3539B46F; Mon,  6 Aug 2007 12:45:19 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <Pine.LNX.4.64.0708060419230.14781@racer.site> (Johannes Schindelin's message of "Mon\, 6 Aug 2007 04\:21\:30 +0100 \(BST\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55104>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > I recommend against that, too.  All too often, I have some temporary files 
>> > in the working tree, and I'll be dimmed if I'm the only one.  So 
>> > "addremove" adds too much possibility for pilot errors.
>> 
>> "Recommend against it"?  Why?
>
> Didn't I say that? It just _asks_ for pilot errors.

Huh?  How is it any worse than the underlying commands it uses
("git add ." in particular)?!  Indeed, it seems rather less likely to
cause problems, because it has a rather odd name.

>> It's a separate command, so if it doesn't fit your working style, don't
>> use it.
>
> Hah!  If that were true, we'd have a lot less mails like "I tried this and 
> it did not work", only to find out that the person assumed that 
> documentation is for wimps, and tried a command that "sounded" like it 
> would do the right thing.

Git is not exactly a user-coddling, ultra-hand-holding application, nor
does it seem to have that as a goal.  It offers _tons_ of rope to hang
yourself if you wish (though it usually offers lots of ways to recover).

Rather git seems to have as a goal being a useful toolkit for managing
source trees, and based on what I've seen, tries to accomodate many
different styles of usage (rather than trying to force a certain style
down the users' throats -- as some VCSs try to do ...).

-miles

-- 
/\ /\
(^.^)
(")")
*This is the cute kitty virus, please copy this into your sig so it can spread.
