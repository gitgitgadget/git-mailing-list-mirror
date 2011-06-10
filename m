From: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Fri, 10 Jun 2011 08:31:41 +0200
Message-ID: <BANLkTimruGZsh0aq7gOKmLUiJFwz3beU3g@mail.gmail.com>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> <20110610002137.GA11585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	git@vger.kernel.org, Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUvGL-0004ta-O6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 08:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1FJGcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 02:32:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36833 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1FJGcC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 02:32:02 -0400
Received: by vws1 with SMTP id 1so1849745vws.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=587b+dLdrRuHuuctudf9/YrNdU94F8hVbg0ySvcWnz0=;
        b=FNwWTX/0vThooiF0fZ5Oe6A+IuLFtzsMvKY5/Y4euOwAjygyr5yb5e1DTSSK0R2lKJ
         ZNCoS2Iz1E8QjcPAKBXf1A4a22EfI8yYj92B76urY91FCs7Jw0yuYIEJJ03hlcJl/ZDJ
         qK9Hx6S+7vaicQtBfs3ZxWmVba0JqeI1Mm27Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Bon7DxoCIKP4BuUdjTKsxZlIBUrwPecgtiSzktSfrEp41WqIOadvuDI1JteKW1Uz7J
         RfyBPpbp+J0KiHaoSdusT7SQrQhMwkBTm71373vXanI75lX+kMUsSw/sQgk7IzxZspp/
         iX0XGOYgqUkbv9rR4JNnG6rI599ZU0fhcKa4k=
Received: by 10.220.16.80 with SMTP id n16mr654714vca.117.1307687521109; Thu,
 09 Jun 2011 23:32:01 -0700 (PDT)
Received: by 10.220.194.68 with HTTP; Thu, 9 Jun 2011 23:31:41 -0700 (PDT)
In-Reply-To: <20110610002137.GA11585@sigill.intra.peff.net>
X-Google-Sender-Auth: Uy7SyuSrCGtGvj3AZBc_fIg_kWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175596>

Hi !

What you did there is great !
It'll help clarify the command.

2011/6/10 Jeff King <peff@peff.net>:
> On Thu, Jun 09, 2011 at 03:15:59PM +0200, Jeremie Nikaes wrote:
> Earlier today I posted a 10-patch series to allow git to handle
> something like:
>
> =A0git clone \
> =A0 =A0-c mediawiki.page=3DGitWorkflows \
> =A0 =A0-c mediawiki.page=3DTig \
> =A0 =A0https://git.wiki.kernel.org
>

So we give up on the mediawiki prefix (mediawiki::https://git.wiki.kern=
el.org)
when it comes to partial cloning ?

Regards

--=20
Arnaud Lacurie
