From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitk: spelling fix in German translation
Date: Wed, 18 May 2011 11:06:04 +0200
Message-ID: <4DD38BFC.4040301@drmicha.warpmail.net>
References: <1305663509-5057-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 18 11:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMchr-00083K-W4
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 11:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756Ab1ERJGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 05:06:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41618 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755445Ab1ERJGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 05:06:09 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A41D20BD5;
	Wed, 18 May 2011 05:06:08 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 18 May 2011 05:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HcaS8PUVK72w39vaf+2iHgcCie0=; b=pDHkNU7tk6d2wiR4fUoqaKiFz6wKNgykr8I9suoTopI9mbodVNvbzoXnzfI9zK1Shx0TC4ba3FeDXa/9V8+qflMg7qcZIUSrTxzB1KEZgj9dgMr4Pt84zrp1AHxThgvGVsVFQq3xe5mw7aVZuGyg0tEAR1UZND2AC4QFadkC+n4=
X-Sasl-enc: R7KcWI53//4sokG30eqcq7cn9w7DR8W4FJOAjtOiuFbD 1305709568
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 05324445CBB;
	Wed, 18 May 2011 05:06:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1305663509-5057-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173866>

Ralf Thielow venit, vidit, dixit 17.05.2011 22:18:
> Fixed a spelling mistake in German translation. "positive integer" is
> not correctly translated to "ganzzahliger Wert" because "ganzzahliger=
 Wert"
> also includes negative values.

That's actually not a spelling fix but a fix for a wrong translation.

The fix itself is good, though I'm wondering about the original message=
:
do we skip <n> or do we show only <n>?

> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
> ---
>  gitk-git/po/de.po |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitk-git/po/de.po b/gitk-git/po/de.po
> index bd194a3..55e8467 100644
> --- a/gitk-git/po/de.po
> +++ b/gitk-git/po/de.po
> @@ -652,7 +652,7 @@ msgstr "Bis:"
> =20
>  #: gitk:3835
>  msgid "Limit and/or skip a number of revisions (positive integer):"
> -msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (ganz=
zahliger Wert):"
> +msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (posi=
tiver ganzzahliger Wert):"
> =20
>  #: gitk:3836
>  msgid "Number to show:"
