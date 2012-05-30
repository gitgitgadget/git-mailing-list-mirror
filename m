From: David Michael Barr <davidbarr@google.com>
Subject: Re: 1.7.10.3 configure does not generate Makefiles
Date: Wed, 30 May 2012 21:38:46 +1000
Message-ID: <CAFfmPPMb6bsD8uCDsPOx7862-a6NE+POy7ccEbVnFJREgN4b=A@mail.gmail.com>
References: <20120529233238.GC3072@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: jupiter.hce@gmail.com
X-From: git-owner@vger.kernel.org Wed May 30 13:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZhEp-0000zu-K9
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab2E3Lir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:38:47 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34954 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2E3Lir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:38:47 -0400
Received: by gglu4 with SMTP id u4so3349251ggl.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=Pyat9AOjxikHTb10ZAPH2PUliJSrCIfwm5jzt/wjyYw=;
        b=XqGqsBUWWVizMOf5wFbUGmop9UajLw/jRM6bbZ9mbdJ/hUAT+JfMqjjB4i8av2IYJC
         zfqjcDlbgT+IJ6/g6cJ9YkvML87kqAwPMvo59CqhM98watSaLwcVfE8Psbff0JkmYmok
         zIsVYWifm3b8PMOsb0off2iXUSAGVDywJmGIU8cKjyjSTc1CI8dqOhaW3BuK8zvm7gx4
         aoR139KRfWqeo0mVkM43EBlaxCbTK31d6C4uN3rtab8WfRU+yhip9wUAgkgQ5kDJEvZw
         dy7oNMZiFx9ViVM6ThpAHV9sS6bGd3sdLrPXDNZIB7BieqIHT41XREhxet1o4jdrAciw
         F1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=Pyat9AOjxikHTb10ZAPH2PUliJSrCIfwm5jzt/wjyYw=;
        b=QtSxDry5qrDCLmehsNHjOdin4qFTGITdd0BcPHhIPc4uHyfUvKBgAnUszDhhVX3/pJ
         WqetRcSXprzzI9zCzCDe/6leeKyXtvqpxH9GFqANz1etzowY/iGys89Fqv9gyYTKUqjR
         01Oq5Rme9Et5wTq0ctSrt3d0ELw0Jelx3tyN/RdXpps69tfi6yoYHlc1ijIntdN7Y9Xf
         4VtkZhIxTTJvLX78s2mhrx5ke8zuvcqb9LPpoj1nJa814IHDVtiYcC/NCzEsdDdiyR01
         eMb7OtEBaM77Em3LrYPiOBTTU97QftqLJL4QwdKlDL0EncjvdwOHYzisoMr4xs7xGH3e
         yZDw==
Received: by 10.101.6.28 with SMTP id j28mr4517752ani.61.1338377926316;
        Wed, 30 May 2012 04:38:46 -0700 (PDT)
Received: by 10.101.6.28 with SMTP id j28mr4517742ani.61.1338377926140; Wed,
 30 May 2012 04:38:46 -0700 (PDT)
Received: by 10.101.155.23 with HTTP; Wed, 30 May 2012 04:38:46 -0700 (PDT)
In-Reply-To: <20120529233238.GC3072@gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmNV8liKMTCAOHG1HiWA7v01Vu0bV0jFoaJcZzKNwXSyJtSDj1g3ygMMWzc32rgwLonpdF+6GhlgKjZbg67deC2gX2zv1BARak1vWBi+958iFXRNcwv7nimFI1CFfxVJ8ZtDt9PhSHJheNcoCCMhre3GelljA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198803>

On Wed, May 30, 2012 at 9:32 AM,  <jupiter.hce@gmail.com> wrote:
> Hi,
>
> I've just downloaded 1.7.10.3 source tarball and following the
> instruction from INSTALL, I ran the autoconf to generate the
> configure, then to run configure --prefix=/usr/local/git/1.7.10.3.
> There were no errors but there was no Makefiles generated either. How
> can I run the configure to generate Makefiles?
>
> .......
> configure: creating ./config.status
> config.status: creating config.mak.autogen
                          ^^^^^^^^^^^^^^^^^^

That file is included by Makefile.
So your next steps is: make.

--
David Barr
