From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 01 Jun 2007 11:35:54 +0200
Message-ID: <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
References: <1180385483418-git-send-email-hjemli@gmail.com>
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3YF-0004Pu-6z
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbXFAJf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbXFAJf6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:35:58 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:36974 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415AbXFAJf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:35:57 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIY00FU2ANVNX@psmtp04.wxs.nl> for git@vger.kernel.org; Fri,
 01 Jun 2007 11:35:55 +0200 (MEST)
Received: (qmail 19960 invoked by uid 500); Fri, 01 Jun 2007 09:35:54 +0000
In-reply-to: <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48860>

On Fri, Jun 01, 2007 at 11:25:42AM +0200, Lars Hjemli wrote:
> On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> >Could you please document the proposed .gitmodules first?
> 
> The man-page for git-submodule found in 'next' mentions how it uses
> .gitmodules, but there isn't (yet) a separate man-page for
> .gitmodules(5).

That's what I'd like to see first.
.gitmodules(5) will hopefully not change in an incompatible
way after it is accepted, while there is no such constraint
for git-submodule.

> [path '$path']
>  submodule=modulename
>  url=/some/url

Wouldn't it make more sense to have

[path '$path']
	submodule=modulename

and

[submodule '$modulename']
	url=/some/url

in case the same module appears in more than one path?

> Is it ok if gitmodules(5) appears as part of the planned patch-series?

For me it is.

skimo
