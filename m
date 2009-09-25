From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git merge conflict resolution?
Date: Fri, 25 Sep 2009 11:58:31 +0200
Message-ID: <20090925095831.GA17721@atjola.homenet>
References: <200909250101.n8P11HwO030173@hera.kernel.org>
 <1253841510.18126.10.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr7Zc-0006nv-7R
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 11:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbZIYJ6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZIYJ6e
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 05:58:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:43255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbZIYJ6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 05:58:33 -0400
Received: (qmail invoked by alias); 25 Sep 2009 09:58:35 -0000
Received: from i59F578FB.versanet.de (EHLO atjola.homenet) [89.245.120.251]
  by mail.gmx.net (mp010) with SMTP; 25 Sep 2009 11:58:35 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/fg8dH5hTf44SSSnrJpam48k6A/s3E7eaeNfRZUv
	GIlG33vL+Kxzf8
Content-Disposition: inline
In-Reply-To: <1253841510.18126.10.camel@Joe-Laptop.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129072>

On 2009.09.24 18:18:30 -0700, Joe Perches wrote:
> Question about how git does merge conflict resolution.
>=20
> This patch doesn't really apply, and the results after the
> patch aren't what at least I expect.
[...]
> Russell's patch removes the "(moderated for non-subscribers)"
> from each entry, yet the final result includes it.
>=20
> Can someone help me understand why?

If you look at baea7b946f00a291b166ccae7fcfed6c01530cc6, you see:

    Merge branch 'origin' into for-linus

    Conflicts:
        MAINTAINERS

Git was unable to automatically merge that file, as there were
conflicting changes. That merge was done by Russel King, and _he_
decided that the result should include the "(moderated for ...)" part.

Bj=F6rn
