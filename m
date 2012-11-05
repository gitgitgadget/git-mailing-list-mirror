From: Arthur <a.foulon@amesys.fr>
Subject: Re: git-p4 clone @all error
Date: Mon, 5 Nov 2012 02:02:27 -0800 (PST)
Message-ID: <1352109747598-7570575.post@n2.nabble.com>
References: <1351593879401-7570219.post@n2.nabble.com> <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com> <20121103231305.GB11267@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 11:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVJW2-000191-2s
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 11:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab2KEKCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 05:02:32 -0500
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:33393
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2KEKC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 05:02:29 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <a.foulon@amesys.fr>)
	id 1TVJVj-0003PG-L6
	for git@vger.kernel.org; Mon, 05 Nov 2012 02:02:27 -0800
In-Reply-To: <20121103231305.GB11267@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209056>

Hi,

Here is my import :

Importing from //depot@all into XXXXX
Initialized empty Git repository in
/home/arthur/projets_git/XXXXX/XXXXX/.git/
Importing revision 4258 (43%)
    Importing new branch depot/DEV_DATA

    Resuming with change 4258
Importing revision 5828 (63%)
    Importing new branch depot/RELEASE_1.0

    Resuming with change 5828
Importing revision 7720 (88%)
    Importing new branch depot/RELEASE_1.0.0

    Resuming with change 7720
Importing revision 8588 (100%)
Updated branches: DEV_DATA RELEASE_1.0 MAINLINE/02_SubSystem/10_ARINC_429
MAINLINE RELEASE_1.0.0 
fast-import failed: error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
error: unable to resolve reference
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429: Not a directory
error: Unable to lock
refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:     170000
Total objects:       169644 (    195421 duplicates                  )
      blobs  :        92182 (    186294 duplicates      74565 deltas)
      trees  :        70889 (      9127 duplicates      57686 deltas)
      commits:         6573 (         0 duplicates          0 deltas)
      tags   :            0 (         0 duplicates          0 deltas)
Total branches:           8 (         8 loads     )
      marks:           1024 (         0 unique    )
      atoms:          19603
Memory total:         19217 KiB
       pools:         12576 KiB
     objects:          6640 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =      19803
pack_report: pack_mmap_calls          =         65
pack_report: pack_open_windows        =         10 /         11
pack_report: pack_mapped              =  257715823 /  268009874
---------------------------------------------------------------------


Import crash after importing revision, my import have not files



--
View this message in context: http://git.661346.n2.nabble.com/git-p4-clone-all-error-tp7570219p7570575.html
Sent from the git mailing list archive at Nabble.com.
