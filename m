From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: Re: [RFC] git add -a
Date: Thu, 6 Mar 2008 14:19:37 +0200
Message-ID: <20080306121937.GA11882@localdomain>
References: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com> <200803061146.00500.barra_cuda@katamail.com> <e29894ca0803060257u19c98074t789f87e1f8c120e7@mail.gmail.com> <alpine.LSU.1.00.0803061235060.15786@racer.site>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXF5S-00071h-H1
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbYCFMT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 07:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbYCFMT6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:19:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:62718 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765645AbYCFMT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:19:57 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3788988ugc.16
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 04:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        bh=EfZ8iQsiPP+FpmPICntmtzUEcYrmzi7gO3wckFZYrTc=;
        b=nBxwoZs6s5TEE6PKgVdeS2sAZMWLNlKhhqueYh29afqzb7/oVTr6oYdLITEp6YcKKvHkD69Tda8ixPbV6pbYopVnexi9TAmsq7wJiPtUKBQdp2/Dyyph/K3BFaxFXVIAKek4B2AxYHRroh3emu5pDhIc+2HzC1FyhIo8iEvLz9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=Ts6e0scUqOgUZpRVz9SF6JtAWUxr4zxHZwYPEyaei/eORQ9QWKmMvZUA9RKr1O5IeOm6gaFYQcpLWQRZulr5NevUPpk75VDuRRe9GVLRRoXciXEOI3lSnW7rfzg1kPhVgsUKDk2RQoBSHKTfnXz0KJJZtgmVgBu6RdM5EWUjsw4=
Received: by 10.78.147.6 with SMTP id u6mr10021520hud.13.1204805995076;
        Thu, 06 Mar 2008 04:19:55 -0800 (PST)
Received: from shadow ( [128.214.182.195])
        by mx.google.com with ESMTPS id j2sm7959267mue.3.2008.03.06.04.19.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 04:19:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803061235060.15786@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76386>

Hi,

On Thu, Mar 06, 2008 at 12:35:58PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 6 Mar 2008, Marc-Andr=E9 Lureau wrote:
>=20
> > Hi,
> >=20
> > On Thu, Mar 6, 2008 at 12:46 PM, Michele Ballabio
> > <barra_cuda@katamail.com> wrote:
> > >
> > >  There's "git add -u". It should do what you want.
> > >
> >=20
> > Thanks for this answer :) I wonder why "-u" and not "-a".. After al=
l
> > git commit "-a" could be "-s" if we follow that distinction
> > (Update/Stage/All).
>=20
> Probably because some people would expect "git add -a" to do the same=
 as=20
> "git add .", i.e. add _all_ files (even the untracked ones), as oppos=
ed to=20
> "git add -u", which updates all _tracked_ files.

Actually "git add -u" updates all tracked files in the _current_
directory and its subdirectories. So the current working directory
acts as a "path limiter".

Pekka
