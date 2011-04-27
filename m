From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Wed, 27 Apr 2011 20:17:15 +0300
Message-ID: <BANLkTi=tsgfteYRj8iODZifZuepVCJGq1w@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<BANLkTinep961dg9v3TD8hZZAvTYL3_H+xg@mail.gmail.com>
	<7vzknb8wgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Pe-0004Zb-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499Ab1D0RU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 13:20:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37812 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab1D0RUZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 13:20:25 -0400
Received: by fxm17 with SMTP id 17so1276664fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EJcPbzelvauzWly+d1pPGSckeI2uMR+o5ypCj1ngtfI=;
        b=hufV3DRgqzpp9m7BQtLYlkJhcoP+TM79EDtJBvEy8zs6H8RRWm00ckFzs5H0rfS3wG
         purCH0QNenmY6s8bULepjJ2zTj4NY8yp10oiyPR4np9oLNpqwDMXLJLSRq86R8EFIiU8
         s13SLKODAiE7gC0XgNYGi3md3uzwk/CMthA5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hKgbj9TTbEu0b6fe8E9um/yBLx500SqibMvWaXRjiB1+wCmY1ba0YfGUgDkmyctnSB
         gYgkvwM+lbiyG9HwIq/coHGlZ2tk3l4QhSGHZeRlRbiKb3wi0Id8T4Vsqo2AdO4mDY8m
         rBM6js8yI0FKKqTBrJf3E4W3ZvdlU7ATsU/c0=
Received: by 10.223.87.16 with SMTP id u16mr2651988fal.13.1303924635535; Wed,
 27 Apr 2011 10:17:15 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 10:17:15 -0700 (PDT)
In-Reply-To: <7vzknb8wgd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172248>

On Wed, Apr 27, 2011 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Apr 27, 2011 at 7:55 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> ...
>>> I'd love to share the enthusiasm, but find that "as we can see" nee=
ds a
>>> much more clarification.
>>
>> Jonathan already described it:
>> http://article.gmane.org/gmane.comp.version-control.git/170665
>>
>> And this snipped demonstrates it:
>> ...
>
> When I say "needs more clarification" during a review, I am not askin=
g the
> contributor to explain it in the discussion thread to _me_ who happen=
 to
> be asking at that moment. =C2=A0I am asking the contributor to explai=
n it to
> people who will read "git log" output 6 months down the road.
>
> You have been here long enough to know that "Jonathan already describ=
ed
> it" that is not connected in the commit that is going to be recorded =
is
> not something we appreciate, no?

How is one supposed to know when the clarification is sufficient or
not? Are you advocating communication through git patches?

I prefer to discuss in the mailing list, and when there's consensus
fire 'git send-email', that's what they do in lkml.

> In any case, the message of Jonathan's
>
> =C2=A0 =C2=A0Subject: [RFC/PATCH] completion: avoid "words" as variab=
le name for zsh portability
> =C2=A0 =C2=A0Date: Wed, 27 Apr 2011 01:40:34 -0500
> =C2=A0 =C2=A0Message-ID: <20110427064033.GB4226@elie>
>
> seems to explain it better. =C2=A0The naming of variables and other d=
etails
> might need to be settled, but other than that is it correct to unders=
tand
> that we will see a final version along the line of that patch?

I prefer something short, and to the point:

---
git-completion: fix zsh support

Support for zsh was broken on commit da48616f1d[1], due to the fact
that 'words' is a is a special variable used by zsh completion[2].

Jonathan Nieder found that 'typset -h' resets that special behavior,
which is exactly what we want. So alias the currently used 'local' to
that.

[1] http://article.gmane.org/gmane.comp.version-control.git/170665
[2] http://article.gmane.org/gmane.comp.shells.zsh.devel/22484
---

--=20
=46elipe Contreras
