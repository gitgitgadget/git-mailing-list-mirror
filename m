From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH ld/maint-diff-quiet-w] Windows: redirect
 fopen("/dev/null") to fopen("nul")
Date: Thu, 25 Feb 2010 11:20:32 -0500
Message-ID: <20100225162032.GA3527@cthulhu>
References: <4B86399E.3090508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkgS7-0004P2-Ae
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 17:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846Ab0BYQUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 11:20:34 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35232 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810Ab0BYQUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 11:20:33 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 47E3C8221B1; Thu, 25 Feb 2010 11:20:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4B86399E.3090508@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141053>

* Johannes Sixt (j.sixt@viscovery.net) [100225 03:49]:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> An instance of fopen("/dev/null",...) was added to the code base. On
> Windows, we have to use "nul" instead. This implements a compatibility
> wrapper of fopen() that checks for this particular condition.

Doesn't store_updated_refs do this too?

        --larry
