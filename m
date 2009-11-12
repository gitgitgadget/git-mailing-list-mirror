From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem with v1.6.5
Date: Thu, 12 Nov 2009 01:35:09 -0800
Message-ID: <20091112093509.GA617@dcvr.yhbt.net>
References: <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net> <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net> <20091111224454.GA16178@dcvr.yhbt.net> <4AFBADA9.3060401@obry.net> <20091112071121.GA569@dcvr.yhbt.net> <a2633edd0911120011u34d69100p1565ab5bf96a7709@mail.gmail.com> <a2633edd0911120103y688a2b2ah2c33c47de195ee81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8W5H-00017k-NL
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbZKLJfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbZKLJfF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:35:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37007 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbZKLJfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:35:04 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169271F679;
	Thu, 12 Nov 2009 09:35:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a2633edd0911120103y688a2b2ah2c33c47de195ee81@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132753>

Pascal Obry <pascal@obry.net> wrote:
> Eric,
> 
> > Will review the procedure for filtering branches :(
> 
> A quick review does not show something obviously wrong on my side.
> 
> The commit on the rewritten repo has a different sha-1 which is
> expected. So to me it seems that after a filter-branch on a git-svn
> repo it is mandatory to recreate all .rev_map*? Is that right? Is so,
> this is the missing piece in the procedure on my side.

Yes, you need to recreate all the .rev_map* files if you use
filter-branch.  Just remove them and they should be automatically
recreated for your case (not using --no-metadata or --use-svm-props)

-- 
Eric Wong
