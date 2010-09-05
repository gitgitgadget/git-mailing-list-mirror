From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 5 Sep 2010 18:25:42 +0100
Message-ID: <AANLkTim8XLB5SjV3JtWT-ARN_XuofKDjYRSYT8kPxEvq@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
	<alpine.LFD.2.00.1009041107180.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 19:25:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsIyS-0004uF-LW
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0IERZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 13:25:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35503 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0IERZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 13:25:43 -0400
Received: by vws3 with SMTP id 3so2714456vws.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DmnKoh+zrwkR2FxR8Hqp96PTOODkLirUSKywF3z8w64=;
        b=Lgj341GGqyWUXrb6h2AFIjl1Q+VM5ZffkPTD1AbU7XmSqhUg7rOlpCtDm6HBjq3sEE
         sEltoIOh+W2SPpoyY8G2EGv7XjrSydeFYV2eVB5dXdsdxMHxsXLYc5AeQf5LaAa7tn+z
         w+vB6zSLXjRSk9rvif6Ck2xpDCPbsfDbvLxRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j6Fci3y9X4Q6lakNeCZi9CRVnd3MU21rLAorKv+zMOhEi5ycGWmImDSDGqKhEDfr3P
         cW1gkuU9TIsuRJqhFw0L2MPzG3dzi0MGSUwKccGMkvYMAB3Yuqz9sTxbDwQm03KcRHp2
         fF1YCAXzZhdOBf6kmpZhkmNTVnsOo1Bwrh1ws=
Received: by 10.220.62.5 with SMTP id v5mr1461435vch.242.1283707542683; Sun,
 05 Sep 2010 10:25:42 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sun, 5 Sep 2010 10:25:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009041107180.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155463>

On Sun, Sep 5, 2010 at 2:18 AM, Nicolas Pitre <nico@fluxnic.net> wrote
> I agree. =C2=A0So far it has been an interesting topic for discussion=
, but in
> practice I doubt the actual benefits will justify the required effort=
s
> and/or constraints on the protocol. Otherwise we would have a working
> implementation in use already. =C2=A0People tried in the past, and so=
 far
> none of those attempts passed the reality test nor kept people motiva=
ted
> enough to work on them further.

 then i'm all the more grateful that you continue to drop technical
hints in my direction.  thank you for not judging.

 l.
