From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: avoid self-referencing mergeinfo
Date: Thu, 4 Apr 2013 01:31:31 +0000
Message-ID: <20130404013131.GA18539@dcvr.yhbt.net>
References: <20130330220642.GA14641@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bryan Jacobs <bjacobs@woti.com>,
	Avishay Lavie <avishay.lavie@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Contreras <michael@inetric.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 03:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNZ20-0005Cq-NU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 03:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762721Ab3DDBbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 21:31:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40241 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760095Ab3DDBbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 21:31:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C681F5B8;
	Thu,  4 Apr 2013 01:31:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130330220642.GA14641@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219983>

Michael Contreras <michael@inetric.com> wrote:
> When svn.pushmergeinfo is set, the target branch is included in the
> mergeinfo if it was previously merged into one of the source branches.
> SVN does not do this.
> 
> Remove merge target branch path from resulting mergeinfo when
> svn.pushmergeinfo is set to better match the behavior of SVN. Update the
> svn-mergeinfo-push test.
> 
> Signed-off-by: Michael Contreras <michael@inetric.com>
> Reported-by: Avishay Lavie <avishay.lavie@gmail.com>

Acked-by: Eric Wong <normalperson@yhbt.net>

80-column wrapped version pushed to git://bogomips.org/git-svn master
(commit e5ee78e1f0835410a37bfa38e1ff5e1a82f8c7b5)

Will ask Junio to pull unless Sam (our mergeinfo expert) gives a NACK
soon.
