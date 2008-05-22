From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Fri, 23 May 2008 00:31:16 +0200
Message-ID: <200805230031.16150.johan@herland.net>
References: <alpine.LNX.1.00.0805221759430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri May 23 00:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJLL-0006x8-Ep
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760250AbYEVWcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760437AbYEVWcH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:32:07 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56019 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759770AbYEVWcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:32:05 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1A0062DJWUZ400@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:31:42 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1A00KOQJW4O540@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:31:16 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1A004FUJW49QE1@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:31:16 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0805221759430.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82662>

On Friday 23 May 2008, Daniel Barkalow wrote:
> From: Johan Herland <johan@herland.net>
> 
> The first test in this series tests "git clone -l -s --reference B A C",
> where repo B is a superset of repo A (A has one commit, B has the same
> commit plus another). In this case, all objects to be cloned are already
> present in B.
> 
> However, we should also test the case where the "--reference" repo is a
> _subset_ of the source repo (e.g. "git clone -l -s --reference A B C"),
> i.e. some objects are not available in the "--reference" repo, and will
> have to be found in the source repo.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Thanks for the resend.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
