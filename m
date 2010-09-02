From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git instaweb for Debian squeeze (Re: Bug#592733: git instaweb
	broken)
Date: Thu, 2 Sep 2010 15:36:24 -0700
Message-ID: <20100902223624.GA9613@dcvr.yhbt.net>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de> <20100902221211.GA4789@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, 592733@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 00:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIOU-00069k-Ig
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab0IBWgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 18:36:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50652 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab0IBWgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 18:36:24 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395AD1F4F3;
	Thu,  2 Sep 2010 22:36:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100902221211.GA4789@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155216>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Uwe Kleine-K=F6nig wrote:
> > when I start git instaweb on a git repository, I get a crippled vie=
w
> > (no style sheets, no images) that doesn't include the current proje=
ct.

> Eric, do you think it is worth duplicating the logo and favicon withi=
n
> pre-v1.7.2 instaweb?  The script already takes 252 KiB, so an extra
> 10 KiB might not be such a big deal.

The stylesheet is important and should be fixed.  I don't care about th=
e
logo and favicon (warning: I've never been a fan of logos/icons,
needless noise IMHO), but if you're willing to help maintain it then
it's fine by me.

--=20
Eric Wong
