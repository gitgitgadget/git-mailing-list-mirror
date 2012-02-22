From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.perl: fix a false-positive in the "already
 exists" test
Date: Wed, 22 Feb 2012 00:33:17 +0000
Message-ID: <20120222003317.GA1069@dcvr.yhbt.net>
References: <20120219105442.GA11889@dcvr.yhbt.net>
 <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S009K-0004ts-8T
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab2BVAdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:33:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42202 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2BVAdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:33:19 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09131F7A8;
	Wed, 22 Feb 2012 00:33:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191204>

Steven Walter <stevenrwalter@gmail.com> wrote:
> open_or_add_dir checks to see if the directory already exists or not.
> If it already exists and is not a directory, then we fail.  However,
> open_or_add_dir did not previously account for the possibility that the
> path did exist as a file, but is deleted in the current commit.
> 
> In order to prevent this legitimate case from failing, open_or_add_dir
> needs to know what files are deleted in the current commit.
> Unfortunately that information has to be plumbed through a couple of
> layers.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>

Thanks, will push.
Acked-by: Eric Wong <normalperson@yhbt.net>
