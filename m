From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 23:59:00 +0200
Message-ID: <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross> <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 23:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5MNX-0006E2-1X
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 23:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaGJV7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 17:59:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64095 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaGJV7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 17:59:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so261293obc.12
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SaIclLP3jXhgK+OZIeraGnc1MyMAbLQ+qvmGRKZRSEA=;
        b=VWSDA6wWxjII1sICCE0HvX75WWhZjriWvL+p39E7kvzfwVueUje4SmMiR95lZyvqMI
         IEfIFlLVwFg+DoDXqBDln1BCDCk+jKySRVvMEkxbHv016XOFoOmOuIqxQhfP6y8I1wzZ
         eGlCT8bYWAq/Ci2IRUSeZtRMzYQwxtMttcgNcMHq8kVRsIT8k6Hq193/R0oXCqtDOs5H
         mRa83jaQ8FRKz9NsTUZ2LM87ZjYb4OC8V5t61D6b9e6W10NYjAzW4TL9L8RxGyylOYiQ
         tfdVr/umvffYWML5Sov4mTGN+ClcCpLR1vAv1CUpHlEomBZcinTAqbXkRbrkne9fZl2o
         N+SA==
X-Received: by 10.182.142.69 with SMTP id ru5mr58599049obb.6.1405029580678;
 Thu, 10 Jul 2014 14:59:40 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 14:59:00 -0700 (PDT)
In-Reply-To: <1405025616.3775.6.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253222>

On Thu, Jul 10, 2014 at 10:53 PM, David Turner wrote:
> On Thu, 2014-07-10 at 22:44 +0200, Tuncer Ayaz wrote:
> > On Thu, Jul 10, 2014 at 10:33 PM, David Turner wrote:
> > > On Thu, 2014-07-10 at 21:59 +0200, Tuncer Ayaz wrote:
> > > > The changes in 745224e0 don't seem to build here with gcc-4.9 on
> > > > linux x64_64. Any idea what's wrong?
> > > >
> > > >     CC credential-store.o
> > > > In file included from /usr/lib/.../xmmintrin.h:31:0,
> > >
> > > What's in the ...?
> > >
> > > Because if you're using headers from a different version of gcc, that
> > > might explain it.
> >
> > /usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.0/include/emmintrin.h
>
> That seems fine to me.
>
> It looks like the error messages are coming from inside the system's
> header files (but this is sometimes misleading).  If you just try to
> compile
>
> #include <emmintrin.h>
> int main() { }
>
> with whatever options you use for git, does that work?  If not, I would
> say that you have a compiler setup problem.

The above test works on the same machine, so I'll
investigate what's going on when building git. Thanks.
