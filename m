From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 22:44:36 +0200
Message-ID: <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LDW-00052g-R1
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbaGJUpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:45:17 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50220 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaGJUpR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:45:17 -0400
Received: by mail-oa0-f53.google.com with SMTP id l6so161015oag.40
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P+IhnTtkz3N/AEQFW7NqApg9Q0dwEK/CGyZSfWnUdrM=;
        b=qIWAzgbMarCXN4JMVrPryZ9ianm+iCGVzIhELiEy7CLRFW8qi9tQb+ZR81tEtSjBSQ
         81DGy+7pG6QsOPB8Pefauz5Cv5Bw8SuOpM9bnLUxfQtzsXFKZKnf4t4/LuFKAkG75Sni
         34vQh7sDye5IbUjILs4DUlDWUcg4w5YpF+N+hGWvtyFwPiKoS1kVVekQsnrLGVFBwbUP
         K1z0XD9qpTVn3k7wH5xKWW3IYmsY5zCi8pFiIqgbq0WnqpJz2U7a2Zwez7RGC71llh/5
         ZJIUO+jLse+1s+Qz8UbZ+mPaNco4nPNIhzJCRsHCmaW20RYMtTYBtR61mwgqZawLCtVh
         115w==
X-Received: by 10.60.16.2 with SMTP id b2mr56975519oed.57.1405025116375; Thu,
 10 Jul 2014 13:45:16 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 13:44:36 -0700 (PDT)
In-Reply-To: <1405024438.3775.3.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253215>

On Thu, Jul 10, 2014 at 10:33 PM, David Turner wrote:
> On Thu, 2014-07-10 at 21:59 +0200, Tuncer Ayaz wrote:
> > The changes in 745224e0 don't seem to build here with gcc-4.9 on
> > linux x64_64. Any idea what's wrong?
> >
> >     CC credential-store.o
> > In file included from /usr/lib/.../xmmintrin.h:31:0,
>
> What's in the ...?
>
> Because if you're using headers from a different version of gcc, that
> might explain it.

/usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.0/include/emmintrin.h
