From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 09:26:10 +0200
Message-ID: <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com> <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <20110609162604.GC25885@sigill.intra.peff.net> <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
 <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 09:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWO1t-0002Pa-Ez
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 09:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab1FNH1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 03:27:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43667 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1FNH1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 03:27:11 -0400
Received: by pwi15 with SMTP id 15so2481917pwi.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=94y+jfxLTOp3smBIyW6DVbVJVBmIozo7GEZktM4hupU=;
        b=b0lZbvSjz3gl/Uaqvsj1SpsGjRZwjYxg/iatZhPEzI/VNmo8PlRWLfx8VVPBXSL6TE
         wNmM4u1PkyC39XUw6sXKJjbAtHjZruvv3oImAOvQp/NamLBMXXTvdr9KyTMP+SsoEyn/
         V2ZfAPxfU6zqrFVY7zcVtYSag8ApevSSp1v4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=he76NzmleBGDThskyUA2da4JuYWd0Fdt8QMLOOUv2w67eftSa1y4v91CrjJvphZftw
         WYMfYntMAEKf2rAjRtTY0TThTHpGDHwt0wpWt/q5FAANkDdpDQobOOhNVh3oVbGEupVn
         l0wTQ1Bj03vZX6LfBALpGl0qb8qfA5j+ZPapM=
Received: by 10.68.20.38 with SMTP id k6mr2808053pbe.410.1308036431213; Tue,
 14 Jun 2011 00:27:11 -0700 (PDT)
Received: by 10.68.41.99 with HTTP; Tue, 14 Jun 2011 00:26:10 -0700 (PDT)
In-Reply-To: <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175750>

Heya,

On Tue, Jun 14, 2011 at 06:41, Junio C Hamano <gitster@pobox.com> wrote:
> I would rather want to see if somebody can come up with a flexible reverse
> mapping feature around notes. It does not have to be completely generic,
> just being flexible enough is fine.

Wouldn't it be enough to simply create a note on 'r651235' with as
contents the git ref?

-- 
Cheers,

Sverre Rabbelier
