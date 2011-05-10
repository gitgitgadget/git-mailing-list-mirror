From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Tue, 10 May 2011 17:12:57 -0400
Message-ID: <BANLkTi=V23wUiyQavaCVBJ_vA+gnL9m00w@mail.gmail.com>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com> <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org> <20110509220459.GA3719@sigill.intra.peff.net>
 <BANLkTimUn9e=5CfDcvQdgNYY4_pqbi8peQ@mail.gmail.com> <20110510202003.GF14456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 23:13:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJuFJ-0004Ua-7k
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 23:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab1EJVN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 17:13:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43646 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1EJVN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 17:13:27 -0400
Received: by pzk9 with SMTP id 9so2999768pzk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Xn2XKqp5StFTwJZwU/H2Db1pe2k0BzKYRlMWZEwNJoE=;
        b=gI0kmVWEo+9n2z70C/yI0Fc5lBDJS+xTpJ0UIxu/5D5vLGhJKku7ALdNu96YulsY3c
         J25u2ltrdpKovaduuotFENiyZEGFtnZUS4tj1RKdkOR+MPMrw7Yyuq7Nts310JROb+f0
         lhqTp1huWuH7dWlAs82Hu2lsk8Df8XJw2wooo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=U5RWjRTTuK+9iEnwhRhQC253Q6M57zS2h0NY+AyXNfJdp/jtdQK52ODHVjhWudxG86
         EqRN/Buz7LKaJ57MeVL/5F6Xz7AlwlK3iS1G3pDOizaV45MmBq3UmDdIQgb8OqcUY8fk
         C8NGQbM1cTQDKyp1dsd9tdf7SUAXbnLluZ0HE=
Received: by 10.143.163.11 with SMTP id q11mr4446448wfo.428.1305062007166;
 Tue, 10 May 2011 14:13:27 -0700 (PDT)
Received: by 10.142.211.14 with HTTP; Tue, 10 May 2011 14:12:57 -0700 (PDT)
In-Reply-To: <20110510202003.GF14456@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173367>

On Tue, May 10, 2011 at 4:20 PM, Jeff King <peff@peff.net> wrote:
> Yeah, I have scripts to help with that sort of thing now. But that is
> often an unsatisfactory solution, because either:
>
> =C2=A01. Your Makefile is not version-controlled.

Sure, but your .git/config is similarly not version controlled.

>
> =C2=A02. Your are polluting the project history with stuff specific t=
o your
> =C2=A0 =C2=A0 workflow. I would not get very far proposing that git.g=
it's
> =C2=A0 =C2=A0 Makefile contain such a thing. :)
>
> That's how Junio ended up with his "Meta" directory (and I have one,
> too, but with drastically different things in it).

As well. :-)

j.
