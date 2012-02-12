From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything
 else
Date: Sun, 12 Feb 2012 23:49:28 +0000
Message-ID: <20120212234928.GA4513@dcvr.yhbt.net>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
 <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
 <1328820742-4795-2-git-send-email-stevenrwalter@gmail.com>
 <20120212070353.GA30477@dcvr.yhbt.net>
 <CAK8d-aKJCBq2xpsz65hA4g8oa_szKaofLpkYB3v3_2dd=BAgiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 00:49:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwjAj-0007c5-U9
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 00:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab2BLXt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 18:49:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57182 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab2BLXt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 18:49:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848581FEED;
	Sun, 12 Feb 2012 23:49:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAK8d-aKJCBq2xpsz65hA4g8oa_szKaofLpkYB3v3_2dd=BAgiQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190594>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Sun, Feb 12, 2012 at 2:03 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > Steven Walter <stevenrwalter@gmail.com> wrote:
> >> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> >
> > Thanks, shall I fixup 2/2 and assume you meant to Sign-off on that, too?
> 
> Yes, thanks

Ugh, I got a bunch of test failures on t9100-git-svn-basic.sh with your
updated 1/2 and a trivially merged 2/2:

not ok - 7 detect node change from file to directory #2
not ok - 12 new symlink is added to a file that was also just made executable
not ok - 13 modify a symlink to become a file
not ok - 14 commit with UTF-8 message: locale: en_US.UTF-8
not ok - 16 check imported tree checksums expected tree checksums

1/2 alone seems to pass all existing tests.

I would very much appreciate new test cases that can show exactly what's
fixed by your patches  (esp given the only times I run/use git-svn is
when reviewing patches).  Thanks!.
