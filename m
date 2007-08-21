From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
 documentation
Date: Tue, 21 Aug 2007 22:25:16 +0200
Message-ID: <20070821202516.GL1070MdfPADPa@greensroom.kotnet.org>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
 <11875937841178-git-send-email-madduck@madduck.net>
 <7vd4xhsybm.fsf@gitster.siamese.dyndns.org>
 <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
 <11875937841178-git-send-email-madduck@madduck.net>
 <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org>
 <20070821180218.GA14739@piper.oerlikon.madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, hjemli@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 22:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INaI3-0005Qw-Rk
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXHUUZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 16:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXHUUZY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 16:25:24 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:51537 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbXHUUZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 16:25:22 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JN5008L24Q5UC@psmtp08.wxs.nl> for git@vger.kernel.org; Tue,
 21 Aug 2007 22:25:17 +0200 (MEST)
Received: (qmail 18677 invoked by uid 500); Tue, 21 Aug 2007 20:25:16 +0000
In-reply-to: <20070821180218.GA14739@piper.oerlikon.madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56325>

On Tue, Aug 21, 2007 at 08:02:18PM +0200, martin f krafft wrote:
>   FILES

I'm not sure this is the most appropriate name for this section.

>   A repository with submodules is identified by a .gitmodules file
>   in the repository's top level (see gitlink:gitmodules[5]). This
>   file specifies for each submodule its name, the url of the
>   submodule's repository, as well as the location of the submodule
>   within the (super)project's repository. As the .gitmodules file
>   contains information shared by all users of the repository, it is
>   typically tracked.
> 
>   Users who clone the project's repository need to initialize each
>   submodule before they can work with it. By initializing

I suppose this is implicit in the git submodule man page,
but this is only true if you actually want to use git submodule
to work with the submodules.

>   a submodule, the submodule's url is copied from the .gitmodules

As I mentioned before, this is not strictly true.
(see init::)

>   By pulling the submodule urls out of $GIT_DIR/config,
>   git-submodule allows contributors to use different urls (e.g. via

I'm not a native speaker, but to me that sounds like you are _not_
using the urls in $GIT_DIR/config.  That is, I read that as:
they are pulled out of $GIT_DIR/config (and then placed somewhere else).

Other than that, it's definitely an improvement.

skimo
