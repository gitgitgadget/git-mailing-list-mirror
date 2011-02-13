From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [PATCH 1/2] git-gui: fix deleting item from
	all_remotes variable
Date: Sun, 13 Feb 2011 15:15:02 +0100
Message-ID: <20110213141501.GG31986@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213140523.GF31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 15:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PocjG-0003LB-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 15:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab1BMOPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 09:15:06 -0500
Received: from darksea.de ([83.133.111.250]:53565 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754062Ab1BMOPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 09:15:05 -0500
Received: (qmail 14058 invoked from network); 13 Feb 2011 15:15:02 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 15:15:02 +0100
Content-Disposition: inline
In-Reply-To: <20110213140523.GF31986@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166670>

Hi Pat,

On Sun, Feb 13, 2011 at 03:05:23PM +0100, Heiko Voigt wrote:
> If you were going to please wait with applying it. I just found another
> location where this variable is changed in a wrong manner. I will update
> the patch accordingly.

Please forget this comment. I mistakenly found an lappend call with the
same usage pattern, but for lappend this is obviously correct.

Cheers Heiko
