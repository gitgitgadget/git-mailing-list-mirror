From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Fri, 17 Feb 2006 05:21:08 +0100
Message-ID: <20060217042108.GB28114@diana.vm.bytemark.co.uk>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk> <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com> <43F53C76.6080902@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 05:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9x7d-0007BN-0w
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 05:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBQEV3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 16 Feb 2006 23:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBQEV3
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 23:21:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:60174 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750723AbWBQEV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 23:21:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F9x7E-0007pn-00; Fri, 17 Feb 2006 04:21:08 +0000
To: Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <43F53C76.6080902@vilain.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16325>

On 2006-02-17 16:01:10 +1300, Sam Vilain wrote:

> Karl Hasselstr=F6m wrote:
>
> > Let StGIT grok branch names with slashes in them. It used to fall
> > flat on its face when confronted with them.
> >
> > I think I've covered all, or at least most cases, but there are
> > probably some bugs left if you look hard enough.
>
> Does `stgit -r patchname/bottom` still work?

Yes (if you mean 'stg diff -r ... ' :-). It's just branches that can
have slashes in their names, not patches.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
