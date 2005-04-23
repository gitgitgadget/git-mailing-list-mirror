From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 16:37:02 -0400
Message-ID: <1114288622.5228.1.camel@mulgrave>
References: <1114280570.5068.5.camel@mulgrave>
	 <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPRIp-0006HZ-Bb
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVDWUhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVDWUhQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:37:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38106 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261777AbVDWUhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:37:10 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3NKb2A09532;
	Sat, 23 Apr 2005 16:37:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 13:17 -0700, Linus Torvalds wrote:
> The attached patch was seriously corrupt. Did you edit it by hand? The 
> second chunk of the git-merge-one-file-script patch claims to have 12 
> source lines, but only has 11, causing patch no end of confusion.

OK ... yes I admit it ... the shame ... I noticed a problem after I
generated it and then edited it in source

> I fixed up the line counts by hand, and the end result looked almost sane,
> but when looking closer, I noticed the
> 
> 	+       if [ $ -ne 0 ]; then
> 	+               echo "ERROR: Leaving conflict merge in $src2"
> 	                exit 1
> 
> which just can't be right either ("$" never equals 0, so the above will 
> always report an error), so I assume that whatever editing you did was 
> really quite corrupt. Yeah, yeah, you obviously meant "$?", but the fact 
> is, your patch is bogus, and I don't trust it. Can you re-send a valid one 
> (and sign off on it).

Yes boss ... Just getting on a 'plane now.  Should be able to send it
out in an hour or so.

James


