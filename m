From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: zsh completion broken for file completion
Date: Mon, 1 Apr 2013 03:30:45 -0600
Message-ID: <CAMP44s2kqpusjweXN522oum9mw2vPg4==jGzd2c3CbHzU5E3=g@mail.gmail.com>
References: <vpqtxowp9e2.fsf@grenoble-inp.fr>
	<512FA915.4080203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 11:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMb59-0007h5-SY
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 11:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636Ab3DAJar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 05:30:47 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:53924 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758632Ab3DAJar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 05:30:47 -0400
Received: by mail-la0-f53.google.com with SMTP id fr10so1922226lab.26
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=39Bp2ophcoupfu0Om0zfU5mnm8x4hx/wdm9ayICFNdg=;
        b=rjFlNZthmG5pS0gINoo6dC+Mojk2Fa+bp7otxHbSD+72ZbpiflRLmklKaXgDW6KoL2
         Gk9sJ/SSznmiMr5mGn/bu6fd+OffPKbzT/S2U+gB6rdHeEsM0ifZpayzZ2jXqY3pfqF5
         yELnHLwRvjC1mcWG6YZKtjaxWoxjBOSfceP7ZVIEeWFX2cNb7t/aKeMiRke1mfC7i/B3
         qK7WhSgvyIsYTkXroPfwfysb2gWX4Two7r4S45QsOceke0nlr06tFKYyjegX6P+0lxSB
         geWYBTitC48M1xuqEZG5Qc6YEC1KIoXKezgqOmaoFNj12GgzSreojx7GXDIx4/7dej1l
         tLqw==
X-Received: by 10.152.105.109 with SMTP id gl13mr5306390lab.40.1364808645588;
 Mon, 01 Apr 2013 02:30:45 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 02:30:45 -0700 (PDT)
In-Reply-To: <512FA915.4080203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219680>

On Thu, Feb 28, 2013 at 12:59 PM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
>
> [1] Basically, on my system I need the following change at the end of
>     the file:
>
>         -_git
>         +autoload -U +X compinit && compinit
>         +compdef _git git gitk
>
>     I don't know the reason, however; and it seems that it is a problem
>     only for me

Are you sourcing this script? If so, don't; do what is suggested at
the top: use fpath to load it automatically.

Cheers.

--
Felipe Contreras
