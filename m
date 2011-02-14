From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] git-gui: Include version check and test for tearoff
	menu entry
Date: Mon, 14 Feb 2011 22:31:48 +0100
Message-ID: <20110214213148.GB50815@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net> <878vxilndt.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp61T-0005FU-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab1BNVbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:31:51 -0500
Received: from darksea.de ([83.133.111.250]:48103 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753127Ab1BNVbu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:31:50 -0500
Received: (qmail 18209 invoked from network); 14 Feb 2011 22:31:48 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Feb 2011 22:31:48 +0100
Content-Disposition: inline
In-Reply-To: <878vxilndt.fsf_-_@fox.patthoyts.tk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166773>

Hi,

On Mon, Feb 14, 2011 at 01:03:24PM +0000, Pat Thoyts wrote:
> The --all option for git fetch was added in v1.6.6 so ensure we have a usable version before adding
> the menu items.
> Sometimes people use tearoff menus and these offset the entry indices by one.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> 
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >It just came to my mind that I probably should implement a version check
> >of the commandline to ensure that this option is available. Thats why I
> >tagged only this patch with RFC.
> >
> >Cheers Heiko
> 
> The posted patch seems fine except that an error is reported if tearoff
> menus are present. So this patch accommodates tearoff's. I looked up
> when the --all option was added (1.6.6) and skip adding the menu entry
> if we have an older version.
> 
> Seems to do the right thing.

Works and looks good to me as well. Did not know about tearoff menues
how do you get those?

Cheers Heiko

P.S.: I discovered a whitespace issue in line 258 which came from my patch.
Could you correct that?
