From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] t7405: cd inside subshell instead of around
Date: Thu, 2 Sep 2010 18:29:36 +0200
Message-ID: <20100902162936.GA2535@book.hvoigt.net>
References: <4C7EBF3D.9030806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCfY-0005DY-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab0IBQ3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:29:39 -0400
Received: from darksea.de ([83.133.111.250]:36776 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753021Ab0IBQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:29:38 -0400
Received: (qmail 21367 invoked from network); 2 Sep 2010 18:29:36 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 Sep 2010 18:29:36 +0200
Content-Disposition: inline
In-Reply-To: <4C7EBF3D.9030806@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155143>

On Wed, Sep 01, 2010 at 11:01:49PM +0200, Jens Lehmann wrote:
> Instead of using `cd dir && (...) && cd..` use `(cd dir && ...)`
> 
> This ensures that the test doesn't get caught in the subdirectory if there
> is an error in the subshell.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

That makes the test way more robust, I like it.

cheers Heiko
