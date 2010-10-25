From: Drew Northup <drew.northup@maine.edu>
Subject: Re: fsck errors on newly cloned, newly imported git repository
Date: Mon, 25 Oct 2010 06:58:02 -0400
Message-ID: <1288004282.819.26.camel@drew-northup.unet.maine.edu>
References: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Herrick <mike.herrick@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 13:00:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKnB-00020t-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 13:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab0JYLAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 07:00:35 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:43657 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0JYLAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 07:00:35 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9PAw7uf005537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Oct 2010 06:58:12 -0400
In-Reply-To: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9PAw7uf005537
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288609177.64096@+kBVP7USwAWtVWveTLQkLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159943>


On Sun, 2010-10-24 at 11:54 -0400, Mike Herrick wrote:
> This weekend we're cutting over to use git for our source code control
> system.  I've imported about 20 years worth of previous history using
> "git cvsimport" (takes about four hours).  I then cloned the resulting
> repository onto five different machines (four Linux, one Solaris).
> I've set up a cron job to do a nightly "git fsck" on each of the five
> machines, and last night, two of the machines reported fsck errors on
> their initial run.  
<snip>

> The errors reported on these two machines were different, but what's
> interesting is that all of the missing blobs refer to various
> revisions of the same file, namely our "Changes" file (which is
> updated with each change).  It's also the largest file in our
> repository (3.3M).  I immediately started looking at logs to see if
> there was any indication of disk corruption and found none (no SMART
> errors either).  Both of these machines have been stable over a
> multi-year period of time (no unexplained crashes).  They're also
> older Linux machines (running  2.6.5-1.358 and  2.6.1-1.65, with
> relatively little memory: 1GB and .5GB), but with newly installed
> version of git (1.7.3.1).  I initially used git-daemon for the clone
> process, but even using ssh, I still see fsck errors on the resulting
> clones on these two machines.

Did you "git fsck" BEFORE you attempted to clone? Is it ONLY clones
showing errors? Alas, no blatant evidence of disk corruption is not
evidence of no disk corruption as well.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
