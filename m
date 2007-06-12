From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 11:49:31 +0200
Message-ID: <20070612094931.GR955MdfPADPa@greensroom.kotnet.org>
References: <20070611225918.GD4323@planck.djpig.de>
 <11816319211097-git-send-email-hjemli@gmail.com>
 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy312-0007pK-QW
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 11:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbXFLJuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 05:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbXFLJuS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 05:50:18 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:37976 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbXFLJuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 05:50:17 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJI00HJHOMJTZ@smtp17.wxs.nl> for git@vger.kernel.org; Tue,
 12 Jun 2007 11:49:31 +0200 (CEST)
Received: (qmail 25439 invoked by uid 500); Tue, 12 Jun 2007 09:49:31 +0000
In-reply-to: <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49941>

On Tue, Jun 12, 2007 at 10:27:00AM +0200, Lars Hjemli wrote:
> On 6/12/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> >Your previous patch had "_a_ path" instead of "_the_ path".
> >I prefer the former since it allows a module to be checkoud out
> >at multiple locations.
> 
> This is somewhat intentional. I want to move the submodule repos into
> .git/submodules/$name/ (with working dir) and symlink this directory

I had that in my patch series, but I got a complaint that symlinks
don't work on Windows.

> Multiple checkout paths for a single submodule will bring havoc on
> this plan, so I need to ask: what is the use-case for multiple
> checkout paths?

The case where you need two different versions of the same
submodule in one (presumably big) project.
(Not that I need that just now.)

skimo
