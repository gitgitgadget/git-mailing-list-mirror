From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 01 Jun 2007 16:51:04 +0200
Message-ID: <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
References: <1180385483418-git-send-email-hjemli@gmail.com>
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu8TF-00080T-3o
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 16:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbXFAOvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759680AbXFAOvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 10:51:09 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:36936 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759560AbXFAOvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 10:51:06 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIY00438P94KX@psmtp03.wxs.nl> for git@vger.kernel.org; Fri,
 01 Jun 2007 16:51:05 +0200 (MEST)
Received: (qmail 22309 invoked by uid 500); Fri, 01 Jun 2007 14:51:04 +0000
In-reply-to: <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48868>

On Fri, Jun 01, 2007 at 04:45:06PM +0200, Lars Hjemli wrote:
> On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> >On Fri, Jun 01, 2007 at 11:25:42AM +0200, Lars Hjemli wrote:
> >> [path '$path']
> >>  submodule=modulename
> >>  url=/some/url
> >
> >Wouldn't it make more sense to have
> >
> >[path '$path']
> >        submodule=modulename
> >
> >and
> >
> >[submodule '$modulename']
> >        url=/some/url
> >
> >in case the same module appears in more than one path?
> 
> Yes, that would be a properly normalized model.
> 
> Hmm.... Maybe we could allow both variations, with your suggestion
> overriding mine if both are present? (I think there would be many
> cases where the extra level of [submodule...] wouldn't be needed.

Hmm.... I was thinking that the extra "path" level could be optional,
i.e., if there is no path.$path.submodule, then the name of the
submodule would simply be $path.

skimo
