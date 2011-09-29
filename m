From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: RFC: reverse bisect
Date: Thu, 29 Sep 2011 16:42:32 +0200
Message-ID: <CAGdFq_gSD6SyoLgPOuQcBu9bwpK=VN18ezambN1HHD_AtmFzLA@mail.gmail.com>
References: <20110929142027.GA4936@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Vyskocil <mvyskocil@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 29 16:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9HpW-0003D9-AL
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 16:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab1I2OnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 10:43:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51923 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab1I2OnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 10:43:13 -0400
Received: by ywb5 with SMTP id 5so585326ywb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MWf3I+cluNIgURWrtkOZ5cbfCUurf78nsEAshwoh0e0=;
        b=otWAQ6VE89ZbzqQALWuPoAMwGRKrtNJb25TJ1Soraktm2bXVyVZ85aJR/S3lNShzUj
         OAhawMpKD0u27dREX/rtnC7DClsaW4fcYlPRst77+0RgnBB+7i8yLKQYmE6eLgmDgMgR
         eAG/0tS5p16Mdr7GYGwGnYqBDO8rhWGPrnjmI=
Received: by 10.68.32.133 with SMTP id j5mr52517410pbi.68.1317307392267; Thu,
 29 Sep 2011 07:43:12 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Thu, 29 Sep 2011 07:42:32 -0700 (PDT)
In-Reply-To: <20110929142027.GA4936@zelva.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182401>

Heya,

On Thu, Sep 29, 2011 at 16:20, Michal Vyskocil <mvyskocil@suse.cz> wrot=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "Some good revs are not an=
cestor of the bad rev.\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"git bisect ca=
nnot work properly in this case.\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Maybe you mistake=
 good and bad revs?\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Try --reverse to =
switch the bisect logic.\n");

Heh, glad to see the "Maybe you mistake" phrasing removed if nothing el=
se :P.

--=20
Cheers,

Sverre Rabbelier
