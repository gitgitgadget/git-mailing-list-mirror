From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 23:56:10 +0200
Message-ID: <20070618215610.GG16393@cip.informatik.uni-erlangen.de>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de> <20070618212741.GA5938@artemis.internal.dc7.debconf.org> <20070618214852.GA13538@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Carlo Wood <carlo@alinoe.com>, LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0PD7-0004pF-2o
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765420AbXFRV4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765329AbXFRV4N
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:56:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43824 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765258AbXFRV4M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2007 17:56:12 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id E184D3F3E2; Mon, 18 Jun 2007 23:56:10 +0200 (CEST)
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>,
	Carlo Wood <carlo@alinoe.com>, LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070618214852.GA13538@alinoe.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50420>

Hello,

> It seems that this is only for etch (and sarge).  I run a mixed
> Lenny/sid machine here. It doesn't necessarily work when I start to
> install things for etch. Certainly not once testing upgrades its libc.
> Or?

true. But when you run sid you get a newer version of git automatically.
Sooner or later. And you can always build it yourself. It's a pain in
the ass until you have all build dependencies installed and all the
tests pass. Most of them you can get by typing:

        apt-get build-dep git-core

But after that it is very straight forward.

        Thomas
