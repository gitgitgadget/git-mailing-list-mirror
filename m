From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] parse-remote: handle detached HEAD
Date: Mon, 6 Dec 2010 00:49:39 +0100
Message-ID: <AANLkTi=yfuiFuatshYuS2Q0EV0Ytj-QFKpuXAWeGerQB@mail.gmail.com>
References: <1291592835-29949-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 00:55:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPOQk-0006bz-GA
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 00:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab0LEXzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 18:55:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48406 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab0LEXzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 18:55:41 -0500
Received: by ywl5 with SMTP id 5so5694148ywl.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=57SRgnw7dyDruM3w+RJPEXJuyGYXnbPRIwwSbHHmUTo=;
        b=d/EfuahGgDD54D94+nIsoJu+f+5s1vCpJEtmgB1DCpduX2Nxf2aAJ7pVrP2YEPXT22
         ULic7z+jW2yc160XbGEq2rcVSEY97/7B3aIEC35yNQSAhedJvwYGNDxi/wGSpK5lLzb5
         w5/Fsq/ckBFxeswKQm2ixgiFagLMSgZ0SsHTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gL44AaTD/7QYPhAHVUUYY1x1lMzC8qhcu4tgHHmnVD83C0Qc8cpGoDEZQQVG88VMx9
         MEft5uGz304Z/7Pn9jLlmiDC9vaNhic722cjY0df9UFA4gRIgtHgdmUQoXlvxmXGlk81
         MVKEKZS0pfLAQp//KgbJmmt4XQ+gMYoHafbac=
Received: by 10.151.109.13 with SMTP id l13mr8363882ybm.17.1291592999776; Sun,
 05 Dec 2010 15:49:59 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Sun, 5 Dec 2010 15:49:39 -0800 (PST)
In-Reply-To: <1291592835-29949-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162966>

Heya,

On Mon, Dec 6, 2010 at 00:47, Santi B=C3=A9jar <santi@agolina.net> wrot=
e:
> This fixes a bug reported by Sverre Rabbelier. The overall results
> were correct but not the output text.

I think we usually use:

Reported-by: Sverre Rabbelier <srabbelier@gmail.com>

But since I already verified the fix, perhaps just:

Tested-by: Sverre Rabbelier <srabbelier@gmail.com>

is enough? Both are fine with me.

--=20
Cheers,

Sverre Rabbelier
