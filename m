From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] hooks/pre-commit.sh: fix it again
Date: Wed, 25 Mar 2009 13:24:08 +0100
Message-ID: <36ca99e90903250524g3549b629g8ce1947f741878f7@mail.gmail.com>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090325122027.GB30873@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmSAw-0004va-Lv
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbZCYMYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 08:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbZCYMYM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:24:12 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:38204 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbZCYMYL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 08:24:11 -0400
Received: by yx-out-2324.google.com with SMTP id 31so5710yxl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K5X22zQjIBuLzf9TR6yXZhD64t4Tt4zjjPJkdY3FCrk=;
        b=WETmIT3HnEOxM9LwaqRaKSkvID/NBFzp+MH96lP7xll/9U+BDteIW56nBXKzYd2AZh
         433VR5pN627VRxaQcr5vmp5k4GWyvjJFy/G1LLspI7oRZXEalQO8ZybCQhiKalZZfvP4
         rd8POV8J8cLuTtSGlyM6RhvMfYyLlFhmc6zak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oRa4DUB8Vn0W/hvKqH6Mc0mRtGhqDTDX3VOOYRF8zbClhfscN/WcD8DTuhWe+3LAeZ
         foXKwaHE+haDCiRfYKhfgr5Apdr23SWPtL6xbIpQWXAMloLs4F9i3Q/go+XZs6eXLDER
         pLdwaRbGC12584n0uL0QFD2WzFWMt7ws7wuAM=
Received: by 10.151.41.21 with SMTP id t21mr15820069ybj.71.1237983848348; Wed, 
	25 Mar 2009 05:24:08 -0700 (PDT)
In-Reply-To: <20090325122027.GB30873@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114597>

2009/3/25 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Mar 25, 2009 at 12:43:04PM +0100, Bert Wesarg wrote:
>> First I think the '#' is a leftover, second this is now a bashism.
> according to bash(1):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If pattern begins with #, it must match at=
 the beginning of the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0expanded value of parameter.
That is obviously true, I first removed this # and than switch to bash
(after it stills failed), so this was just thinking not testing.

>
> And I noticed, too, that this is a bashism. =C2=A0Using dash it fails=
, even
> with your patch.
>
> I would prefer to really fix it now.
Thanks. I intended this patch as a bug report.

Bert
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6=
nig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
>
