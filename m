From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:38:11 +0530
Message-ID: <CALkWK0nS74ZiHkEk7uCg=yPB7m6FkmfmfU7vs7u-AENjPu-GCw@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com>
 <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com> <CALkWK0mMQJfJ7M=NGJdEs3np3Y32DwKUMVEYJf7xh+X6toWwNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqTS-0002aq-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764538Ab3DDUIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:08:54 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41343 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764467Ab3DDUIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:08:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so3506028ieb.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=O0Y4g4tGbe9w6C83t8U4A23WSjjLPm1PGWKc5HLgbTA=;
        b=ARi6CIvEmkxy/4fnkZyfb4t+WcnVX66Wor0/qSPg5XX9KPTpgy8OYGl4BEOAY/E8rb
         Xk9wA01L9LZ+0u1YjiGRiiypEw7zdZhKlboHkW3zcoZ3/CCx4OsL8vBd0YVLmxa88CsK
         JMR5wQGLEc1jqQWSOFZC3fz9QQ3lC34q8XBiIPpRWHYzvfvlQ2Q1hX7C4OfSdyvf5gwE
         Z7vrAqAzdQupiISDiaiDcb+QdJaItCBjhGvSgSyRdeEsIcCiGxv03Nuq/5xxTAxJlzoc
         /Kd+sMhMc/EqVFynValP1xd16M/HTfkLm3D9GzGz1+g+b3DgmqVJomYIF/oxmMyGuepa
         /Sqg==
X-Received: by 10.50.17.166 with SMTP id p6mr10760526igd.12.1365106131686;
 Thu, 04 Apr 2013 13:08:51 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 13:08:11 -0700 (PDT)
In-Reply-To: <CALkWK0mMQJfJ7M=NGJdEs3np3Y32DwKUMVEYJf7xh+X6toWwNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220086>

Ramkumar Ramachandra wrote:
> Just take the link's buffer with you everywhere.  All you have to do
> is git edit-link <name> and paste the file's contents there, instead
> of opening .gitmodules directly in your editor.

On this.  The buffer doesn't have to conform to a tight spec: we can
just expose a .gitconfig-like buffer and reduce it to a tight spec
before writing out.
