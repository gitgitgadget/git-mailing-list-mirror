From: Jari Pennanen <jari.pennanen@gmail.com>
Subject: Re: Configurable .gitignore filename?
Date: Mon, 4 Mar 2013 17:47:26 +0200
Message-ID: <CACoicvKMWSjU6Lf-2PsCShzqGiX-=2xF9+W0EtrHUzWPU7-T_A@mail.gmail.com>
References: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
	<vpqzjyjp8y0.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 04 16:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCXcH-00065P-QL
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 16:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224Ab3CDPr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 10:47:28 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:57073 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546Ab3CDPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 10:47:27 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so9422898oag.29
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 07:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UCRwY5gOWLn1ZR9/Xmlb/eDh2e2Ate3BXWRsF0ytGfI=;
        b=akTShDOrbHul6xbCx9P4OFm5T/HjAicLm946b7iHc5P9NBS46BxmPwgOQ1STUXVTiW
         JMTLdjEEIdaA7zyrneWDwTUq31PoPievRbIF+i5HzfY4GDzAZiyWFe0SFcW5lAiRm5yX
         AugT+MB6v3kB7TlSbUy2WUxcu/EzkshP8/v8KYLSOHRgOWPjw2GRiu5Fmn2945y6reB2
         FgiaVrwnHgYGU3ICjoHK9+AW3n5AsVU7UzkqWi2ivfTYIwaWB6C5NOJmFJuFQ7LzcD5g
         4IyXxBDyulPTLvtZP08An+2nArywA/xHhYoqf6a0jiT5J4wC7+LERZrCKDrjSjHMruV9
         wMmw==
X-Received: by 10.182.88.103 with SMTP id bf7mr16072209obb.7.1362412046607;
 Mon, 04 Mar 2013 07:47:26 -0800 (PST)
Received: by 10.76.22.197 with HTTP; Mon, 4 Mar 2013 07:47:26 -0800 (PST)
In-Reply-To: <vpqzjyjp8y0.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217400>

2013/3/4 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> There is already core.excludesfile, which does not replace the usual
> .gitignore but comes in addition. The common use is a user-wide ignore
> file, not a per-directory one.

I'm actually aware of that. Problem is the normal .gitignore files
must *not* be used in the second GIT_DIR at all, in my case it's for
syncing so I need to sync almost all files (including stuff inside
.gitignore), though I'd still like to retain some ignore files for
second GIT_DIR, e.g. like in rsync the .rsync-filter file.
