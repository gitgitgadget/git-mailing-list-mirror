From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RESEND] Teach gitk to display dirty submodules correctly
Date: Sat, 17 Apr 2010 18:56:00 +1000
Message-ID: <20100417085600.GD6681@brick.ozlabs.ibm.com>
References: <4BBF8B2A.5090208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 10:56:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O33p5-0007ew-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 10:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab0DQI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 04:56:11 -0400
Received: from ozlabs.org ([203.10.76.45]:54233 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813Ab0DQI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 04:56:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AED16B7D0F; Sat, 17 Apr 2010 18:56:08 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <4BBF8B2A.5090208@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145124>

On Fri, Apr 09, 2010 at 10:16:42PM +0200, Jens Lehmann wrote:

> Since recently "git diff --submodule" prints out extra lines when the
> submodule contains untracked or modified files. Show all those lines of
> one submodule under the same header.
> 
> Also for newly added or removed submodules the submodule name contained
> trailing garbage because the extraction of the name was not done right.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Thanks, applied.

I changed the subject line to "gitk: Display dirty submodules
correctly" to fit in with the usual style.

Paul.
