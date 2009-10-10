From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: hide find_parent_branch output in double
	quiet mode
Date: Fri, 9 Oct 2009 18:08:43 -0700
Message-ID: <20091010010843.GA30258@dcvr.yhbt.net>
References: <b01cac406b93d5c67e3ae2e9a7aaa498a52dd9fc@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Arlott <simon@fire.lp0.eu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQTm-0007hH-E1
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbZJJBJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934640AbZJJBJV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 21:09:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53686 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932936AbZJJBJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 21:09:20 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 2EF711F9B3;
	Sat, 10 Oct 2009 01:08:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b01cac406b93d5c67e3ae2e9a7aaa498a52dd9fc@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129869>

Simon Arlott <simon@fire.lp0.eu> wrote:
> Hide find_parent_branch logging when -qq is specified.
> This eliminates more unnecessary output when run from cron, e.g.:
> 
> Found possible branch point:
> http://undernet-ircu.svn.sourceforge.net/svnroot/undernet-ircu/ircu2/trunk =>
> http://undernet-ircu.svn.sourceforge.net/svnroot/undernet-ircu/ircu2/branches/authz,
> 1919
> Found branch parent: (authz) ea061d76aea985dc0208d36fa5e0b2249b698557
> Following parent with do_switch
> Successfully followed parent
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Thanks Simon,

Acked-by: Eric Wong <normalperson@yhbt.net>

and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong
