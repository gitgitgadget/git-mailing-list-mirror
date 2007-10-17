From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git - Had a few questions
 on Qgit; I like the GUI.
Date: Tue, 16 Oct 2007 22:02:49 -0700
Organization: Bluelane
Message-ID: <47159779.6010502@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <20070709173720.GS29994@genesis.frugalware.org>	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>	 <4713FA4A.5090501@bluelane.com>	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>	 <471433F3.40606@bluelane.com> <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
Reply-To: pete@bluelane.com, piet.delaney@gmail.piet.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii13t-0003cv-5L
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 07:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXJQFC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 01:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXJQFC6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 01:02:58 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56823 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751207AbXJQFC5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 01:02:57 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Oct 2007 01:02:55 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 17 Oct 2007 05:02:56.0219 (UTC) FILETIME=[FAF0AAB0:01C8107A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61331>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Costalba wrote:

Hi Marco:

I've gone back and tried my old Qgit 1.5.3 and it was
much closer in functionality to Bitkeeper.

> On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>> I just download 'meld', looks interesting, I didn't know about it or
>> 'kompare'. Linking either one into gitk would be a pleasant graphical
>> 'bling'.
>>
> 
> In case you are interested a git GUI viewer called qgit can spawn
> 'Kompare' , 'Meld' or any other diff tool that support 'two files'
> command line interface:
> 
> $my_preferred_diff_tool  file1.txt file2.txt
> 
> And they will show what you are looking for. The input files are
> prepared by qgit that also handles the housekeeping at the end.

While I'm looking at the diffs for a file if I pull down External Diff
it launches 'kcompare' but for a file with a large change it seems
to be running extremely slow. We have a file with 13,000 files in it
and I have two changes in the file, each is an addition and deletion
of about 100 lines in one contiguous block. If I click between them
it's fine but since the 100 lines is more than one page I try to
scroll thru the diff. At this point of time 'kompare' seems to be
using 95% of the CPU time and it takes about 10 seconds for it to
scroll. It scrolls fine in the qgit diff window. It;s not a problem
for small files. Know of what can me done so that 'kcompare' works
fast on large files; something like pointing it's tmp files to a
not NFS partition.


Another problem I've noticed is that sometime while running git
it seems to spend a large amount of time  switching from one
change-set to the next; seems to be due to all of the tagged
files.

> Another feature you asked, i.e. CTRL + right click to select a
> revision (different from the parent) to diff against the current one
> is also already implemented.

It seems that while I'm in "Rev List" mode I can select the the
two versions to compare a selected file with View->External diff...

Now, if I pull down "View File" or go to the file context were
you see the change-set for a file then I can't get the CTRL + right
click to allow me to diff two revisions of the file.

While messing around in this area of trying to diff two revision
of the file from the file context I got:
- ------------------------------------------------------------------
/nethome/piet/src/blux$ qgit
Saving cache. Please wait...
Compressing data...
Done.
Saving cache. Please wait...
Compressing data...
Done.
ASSERT in getAncestor: empty file from
e86306878efb575be80d070ac3dec49f8d358cd1
ASSERT in lookupAnnotation: no annotation for cli/quagga-0.96/lib/bluelane.c
ASSERT in remove: 8 is not the first in list
Thrown exception 'Canceling annotation'
Exception 'Canceling annotation' not handled in init...re-throw
terminate called after throwing an instance of 'i'
Aborted
/nethome/piet/src/blux$
- ------------------------------------------------------------------

MY guess is that I should install a newer version of qgit,
I'm using 1.5.3.

How difficult is it to upgrade to the Qt4. Can I just
install it to /usr/local and not interfere with Qt3?
Last I recall messing with installing ethereal from src
I needed a graphics lib and as I recall installing it in
/usr/local/ confused some build crap. It would be interesting
to try out your new qgit-2.0.

> 
> And of course the two above features can be integrated: you select two
> random revisions and then call the external diff viewer to check at
> the differences in the way you prefer.

Right, but how do I do this from the file context?

> 
> It is possible to download qgit from
> 
> http://sourceforge.net/project/showfiles.php?group_id=139897
> 
> 
> Two versions:
> 
> qgit-1.5.7 is Qt3 based
> 
> qgit-2.0 is Qt4 based (works also under Windows)

Picked up both, I'll start with qgit-1.5.7.

Installing qt4 might not be so easy; looking at:

	http://packages.qa.debian.org/q/qt4-x11.html

it seems to be pretty big. The date on 1.5.7 was very
close to 2.0 so I thought they might be very close in
functionality and you maintaining the same code for
both the common Qt3 and the new Qt4 to make it easy
for users to install.

Regards,
Piet

> 
> 
> 
> regards
> Marco

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFZd4JICwm/rv3hoRAgMVAJ0d49Sbbuppt8o5F1U7tbkaQjSQzwCfV0nn
mnFXyUWIKGhoxz7pqulJeVk=
=Jq+Y
-----END PGP SIGNATURE-----
