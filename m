From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Add help target
Date: Wed, 25 Aug 2010 11:27:48 -0500
Message-ID: <AANLkTi=+f4Q6JJHfX75A57-gzBxqsdr+CrCf9Z9fqrEq@mail.gmail.com>
References: <1282729913-25114-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 18:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoIpi-0007WE-QP
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 18:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab0HYQ2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 12:28:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39095 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab0HYQ2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 12:28:09 -0400
Received: by yxg6 with SMTP id 6so249722yxg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3NnBQlHmjKOzxtwQX967Jooac2sc+Um47Riep7J4zZs=;
        b=WRIRtTqpzqhfH6c+S5AgHQ25BIQ3QKjzGwlMjpgws+mOymkFSbWT0hRRyEnRcrlivh
         yQ579DJJ68vdBOld52ipDhfY9Y6u4cf4EdGbJ6v2xu1vDmk2a620LG1uTRKJ6tZaKy9G
         YwAt+3mYV75cNFg/u0Lvd7H0nzlhxIcT9vrQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Jr8iYAhsx/AMstGksSKKl0w+d9BkHDpaL55d8LVOpDdM3+nThfICkllx2v5qHCrt3A
         hB5zjs0+U0YEz2AwWwzReRFor+wQUidLPYYt+xr0wfA6FfJvNdfiZWjzjRzCq/RhMEr2
         tJ4JPnpptvziUtzscoRwCFoBgD7G+vxV2uR74=
Received: by 10.150.31.13 with SMTP id e13mr8581801ybe.302.1282753688302; Wed,
 25 Aug 2010 09:28:08 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Wed, 25 Aug 2010 09:27:48 -0700 (PDT)
In-Reply-To: <1282729913-25114-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154448>

Heya,

On Wed, Aug 25, 2010 at 04:51, Stephen Boyd <bebarino@gmail.com> wrote:
> Today I forgot whether the target was quick-install-doc or
> install-quick-doc and had to open the Makefile again to find out. I'd
> rather not do that and just use:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ make help
>
> to get a quick summary of the interesting targets when my brain fails=
 to
> refresh. Add a help target, but don't add uninteresting things like
> strip, install-gitweb, or targets which alias (install-man).

Yes please, it would be even better if you're willing to make sure
that this stays up to date ;).

--=20
Cheers,

Sverre Rabbelier
