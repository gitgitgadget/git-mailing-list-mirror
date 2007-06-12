From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:28:13 +0200
Message-ID: <8c5c35580706120328s5829ed08u85fb0838262d83fd@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <11816319211097-git-send-email-hjemli@gmail.com>
	 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
	 <20070612094931.GR955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Jun 12 12:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy3bs-0006n0-8B
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 12:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXFLK2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 06:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbXFLK2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 06:28:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:33514 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbXFLK2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 06:28:15 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1594828nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:28:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UmISoUDhGkCnSmcoCqgt7aPx8jpor+9+ypndMs9qBFLYWd5d3zXVqi7HCtZ+7cuiaxisJb9NC77LzqvRRxAEYhoiADk5ljhz10kmkY6IcQk63+3TJ6bBfwqqpthdIkifzLj6Aju9t87a1Nrn3llLh4y91jtmHtnOQqBEqBg9o7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WfwglxquzvAJfoU2ntk8D0K2zi89TMar1Gd9RHOAhRF3X7cgJ5zjBQF2LdPJJKWE+5q4nu+V6h0atIVo/HlZZEkM5ocxY8Wqq/TD0KkzGjd6s1i0OMWrGehmx4sLN1nHqrGcLLa5tXWLvT/Ohjn0Y/miX+gLw6KByzibaDSkBIg=
Received: by 10.114.37.1 with SMTP id k1mr6559182wak.1181644094635;
        Tue, 12 Jun 2007 03:28:14 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 03:28:13 -0700 (PDT)
In-Reply-To: <20070612094931.GR955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49943>

On 6/12/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Tue, Jun 12, 2007 at 10:27:00AM +0200, Lars Hjemli wrote:
> > On 6/12/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > >Your previous patch had "_a_ path" instead of "_the_ path".
> > >I prefer the former since it allows a module to be checkoud out
> > >at multiple locations.
> >
> > This is somewhat intentional. I want to move the submodule repos into
> > .git/submodules/$name/ (with working dir) and symlink this directory
>
> I had that in my patch series, but I got a complaint that symlinks
> don't work on Windows.

Yeah, I didn't consider windows.

>
> > Multiple checkout paths for a single submodule will bring havoc on
> > this plan, so I need to ask: what is the use-case for multiple
> > checkout paths?
>
> The case where you need two different versions of the same
> submodule in one (presumably big) project.

Let me rephrase: why would anyone need to checkout two different
versions of the same submodule simultaneously inside a single
superproject?

-- 
larsh
