From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 11 Mar 2013 20:33:36 +0100
Message-ID: <513E3190.20100@gmail.com>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com> <vpq8v5uueug.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, felipe.contreras@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF8UF-0006t4-1H
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3CKTdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:33:47 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:61319 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3CKTdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:33:46 -0400
Received: by mail-ee0-f41.google.com with SMTP id c13so2343278eek.14
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=R34gndwrCXP/EdQZ17XPBYn598Vto8alwDat0DzjSns=;
        b=TbuYRXTx8AgzqF1ECkHLxcj8M1mkmS6kIJp5XmQQ2CcCUEB23hPyW1Z3IbgSFoCMJe
         s32GVHn9EIw5GxOZ96iIBcxLZGk02dHSVbgqAajzFYRbe60rD+v20VaEDYv+n5Ig7ozZ
         uWzJkBXBxf/Zgv0yXNS5ewsQbPEYIzhy2YQHcoVpdZCp4c8AQ1GjWXhBaoEJ3tAkWDwM
         k1xaseDHuInFw+hlQsRTSVgJ8yFguQZO0RaIOSRxYmXAq0TR4/KvGP7d23Zrji2dCXyM
         6ISSN7U6C4zTw6sBQ4KA+xtvz2xRCcObEWq7nI396mKkA4QfTBRk9EnG17qoMd7/foEy
         9e4Q==
X-Received: by 10.14.182.137 with SMTP id o9mr39413978eem.13.1363030424649;
        Mon, 11 Mar 2013 12:33:44 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.200.211])
        by mx.google.com with ESMTPS id 44sm25391281eek.5.2013.03.11.12.33.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 12:33:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <vpq8v5uueug.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217903>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/03/2013 16:37, Matthieu Moy ha scritto:
> [...]
> I could reproduce with ~/.zshrc containing just:
> 
> ----------------------------------------------
> fpath=(${HOME}/usr/etc/zsh ${fpath})
> 
> autoload -Uz compinit
> compinit
> 
> eval "`dircolors`"
> zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
> ----------------------------------------------
> 
> ${HOME}/usr/etc/zsh contains two links _git and git-completion.bash
> pointing to Git's completion scripts in contrib/.
> 

Using this configuration I still can't reproduce the problem, using
git v1.8.2-rc3-8-g0c91a6f.

But I'm not a zsh expert.



Regards   Manlio Perillo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE+MZAACgkQscQJ24LbaUSTuACfYmZV9cvroPzBUdJspw9abh24
fk8AnRTjvCEJ3m8Y2m/5jCIVVNsJAcG7
=5p6c
-----END PGP SIGNATURE-----
