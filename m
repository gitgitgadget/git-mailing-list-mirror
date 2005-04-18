From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 18:14:51 -0500
Message-ID: <1113866092.4998.92.camel@mulgrave>
References: <1113856118.4998.70.camel@mulgrave>
	 <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:11:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfOk-0005if-12
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDRXPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRXPN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:15:13 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:37504 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261170AbVDRXPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 19:15:04 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3INEqA20608;
	Mon, 18 Apr 2005 19:14:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 14:39 -0700, Linus Torvalds wrote:
> > Linus, the rc-fixes repo is ready for applying ... it's the same one I
> > announced on linux-scsi and lkml a while ago just with the git date
> > information updated to be correct (the misc one should wait until after
> > 2.6.12 is final).
> 
> Ok. Can you verify? I did a "git diff" between your old head and my new
> head, and it did not show any SCSI files (only the expected arm etc stuff
> that you didn't have in your), so it all _looks_ good. But hey, just to
> make sure that I didn't do anything stupid..

Actually, the verify fails, according to bitkeeper.

It looks like the merge tree has contamination from the scsi-misc-2.6
tree ... possibly because the hosting system got the merged objects when
I pushed.

Could you strip it back and I'll check out the repos on www.parisc-
linux.org?

Thanks,

James


