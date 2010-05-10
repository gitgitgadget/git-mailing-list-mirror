From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH RFC GSoC] gitweb: Use -M option while using format-patch
Date: Mon, 10 May 2010 20:11:27 +0200
Message-ID: <20100510181127.GW1951@machine.or.cz>
References: <4BE82F8D.8060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 20:11:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBXS6-0001ou-BZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 20:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab0EJSLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 14:11:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41938 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280Ab0EJSLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 14:11:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 53D2286208C; Mon, 10 May 2010 20:11:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BE82F8D.8060205@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146841>

On Mon, May 10, 2010 at 09:38:45PM +0530, Pavan Kumar Sunkara wrote:
> Add option '-M' to use with format-patch whcih detects
> renames in the commit.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

I think git-specific format is no big issue; even if you are applying
the patch with plain patch(1) instead, you might very well prefer to be
informed of the rename and take appropriate precautions (like mv'ing
before applying to avoid unsolvable rejects).

Acked-by: Petr Baudis <pasky@suse.cz>

> ---
> 
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

But please do something about the whitespace damage in the patches you
send, thanks!

-- 
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
