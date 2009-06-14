From: David Aguilar <davvid@gmail.com>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Sat, 13 Jun 2009 20:55:20 -0700
Message-ID: <20090614035519.GA3963@gmail.com>
References: <20090612084207.6117@nanako3.lavabit.com> <20090613180018.GB23007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Jun 14 05:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFgqh-0002Bx-ED
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 05:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZFNDz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 23:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbZFNDz0
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 23:55:26 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:59993 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbZFNDzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 23:55:25 -0400
Received: by pxi17 with SMTP id 17so1352750pxi.33
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 20:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BpJtSCY2BvKotZk21sbO+wiVGQMk3wQUno6bttKh3Yg=;
        b=pH00LakiUIMD7RwwiKn39/xGpfJVvGNFUb3FlHHKzuduY4OAaA+cqBiC2r3sBgBSBD
         xFoBvcTfWSYashDJUeFw1Wq6HCIIFQKqdXCKxfjvwFe+COr0gxxHax0M6zt+fOfXTw+U
         kGH9lBMYaeHL8WJwXpThZ0+1QRK3PuQULsJIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vIpTZqQKLwLPcY3kJ7T9Yfsd8VmMz1nZJ5UAt+ru6n1+d8docfuz+uN0RHxY3rQe5Q
         jqZAc98dYKbgMBhBP4TRyv6/F/M60ppTGztpM8HRXqWkiYqWzfoveT4Zmy0JFfkKtxIf
         PVxUIfdSKl+hkcvfP04opsi63Sl8In4VejAM8=
Received: by 10.114.181.6 with SMTP id d6mr9146612waf.8.1244951726241;
        Sat, 13 Jun 2009 20:55:26 -0700 (PDT)
Received: from gmail.com (cpe-76-87-90-126.socal.res.rr.com [76.87.90.126])
        by mx.google.com with ESMTPS id n9sm3704620wag.26.2009.06.13.20.55.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 20:55:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090613180018.GB23007@pengutronix.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121533>

On Sat, Jun 13, 2009 at 08:00:18PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Jun 12, 2009 at 08:42:07AM +0900, Nanako Shiraishi wrote:
> > I was giving a git introduction to students in my lab, and this
> > question came up from one of them. How widely is this convention us=
ed?
> > Are there projects other than the Linux Kernel and git itself?
> I know ptxdist[1] and topgit[2].
>=20
> Best regards
> Uwe
>=20
> [1] http://pengutronix.de/software/ptxdist/index_en.html
> [2] http://repo.or.cz/w/topgit.git

git-cola [1] does.

I learned it by watching git ;-)

Multiple sign-off lines are useful for tracking code
reviews as well, as it's done on git and the kernel.

I've seen various flavors along those lines:

	Signed-Off-By: ...
	Tested-By: ... ($platform)
	Acked-By: ...
	Reviewed-By: ...

[1] http://cola.tuxfamily.org/

--=20
		David
