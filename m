From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 20:09:47 +0000
Message-ID: <20130502200947.GA26623@dcvr.yhbt.net>
References: <1438528085.20130501090926@gmail.com>
 <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org>
 <455264907.20130501235104@gmail.com>
 <20130501213031.GA13056@dcvr.yhbt.net>
 <909519096.20130502075117@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 22:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzpA-0006Qo-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 22:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762014Ab3EBUJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 16:09:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59787 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761277Ab3EBUJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 16:09:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1941F42E;
	Thu,  2 May 2013 20:09:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <909519096.20130502075117@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223260>

Ilya Basin <basinilya@gmail.com> wrote:
> EW> My personal philosophy has always been: git svn users should leave
> EW> no trace or indication they're using a non-standard SVN client.
> 
> Placeholders aren't pushed back to svn.

Right, I was confused, as I often am :x
