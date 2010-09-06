From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Mon, 6 Sep 2010 14:40:29 -0600
Message-ID: <AANLkTimaY6MmS8N+UHt43FCKh5v_hhWzWoRzdy_dPvOr@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
	<AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
	<AANLkTin3VykgwJyMaVNmDnjAU3_pkA0+cKn-GO0OSnBN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:40:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiUW-0005yJ-Na
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab0IFUkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:40:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40772 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0IFUka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:40:30 -0400
Received: by fxm13 with SMTP id 13so2645873fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wkRJlR6YiT3TyKF9JCaLucRaBWa8OCS46y/xu4QAx08=;
        b=GQednoGA1ascO/inrwwOd2JW6tQPOndD9RMdHcvkf27qVvnwjnnA7axmVPPTvkud5H
         cNXe8iOXXWPUkaWzumwaVgKIQmX1Rci4i/xctZvkWNZ1dZqJBKaTZeuRaJ2vrjlNVtJJ
         4swH3tePRnnrASusm1PA52kBHliLrGtLXhGy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GsfNR+uM3yl5Bop0YzWnmzbdv8MN4Wc4vnWp8Ffqx5Ycwqezfbd8AAYvE1x4uoKsio
         Fdh3GtWK1vKPMPmxQFX8PwF0R7751vFa5wrH3dz8XW/TvV23S0mqVDroIb/sKSy0VUxv
         rx4sjVIMmQjf/IlanL2YO4h59+j09ZeTjmm18=
Received: by 10.223.114.210 with SMTP id f18mr1926219faq.66.1283805629477;
 Mon, 06 Sep 2010 13:40:29 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 13:40:29 -0700 (PDT)
In-Reply-To: <AANLkTin3VykgwJyMaVNmDnjAU3_pkA0+cKn-GO0OSnBN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155613>

2010/9/6 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/9/6 Elijah Newren <newren@gmail.com>:
>> So, I downloaded your patches and even made sure to sort them
>> appropriately to fix the order, but I'm getting conflicts trying to
>> apply them (on top of current pu). =C2=A0What version did you base t=
hem on?
>
> It's considered best practice to base your patches on master if
> possible. You should only base them on next if you rely on a
> particular series that has already landed there. You should never bas=
e
> your patches on pu itself, on a topic in pu perhaps, but never on pu.

Ah, thanks for the reminder.  I probably should have mentioned that I
tried master and next too and had similar conflicts (I believe from
some of AEvar's testing changes in master modifying the makefile in
nearby locations, among other things).  But in any event, I'm in good
shape now.

I might have been able to make progress too, if I weren't being
distracted from sparse clones by this rename+D/F conflict problem
(though I think I've got it licked now...)

Elijah
