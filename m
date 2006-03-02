From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: NT directory traversal speed on 25K files on Cygwin
Date: Thu, 2 Mar 2006 14:40:04 +0100
Message-ID: <81b0412b0603020540uf58c2c3x7fc8b3b086444803@mail.gmail.com>
References: <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
	 <20060226231701.GA11961@nospam.com> <4402C40D.2010805@op5.se>
	 <20060227184544.GB13195@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Andreas Ericsson" <ae@op5.se>, "Christopher Faylor" <me@cgf.cx>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 14:40:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEo2O-00016o-80
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 14:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWCBNkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 08:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCBNkI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 08:40:08 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:43955 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751964AbWCBNkG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 08:40:06 -0500
Received: by nproxy.gmail.com with SMTP id a27so276599nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 05:40:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b2x80wGQ7ZTe8RyqjEAMwhkWDpsL7d1c4J1Uy8VGBi+mwo2GKV9lgFEMovfMz5XmMBp3SlZ1fRKop16Od5n5MwAr95izL12hrvBsiTD/XMJM+cJh4rf7fSTF97a53N1dcfRU2/XRL8xLa7eLYKTEuiHDe1TsDyb7msrp5hBa4BY=
Received: by 10.49.56.6 with SMTP id i6mr647051nfk;
        Thu, 02 Mar 2006 05:40:04 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 05:40:04 -0800 (PST)
To: git@wingding.demon.nl
In-Reply-To: <20060227184544.GB13195@nospam.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17069>

On 2/27/06, Rutger Nijlunsing <rutger@nospam.com> wrote:
> I'm not saying Cygwin is bad (actually, I'm installing on every
> Windows PC I get my hand on ;), but using Cygwin for all file IO
> instead of native Windows IO makes git a magnitude slower on Windows

By "slow filesystem" I actually meant the native filesystem access.
Cygwin does make it 6 times slower, that's right, and this can be
considered a disaster of course, but not as big as the windows api.
