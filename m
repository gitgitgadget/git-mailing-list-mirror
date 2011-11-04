From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last break point?
Date: Fri, 04 Nov 2011 08:55:32 -0700 (PDT)
Message-ID: <m3k47f51f0.fsf@localhost.localdomain>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
	<CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
	<20111031090717.GA24978@elie.hsd1.il.comcast.net>
	<20111102220614.GB14108@sigill.intra.peff.net>
	<7vwrbigna7.fsf@alter.siamese.dyndns.org>
	<20111102232735.GA17466@sigill.intra.peff.net>
	<CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
	<20111103024248.GA9492@sigill.intra.peff.net>
	<CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
	<20111104085633.GA13924@ecki> <4EB3B1E7.7080507@viscovery.net>
	<CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 16:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMM7N-0006Qt-44
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab1KDPzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:55:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50818 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab1KDPzf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 11:55:35 -0400
Received: by eye27 with SMTP id 27so2159821eye.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=HxPpvVmrrXrquzCz74gjEGd+2qZvzjoQlbxsx6HoziM=;
        b=tFgWzbBKSK8ToLvFvEk0ApSi58KisE6XE5FW9vgbDBdWg+cBfPqFr61dLdf/LCiDky
         ipxs62+tWMIFwlgh3T4Cxmbv8HDkOaFTQj1qR2b4nzEFetntM4p4rcubB2bDfLmSlKfr
         MYm5EMfv2gCmCmanzeXUo5OTzuc8S97M0wCqE=
Received: by 10.213.2.133 with SMTP id 5mr595119ebj.8.1320422133750;
        Fri, 04 Nov 2011 08:55:33 -0700 (PDT)
Received: from localhost.localdomain (abwn145.neoplus.adsl.tpnet.pl. [83.8.237.145])
        by mx.google.com with ESMTPS id t6sm26275207eeb.11.2011.11.04.08.55.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:55:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA4FsgRK029650;
	Fri, 4 Nov 2011 16:54:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA4FruMw029641;
	Fri, 4 Nov 2011 16:53:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184782>

Shawn Pearce <spearce@spearce.org> writes:
> On Fri, Nov 4, 2011 at 02:35, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> > Am 11/4/2011 9:56, schrieb Clemens Buchacher:

> > > Cache ... not the pack but the information
> > > =A0 =A0to re-create it...
> >
> > It has been discussed. It doesn't work. Because with threaded pack
> > generation, the resulting pack is not deterministic.
>=20
> The information to create a pack for a repository with 2M objects
> (e.g. Linux kernel tree) is *at least* 152M of data. This is just a
> first order approximation of what it takes to write out the 2M SHA-1s=
,
> along with say a 4 byte length so you can find given an offset
> provided by the client roughly where to resumse in the object stream.
> This is like 25% of the pack size itself. Ouch.

Well, perhaps caching a few most popular packs in some kind of cache
(packfile is saved to disk as it is streamed if we detect that it will
be large), indexing by WANT / HAVE?
=20
> This data is still insufficient to resume from. A correct solution
> would allow you to resume in the middle of an object, which means we
> also need to store some sort of indicator of which representation was
> chosen from an existing pack file for object reuse. Which adds more
> data to the stream. And then there is the not so simple problem of ho=
w
> to resume in the middle of an object that was being recompressed on
> the fly, such as a large loose object.

Well, so you wouldn't be able to just concatenate packs^W received
data.  Still it should be possible to "repair" halfway downloaded
partial pack...
=20
Just my 2 eurocents^W groszy.
--=20
Jakub Nar=EAbski
