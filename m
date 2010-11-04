From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage strings
Date: Thu, 04 Nov 2010 21:26:14 +0100
Message-ID: <87d3qkhm3d.fsf@gmail.com>
References: <20101024155121.GA9503@headley>
	<AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
	<87wrp12p00.fsf@gmail.com>
	<AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	<87fwvl2d4d.fsf@gmail.com> <87hbfxgg86.fsf_-_@gmail.com>
	<20101104174917.GA30628@sigill.intra.peff.net>
	<20101104180242.GA16431@burratino>
	<20101104181357.GA31016@sigill.intra.peff.net>
	<20101104183851.GA16865@burratino>
	<20101104185545.GB31016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:28:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6Qb-0000JX-NU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab0KDU2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 16:28:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60022 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab0KDU2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 16:28:48 -0400
Received: by bwz11 with SMTP id 11so2046594bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=IdRhqjs6QSr/MOYxeWy6P3ScUH2EpqSogwwfy1r3OCs=;
        b=jqFOPgo4GfOM5LUENTqSN4H+m949+OMWCyHq8ys2CxgR3hY1lCdMo5PSgF8WvamVVF
         SQAFTxLI6e56aWVA9L+DbBhdDWT22sTmExq7gUfmEoaYq9PBF87NahetViarPR30iPZk
         oDPEN/aNTISmd8K+XplJO/m3mOPjKcym2sA7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=fPJdlk0b34gqJ06vF3V0M0gWDk9UKUIszY7d+eAPlqNYSkpHoO5Jgem9MeCNpQ11vX
         h2dYgeZS97XKBvMawIAEPg1t+l8rFV5I+d+05TydSpO8p5QplbxTmnCpk4r/r5uvwgQD
         nSiGc41mqvXC4Vmdx2fPTMqF7yCivCxrL1BSU=
Received: by 10.204.119.145 with SMTP id z17mr1058592bkq.128.1288902461821;
        Thu, 04 Nov 2010 13:27:41 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id 4sm341264bki.1.2010.11.04.13.27.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 13:27:40 -0700 (PDT)
In-Reply-To: <20101104185545.GB31016@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 4 Nov 2010 14:55:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160755>

Jeff King <peff@peff.net> writes:

[...]

>> 	usage: git diff <options> <rev>{0,2} -- <path>*

[...]

> [1] If we are on a quest to remove <rev>{0,2}, this is one other spot=
 to
>     do it.

That's already included in the patch.

I think this thread already has nothing to do with the purpose of the
patch, though. I find your suggestion that <commit>{0,2} better conveys
some information about git-diff's operation modes than [<commit>
[<commit>]] does (which seems to have been your starting point) rather
far-fetched.

Note that I do not feel strongly about removing the {M,N} notation (I
expressed my opinion in the thread already[1]), but I see the notation
problem as orthogonal to the issues you are discussing here.

So AIUI the patch can still be applied and we/you can then work on
improving the usage string in other ways -- providing that we agree tha=
t
the {M,N} notation should go, of course, which we apparently still
don't?

In any case this seems to be less and less my itch to scratch, so I'm
not sure I'm going to be of much help in this discussion. The thing I
need to know for the CodingGuidelines patch is whether we're going to
preserve and encourage the {M,N} usage or not (so please let's arrive t=
o
some conclusion on that matter -- I waited for several days before
sending the updated version and nobody chimed in, so I assumed nobody
other than Mark and Sverre really cared). Although, that's actually
somewhat orthogonal, too -- we can always re-add the {M,N} subsection
later.

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n

[1]
http://thread.gmane.org/gmane.comp.version-control.git/158467/focus=3D1=
60330
