From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] docs: clarify git diff modes of operation
Date: Thu, 04 Nov 2010 22:51:55 +0100
Message-ID: <871v70hi4k.fsf@gmail.com>
References: <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	<87fwvl2d4d.fsf@gmail.com> <87hbfxgg86.fsf_-_@gmail.com>
	<20101104174917.GA30628@sigill.intra.peff.net>
	<20101104180242.GA16431@burratino>
	<20101104181357.GA31016@sigill.intra.peff.net>
	<20101104183851.GA16865@burratino>
	<20101104185545.GB31016@sigill.intra.peff.net>
	<87d3qkhm3d.fsf@gmail.com>
	<20101104204304.GA4641@sigill.intra.peff.net>
	<20101104211729.GA5551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7kb-0002hE-SY
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab0KDVx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 17:53:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61613 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0KDVxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:53:23 -0400
Received: by bwz11 with SMTP id 11so2118967bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=XPf2vfbUMA4BOZ1gmNhePg5Bl6jQuK2wjBjk+DFNs3s=;
        b=SQ/n3TfKT79e9FPaKIOgCDvtZ4xbUqe/Hpzol1xlt/dCVu0TU3+886hu+OM/QimrAP
         NB8T+Z/gt7DoeOQhWAz8/byJuzYvvEpKrDTb7ff5zyLD/zqiQMA5nyABhxPEk5l3dU4f
         j+StyZImWkYyVcjcBlGknB9Iw+FaGcLq//jKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=CMVVmc4B4ky1LP/bZoVN1bMCZ1y7w0ttPU92tK3OraTCwWU5OyhmTudA3kFonwvSxu
         N59xKbZwv4Jyza5R3rYKmesdIM4I82RVVKi/Gyo2IGvDdrWmHIB0GMDFffCCiVmEaLc6
         0r1klah2nIFFf4H9CYDG66HqEYLVCMM03AYFE=
Received: by 10.204.71.136 with SMTP id h8mr1172557bkj.31.1288907602210;
        Thu, 04 Nov 2010 14:53:22 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id t10sm390964bkj.16.2010.11.04.14.53.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 14:53:21 -0700 (PDT)
In-Reply-To: <20101104211729.GA5551@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 4 Nov 2010 17:17:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160779>

Jeff King <peff@peff.net> writes:

> Note that in all versions (the original, yours, and mine) we gloss ov=
er
> the fact that <commit> can actually be any two objects (as long as th=
ey
> are bother either tree-ishs or blobs).

Yeah, I thought about that, too. I think it would be nice to use more
precise placeholders like <tree-ish> or <object> (which do already
occur in other places), but I suspect it might be needed/useful at more
places and would better be done as a separate patch (preferably by some=
one
who is more familiar with the internals than me).

> I'm not sure if it is worth documenting that subtlety here (at least
> the tree-ish thing gets mentioned later in the description; I'm not
> sure we ever document "git diff HEAD:Makefile HEAD^:Makefile"
> anywhere).

There's gitrevisions(7) (also pointed to from the git-diff manpage)
which describes those in some detail.

  =C5=A0t=C4=9Bp=C3=A1n
