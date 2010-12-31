From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 0/3] Submodule filtering for filter-branch
Date: Fri, 31 Dec 2010 18:20:13 +0100
Message-ID: <201012311820.13863.j6t@kdbg.org>
References: <cover.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: jeffrey.freeman@syncleus.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 31 18:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYieR-0001u8-3H
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 18:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab0LaRUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 12:20:17 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:19433 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753701Ab0LaRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 12:20:16 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1BC70130048;
	Fri, 31 Dec 2010 18:20:14 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E8E2919F69E;
	Fri, 31 Dec 2010 18:20:13 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <cover.1293809100.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164392>

On Freitag, 31. Dezember 2010, Thomas Rast wrote:
> Jeffrey Phillips Freeman aka tty1 asked on IRC about a way to fix the
> super-project after rewriting submodules.  This quick series provides
> some extra tricks in the filter-branch toolbox that can be plumbed
> together to achieve this (see the last commit's message), and should
> hopefully be general enough to be of other use too.

I like the --dump-map and --load-map options. But I think that 
a --submodule-filter is not necessary; it is just a 
particular --index-filter, and IMO should be part of the documentation in the 
form of an example that illustrates how to use the new options.

-- Hannes
