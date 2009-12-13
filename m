From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RESEND] gitk: add "--no-replace-objects" option
Date: Mon, 14 Dec 2009 10:09:23 +1100
Message-ID: <20091213230923.GB8135@brick.ozlabs.ibm.com>
References: <20091212045240.4249.66874.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 00:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxZN-0006Fc-67
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 00:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbZLMXJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbZLMXJh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 18:09:37 -0500
Received: from ozlabs.org ([203.10.76.45]:33472 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660AbZLMXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 18:09:36 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 45839B6F2B; Mon, 14 Dec 2009 10:09:35 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20091212045240.4249.66874.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135160>

On Sat, Dec 12, 2009 at 05:52:39AM +0100, Christian Couder wrote:

> Replace refs are useful to change some git objects after they
> have started to be shared between different repositories. One
> might want to ignore them to see the original state, and
> "--no-replace-objects" option can be used from the command
> line to do so.
> 
> This option simply sets the GIT_NO_REPLACE_OBJECTS environment
> variable, and that is enough to make gitk ignore replace refs.
> 
> The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
> safer on some platforms, thanks to Johannes Sixt and Michael J
> Gruber.
> 
> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks, applied.

Paul.
