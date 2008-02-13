From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Wed, 13 Feb 2008 08:55:37 +0100
Message-ID: <fou7pu$dpq$1@ger.gmane.org>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 14:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHcI-0005Wr-7R
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYBMNZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYBMNZH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:25:07 -0500
Received: from main.gmane.org ([80.91.229.2]:37869 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbYBMNZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:25:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JPHbi-0003uO-3g
	for git@vger.kernel.org; Wed, 13 Feb 2008 13:25:02 +0000
Received: from matrix-eth-s4p3c0.eurocontrol.fr ([192.93.23.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 13:25:02 +0000
Received: from younes by matrix-eth-s4p3c0.eurocontrol.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 13:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: matrix-eth-s4p3c0.eurocontrol.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73788>

Linus Torvalds wrote:
> 	   7.6% fs/afs/
> 	   7.6% fs/fuse/
> 	   7.6% fs/gfs2/
> 	   5.1% fs/jffs2/
> 	   5.1% fs/nfs/
> 	   5.1% fs/nfsd/
> 	   7.6% fs/reiserfs/
> 	  15.3% fs/
[...]
> For an example of the cumulative reporting, the above commit becomes
[...]
> 	   7.6% fs/afs/
> 	   7.6% fs/fuse/
> 	   7.6% fs/gfs2/
> 	   5.1% fs/jffs2/
> 	   5.1% fs/nfs/
> 	   5.1% fs/nfsd/
> 	   7.6% fs/reiserfs/
> 	  61.5% fs/


May I suggest this instead so to get rid of the cumulative option?

  	   7.6% fs/afs
  	   7.6% fs/fuse
  	   7.6% fs/gfs2
  	   5.1% fs/jffs2
  	   5.1% fs/nfs
  	   5.1% fs/nfsd
  	   7.6% fs/reiserfs
  	  15.3% fs/
  	  61.5% fs

A trailing slash would mean "no recursive, only this directory" and no 
trailing slash means well the opposite :-)

Abdel.
