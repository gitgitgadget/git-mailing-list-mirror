From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: using .gitmodule as default (was: git submodule init and redundant data in .gitmodules/.git/config)
Date: Thu, 16 Aug 2007 18:39:52 +0200
Message-ID: <200708161839.52749.Josef.Weidendorfer@gmx.de>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net> <200708161553.10991.Josef.Weidendorfer@gmx.de> <20070816142133.GA26013@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILiOC-0006Wl-SP
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 18:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXHPQj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbXHPQj5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 12:39:57 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:60629 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932458AbXHPQjz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 12:39:55 -0400
Received: from dhcp-3s-47.lrr.in.tum.de (dhcp-3s-47.lrr.in.tum.de [131.159.35.47])
	by mail.in.tum.de (Postfix) with ESMTP id 80339282C;
	Thu, 16 Aug 2007 18:39:54 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070816142133.GA26013@piper.oerlikon.madduck.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56026>

On Thursday 16 August 2007, martin f krafft wrote:
> also sprach Josef Weidendorfer <Josef.Weidendorfer@gmx.de> [2007.08.16.1553 +0200]:
> > The information in .gitmodules is only a default value for the
> > URL, and not to be actually used. The URL in the config has to
> > exist and will be used for updating. So the config value is not
> > about overriding anything, but is required information.
> 
> It's not required for git-submodule status.

This can show uninitialized submodules, so that's fine.

As the URL in .gitmodules is only an initial default, it probably
could be optional: if you work on a supermodule with a submodule of your own,
it is easily possible that you have no idea about what a reasonable default
of a submodule URL should be at the time you do the first supermodule
commit. It makes no sense to have to provide a bogus URL there.

Josef
