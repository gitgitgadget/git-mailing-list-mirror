From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 09:31:14 -0800
Message-ID: <20110107173114.GA31376@dcvr.yhbt.net>
References: <4D260A03.90903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, stevenrwalter@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 07 18:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbG9s-00034u-OS
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab1AGRbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:31:16 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57343 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab1AGRbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:31:15 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CAA1F68D;
	Fri,  7 Jan 2011 17:31:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4D260A03.90903@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164724>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk> ---
> 
> This test fails for me, because my svn version(s) are too old (1.4.3
> and 1.4.6), and so I've got into the habit of running the tests with
> NO_SVN_TESTS=1. (which is a bit of a shame in terms of test coverage,
> but it is *much* quicker!)
> 
> I don't know the details, but it seems that the 'svn merge' of this
> vintage does not support the operations required by this test.
> Unfortunately, I don't know what the minimum required version of svn
> is, so I'm hoping that someone can take this patch and fix it up
> properly ...

I'm fine taking this patch as-is or even making it just apply to all
1.4.x versions.  1.5+ has been out for ages now and eventually the rest
of the world will just upgrade.

Consider this
Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
