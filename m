From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 15:11:08 +0200
Message-ID: <20070524131108.GP942MdfPADPa@greensroom.kotnet.org>
References: <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 15:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrD6Q-00031o-Kw
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbXEXNLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbXEXNLM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:11:12 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:41565 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756608AbXEXNLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:11:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIJ00I5ERALI0@smtp19.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 15:11:09 +0200 (CEST)
Received: (qmail 3561 invoked by uid 500); Thu, 24 May 2007 13:11:08 +0000
In-reply-to: <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48255>

On Thu, May 24, 2007 at 02:41:57PM +0200, Lars Hjemli wrote:
> I think the whole point of the 'remote config' stuff is to get an
> unversioned/out-of-tree .gitmodules file, right?

Yes.

> If so, one could put this file into the object db and refer to it with
> something like 'refs/tags/subproject-config' or even
> 'refs/misc/subproject-config'. Both of these refs will be found by
> ls-remote and point to the object containing the suggested subproject
> configuration.

That's a possibility, but then...

On Thu, May 24, 2007 at 01:43:54PM +0200, Sven Verdoolaege wrote:
> Or do you propose we put the URL in a blob and put the object sha1
> in there.  If so, who's going to create these blobs for the git://
> and ssh:// protocols?  upload-pack?

I don't think you can expect the user to this herself.

skimo
