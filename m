From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] clarify need for init in git-submodules documentation
Date: Fri, 17 Aug 2007 12:36:52 +0200
Message-ID: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
References: <200708161553.10991.Josef.Weidendorfer@gmx.de>
 <11872878021267-git-send-email-madduck@madduck.net>
 <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
 <20070817100815.GC28477@piper.oerlikon.madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 12:37:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILzCX-0006lk-2n
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 12:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbXHQKgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 06:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXHQKgz
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 06:36:55 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:36103 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXHQKgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 06:36:54 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMW00BMQYTGON@psmtp08.wxs.nl> for git@vger.kernel.org; Fri,
 17 Aug 2007 12:36:53 +0200 (MEST)
Received: (qmail 22990 invoked by uid 500); Fri, 17 Aug 2007 10:36:52 +0000
In-reply-to: <20070817100815.GC28477@piper.oerlikon.madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56059>

On Fri, Aug 17, 2007 at 12:08:15PM +0200, martin f krafft wrote:
> also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.17.1131 +0200]:
> > This is not true.  The url (which is local information) is taken from .git/config,
> > the name/path relation (which is shared information) is taken from .gitmodules.
> 
> If you approve of this change, I shall prepare a new patch:
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index b1a4f95..2f69047 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -71,8 +71,9 @@ to each submodule url is "submodule.$name.url".
>  
>  The file .gitmodules serves default configuration data to users who cloned the

This still seems to suggest that the only purpose of .gitmodules is to
contain default configuration data.  I think you should restrict the
whole paragraph to talking about URLs.  Btw, please be consistent about
the spelling of URL.  Either use "url" or change the "url"s in the remainder
of the text to "URL".
Oh, and CC Lars on your patch.

>  repository. In order to work with submodules, these data need to be copied to
> -$GIT_DIR/config with `git-submodule init`. Only the data in $GIT_DIR/config
> -are used for `git-submodule update`.
> +$GIT_DIR/config with `git-submodule init`. Only the URL in $GIT_DIR/config
> +is used for `git-submodule update`, as it is local information. The name/path
> +relation is taken from the .gitmodules file, as it is shared data.

There is no mention in this man page of this relationship, so I think
you should either add a description or drop the last sentence.
I'm also not sure if local/shared are the best way to describe the
distinction in a manual page.  I was only trying to make it clear to you.

skimo
