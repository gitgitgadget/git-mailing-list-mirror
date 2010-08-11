From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Can Git work for us if we are remotely hosted?
Date: Wed, 11 Aug 2010 19:06:22 -0400
Message-ID: <AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com>
References: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sultan Shakir <sshakirflhosp@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 01:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjKO4-00006p-3K
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 01:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072Ab0HKXGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 19:06:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62465 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996Ab0HKXGn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 19:06:43 -0400
Received: by wwj40 with SMTP id 40so757131wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UIK3qPA6MDiSVroKo295DdvPhUNfyx7oEcpIaOg1nLM=;
        b=W6gKrDErdYlcPDz27sbwdZumHcgsw/brtcE8+3h7zzzgqMzIbVXxXNprWxc4Zvbz6p
         XVFJ4W6O7S6Tj2V1uQflB2jtq8HUIcOfmrCN7ZWMnSKa683F+P8tyHNYkwliD9+QEqSj
         yCKQTnmMc47ef4fh/jeVtJwcMYax27pyxPgNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r2a0lxsInyCEn7mYnV6H5YUMdMJO2DAXwGej4A54zOaS10eeE/cFAIzr64F+J4wWBA
         l+eCSzGU81XNsobtrc4vBvzkYjJSzRl+04RXjowj59P1IuTa/RSDeuihUc8iGoC3dhKI
         6lQ9KLUrnbcu9rmp0qu5FbzX2ualx0Hf4kPTc=
Received: by 10.216.30.21 with SMTP id j21mr5899886wea.37.1281568002166; Wed,
 11 Aug 2010 16:06:42 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 11 Aug 2010 16:06:22 -0700 (PDT)
In-Reply-To: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153311>

On Wed, Aug 11, 2010 at 6:51 PM, Sultan Shakir <sshakirflhosp@gmail.com=
> wrote:
> I've been trying to wrap my brain around how I can get Git to work at
> my organization. =A0The issue is that nearly all of our programs and
> their IDE are remotely hosted. =A0This means that to even work on a f=
ile
> we have to connect to the network in order to use the application tha=
t
> we code in. =A0We do have access to the backend where the files are
> stored though. =A0How can we use Git in this situation without settin=
g
> up another server?

If you want, you could just push/pull to a git repo in a file share on
one of your existing fileservers.

Have fun,

Avery
