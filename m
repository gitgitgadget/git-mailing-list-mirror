From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 10 Nov 2012 14:02:32 -0500
Message-ID: <20121110190232.GD2739@mjolnir>
References: <20121110184437.GC2739@mjolnir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGVp-0004xV-5A
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2KJTOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:14:24 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:50429 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2KJTOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:14:23 -0500
Received: from mjolnir.tremily.us ([unknown] [69.141.221.103])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDA00C5SDFEXK70@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 10 Nov 2012 13:14:12 -0600 (CST)
Received: by mjolnir.tremily.us (Postfix, from userid 1000)
	id 202B1271DC9; Sat, 10 Nov 2012 14:02:32 -0500 (EST)
Content-disposition: inline
In-reply-to: <20121110184437.GC2739@mjolnir>
 <20121109162919.GA922@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209294>

On Fri, Nov 09, 2012 at 05:29:27PM +0100, Heiko Voigt wrote:
> I think we should agree on a behavior for this option and implement it
> the same time when add learns about it. When we were discussing floating
> submodules as an important option for the gerrit people I already started
> to implement a proof of concept. Please have a look here:
> 
> https://github.com/hvoigt/git/commits/hv/floating_submodules

After skimming through this, something like

  $ git submodule update --pull

would probably be better than introducing a new command:

On Sat, Nov 10, 2012 at 01:44:37PM -0500, W. Trevor King wrote:
>   $ git submodule pull-branch

I think "floating submodules" is a misleading name for this feature
though, since the checkout SHA is explicitly specified.  We're just
making it more convenient to explicitly update the SHA.  How about
"tracking submodules"?

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
