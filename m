From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 14:09:09 +0200
Message-ID: <99870CA9-D204-40C2-9BC5-2353EBE18816@zib.de>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de> <20070803030101.GI20052@spearce.org> <20070803125601.GA28323@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeuR-0002Bi-Qf
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbXHEMIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXHEMIc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:08:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:52541 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbXHEMIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:08:31 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75C8OLG013726;
	Sun, 5 Aug 2007 14:08:25 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75C8HB6029742
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 14:08:18 +0200 (MEST)
In-Reply-To: <20070803125601.GA28323@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55001>


On Aug 3, 2007, at 2:56 PM, J. Bruce Fields wrote:

> On Thu, Aug 02, 2007 at 11:01:01PM -0400, Shawn O. Pearce wrote:
>> Steffen, you seem to be more in-tune with the Mac UI standards
>> than I am.  Any suggestions on what I can do in git-gui to make
>> this feature more obvious to users?

 From time to time I have a look at the Apple Human Interface
Guidelines [1]. They contain large Apple specific sections but also
ideas of general interest.


>> I myself use a Mac OS X based PowerBook as my primary development
>> system, but I have to admit, I'm not the best GUI developer that has
>> ever walked on this planet.  Far far far from it.
>
> You're way ahead of me!
>
>> So I'd really love to do better.  But frankly I'm at a loss here
>> and just don't know what sort of change to make.
>
>> Side note: Someone recently asked me how to move individual files
>> to the left side of the UI (to stage them).  Apparently this person
>> had been using git-gui for months by just clicking "Add Existing"
>> (recently renamed to "Stage Changed").  It never occurred to the
>> user to try clicking the file's individual icons.  Or to select
>> the files they were interested in and look for a menu option that
>> might work on that selection.
>
> The one thing that struck me when I fired up git-gui was that it  
> wasn't
> obvious to me which things I should try clicking on.

I had the same experience. I didn't recognize that the document
icon left to a filename is actually a button with an action
attached to it. I thought it would be there just to distinguish
a file from a directory.

I'd tend to use kind of a push button instead of an icon to
indicate the action of adding a file to the index (staging).
Maybe an arrow facing left? And an arrow facing right to
unstage?


> For example: the buttons, drop-down menus, and check-boxes all cry out
> to be played with.  But the filenames in the lists at the top are less
> obvious, and it might never have occurred to me on my own to right- 
> click
> on the diff hunks at the bottom.  That just looks like passive  
> colorized
> text to me.
>
> I don't know what sort of user-interface conventions say "play with
> me!", though.  Random ideas:
>
> 	- maybe the cursor should change shape over the diff hunks (or
> 	  just the headers?)
> 	- maybe buttons, hunk headers, file names, etc., should all be
> 	  in the same color?
> 	- maybe the hunk headers could benefit from a little more
> 	  decoration?  I don't know how to do that without just making
> 	  the display look more cluttered, though.
> 	- maybe left-clicking on diff hunks should do something too?

In general it's always a good idea to make every action
accessible with only a single (left) mouse button. This
may seem ridiculous nowadays, but it really help to keep
things obvious. Right buttons and context menus have a
value for the experienced user to access things more
efficiently, but they should not be essential.

	Steffen

[1] http://developer.apple.com/documentation/UserExperience/ 
Conceptual/OSXHIGuidelines/index.html
