From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 14:40:52 +0200
Message-ID: <20070610124052.GE955MdfPADPa@greensroom.kotnet.org>
References: <1181425132239-git-send-email-hjemli@gmail.com>
 <11814251322779-git-send-email-hjemli@gmail.com>
 <20070610002802.GD31707@planck.djpig.de>
 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMj7-0002eg-2N
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXFJMkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbXFJMkz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:40:55 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:33501 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbXFJMky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:40:54 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJF001PP784K8@psmtp13.wxs.nl> for git@vger.kernel.org; Sun,
 10 Jun 2007 14:40:53 +0200 (MEST)
Received: (qmail 16559 invoked by uid 500); Sun, 10 Jun 2007 12:40:52 +0000
In-reply-to: <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49722>

On Sun, Jun 10, 2007 at 02:30:58PM +0200, Lars Hjemli wrote:
> On 6/10/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> >On Sun, Jun 10, 2007 at 10:58:29AM +0200, Lars Hjemli wrote:
> >> >For .path a "Defaults to name of submodule" probably wouldn't hurt.
> >>
> >> True. But there might be some issues with this rule, so I'll leave it
> >> as is for now.
> >
> >And what might those issues be?
> 
> There's been some discussion about allowing a default value for path, see
>  http://comments.gmane.org/gmane.comp.version-control.git/49620

Euhm... this just points back to this thread...
or are you referring to Junio's misinterpretation of the patch 1/3 
commit message?

> >It doesn't have the extensions proposed by Linus, but it seems
> >to be forward compatible with them.
> 
> I'm trying to take baby-steps with the submodule support, so the
> module/submodule extension Linus talked about would possibly come at a
> later stage.
> 
> Hmm, maybe I should just rename [module] to [submodule] right now?

I don't see the need, but if you _really_ can't resist then please do it
sooner rather than later.

skimo
