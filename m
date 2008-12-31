From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 02:30:46 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	<git@vger.kernel.org>
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 03:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHqsX-0006Nl-SA
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbYLaCax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYLaCav
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:30:51 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:32658 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754198AbYLaCav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 21:30:51 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
thread-index: Aclq7piCwkgZURkMTr+Pp/nqGuO/WAAAQ1tQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104240>

MERCURIAL:

Update
hg update [-C] [-d DATE] [[-r] REV] 

Update the repository's working directory (the "working copy") to the
specified revision of the repository or to the tip revision of the
current (named) branch if no revision is specified.  

> I'm not looking for much....

-----Original Message-----
From: Jeff Whiteside [mailto:jeff.m.whiteside@gmail.com] 
Sent: 31 December 2008 02:22
To: Daniel Barkalow
Cc: Conor Rafferty; Boyd Stephen Smith Jr.; git@vger.kernel.org
Subject: Re: for newbs = little exercise / tutorial / warmup for windows
and other non-sophisticated new Git users :-) [Scanned]

wtf is wrong with

git checkout <something>

??

if you must have

git checkout <something> <paths>

then instead use

git checkout <something> <paths>
git clean

but you will lose other files that aren't part of the repo but are still
in the project's dir (i.e. untracked files).

On Tue, Dec 30, 2008 at 4:15 PM, Daniel Barkalow <barkalow@iabervon.org>
wrote:
> On Tue, 30 Dec 2008, Conor Rafferty wrote:
>
>> I don't understand, sorry. I thought I'd already removed all files 
>> from the local tree, in the $ rm *.* move just above the checkout
>
> That removes them from the filesystem, but they're still in the index.

> And "git checkout <something> ." first gets everything that *is* in 
> "." in <something> into the index, and then gets everything from "." 
> in the index into the filesystem.
>
> I suppose it is questionable as to whether it ought to copy paths that

> aren't in versionA from the index into the filesystem.
>
> To see this in a bit more detail, do:
>
> $ rm *.*
> $ git status
> (notice that the deletes are in the "won't be committed" section)
>
> Now, "git checkout <path>" will discard any changes in the "won't be 
> committed" section for that path. Maybe "git checkout versionA <path>"
> should only discard changes that are in the "won't be committed" 
> section for filenames that match that path and are in versionA (or are
> *different* in versionA and not removed?), but I think it's an area 
> where, if you're expecting any particular behavior out of that 
> command, you're likely to be surprised in some way in some situation.
>
>        -Daniel
> *This .sig left intentionally blank*
> --
> To unsubscribe from this list: send the line "unsubscribe git" in the 
> body of a message to majordomo@vger.kernel.org More majordomo info at

> http://vger.kernel.org/majordomo-info.html
>
