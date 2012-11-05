From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 clone @all error
Date: Mon, 5 Nov 2012 17:12:12 -0500
Message-ID: <20121105221212.GA12003@padd.com>
References: <1351593879401-7570219.post@n2.nabble.com>
 <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com>
 <20121103231305.GB11267@padd.com>
 <1352109747598-7570575.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Arthur <a.foulon@amesys.fr>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVUuE-0008Od-PU
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 23:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350Ab2KEWMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 17:12:18 -0500
Received: from honk.padd.com ([74.3.171.149]:40879 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933111Ab2KEWMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 17:12:17 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 68A5BD27;
	Mon,  5 Nov 2012 14:12:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9166E22B75; Mon,  5 Nov 2012 17:12:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1352109747598-7570575.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209087>

a.foulon@amesys.fr wrote on Mon, 05 Nov 2012 02:02 -0800:
> Hi,
> 
> Here is my import :
> 
> Importing from //depot@all into XXXXX
> Initialized empty Git repository in
> /home/arthur/projets_git/XXXXX/XXXXX/.git/
> Importing revision 4258 (43%)
>     Importing new branch depot/DEV_DATA
> 
>     Resuming with change 4258
> Importing revision 5828 (63%)
>     Importing new branch depot/RELEASE_1.0
> 
>     Resuming with change 5828
> Importing revision 7720 (88%)
>     Importing new branch depot/RELEASE_1.0.0
> 
>     Resuming with change 7720
> Importing revision 8588 (100%)
> Updated branches: DEV_DATA RELEASE_1.0 MAINLINE/02_SubSystem/10_ARINC_429
> MAINLINE RELEASE_1.0.0 
> fast-import failed: error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> error: unable to resolve reference
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
> error: Unable to lock
> refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:     170000
> Total objects:       169644 (    195421 duplicates                  )
>       blobs  :        92182 (    186294 duplicates      74565 deltas)
>       trees  :        70889 (      9127 duplicates      57686 deltas)
>       commits:         6573 (         0 duplicates          0 deltas)
>       tags   :            0 (         0 duplicates          0 deltas)
> Total branches:           8 (         8 loads     )
>       marks:           1024 (         0 unique    )
>       atoms:          19603
> Memory total:         19217 KiB
>        pools:         12576 KiB
>      objects:          6640 KiB
> ---------------------------------------------------------------------
> pack_report: getpagesize()            =       4096
> pack_report: core.packedGitWindowSize =   33554432
> pack_report: core.packedGitLimit      =  268435456
> pack_report: pack_used_ctr            =      19803
> pack_report: pack_mmap_calls          =         65
> pack_report: pack_open_windows        =         10 /         11
> pack_report: pack_mapped              =  257715823 /  268009874
> ---------------------------------------------------------------------
> 
> 
> Import crash after importing revision, my import have not files

Thanks, that is interesting output.

Adding Vitor who knows his way around the branch detection
code.  The first mail by Arthur is here, which focuses more
on the backtrace from "p4 describe" errors, but also suggests
something is dodgy in branch detection:

    http://thread.gmane.org/gmane.comp.version-control.git/208693

I'm not sure if this is a --verbose run, though, as I don't see
any chatter like "branch is xxx".  So I'm not sure if the
auto-parent detection code got run.

The "unable to resolve reference" comes from refs.c, which is
when fast-import calls update_branch() on each of the changed
branches as it is finishing.

Vitor, what could git-p4 have done to create a branch name called
"refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429"?
Any other questions for Arthur?

		-- Pete
