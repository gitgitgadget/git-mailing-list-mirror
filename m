From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Further changes, thanks to <tp@lists.linux.it>
Date: Wed, 8 Aug 2007 23:50:41 +0200
Message-ID: <4d8e3fd30708081450n142bfea6tb30f063da0559f2e@mail.gmail.com>
References: <20070808172739.5647a81b@paolo-desktop>
	 <200708082304.53867.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItQV-0002mZ-GY
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXHHVun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXHHVun
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:50:43 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:5278 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbXHHVum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 17:50:42 -0400
Received: by nz-out-0506.google.com with SMTP id s18so149177nze
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 14:50:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRZ+ZY/npnO2OIIpiwc47bX67dA52cztAg2B4CJlerxdLmrP0LX8L26XUPfB3COdLlm5bRfqmROmfjSh6mxMmsilGFrrJYSPGfcX5H8Mvp0vb8Dzo7Eg1NNwhxYTg9KmofmUQe4HD4a8Z9d/dAi2VrMSv9CREhRnNTaM+GhdwPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EdYUIxAS2kTNRCxrgDPNaxsJHt13nglRD2mrrRQXNJ/DMEviyemJnwN/FVzLpdg+7Hm5XTXtfXSqRIcCSNOdzWrQQ21stbunXUfVJpx5BKyWhzTqU0eLedxAbnDWMwMRebZ8WJHsuIzh5v9nb+RxKReTGAnj9htcES+OXvkgxRM=
Received: by 10.143.1.2 with SMTP id d2mr41375wfi.1186609841277;
        Wed, 08 Aug 2007 14:50:41 -0700 (PDT)
Received: by 10.143.163.10 with HTTP; Wed, 8 Aug 2007 14:50:41 -0700 (PDT)
In-Reply-To: <200708082304.53867.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55376>

On 8/8/07, Michael <barra_cuda@katamail.com> wrote:
> On Wednesday 08 August 2007 17:27, Paolo Ciarrocchi wrote:
> > Further changes, thanks to <tp@lists.linux.it>
> >
> > Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> > ---
>
> Is it just me, or this patch is corrupted?
>
> >  po/it.po |  130
> > ++++++++++++++++++++++++++++++++------------------------------ 1 fi=
les
> > changed, 67 insertions(+), 63 deletions(-)
>
> git-am says:
>
>         Applying Further changes, thanks to <tp@lists.linux.it>
>
>         fatal: corrupt patch at line 13
>         Patch failed at 0001.
>
> git-gui-i18n$ grep ^- .dotest/0001 | wc
>      66     434    3074
> git-gui-i18n$ grep ^+ .dotest/0001 | wc
>      27     105     955
>
> I think there's a problem somewhere...
>
> > diff --git a/po/it.po b/po/it.po
> > index e87263e..1950b56 100644
> > --- a/po/it.po
> > +++ b/po/it.po
> > @@ -2,18 +2,21 @@
> >  # Copyright (C) 2007 Shawn Pearce
> >  # This file is distributed under the same license as the git-gui
> > package. # Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007
>
> Whitespace/newline corruption?
>
> > -"Content-Type: text/plain; charset=3DUTF-8\n"
> > -"Content-Transfer-Encoding: 8bit\n"
> > +"Content-Type: text/plain; charset=3Diso-8859-1\n"
> > +"Content-Transfer-Encoding: 8bit"
>
> I'd guess the previous version is better :)
>
> > @@ -34,9 +37,9 @@ msgid ""
> >  "\n"
> >  "Assume '%s' is version 1.5.0?\n"
> >  msgstr ""
> > -"La versione di GIT non pu=F2 essere determinata.\n"
> >  "\n"
> > -"%s sostiene che la versione =E8 '%s'.\n"
> >  "\n"
> >  "%s richiede almeno Git 1.5.0 o superiore.\n"
> >  "\n"
>
> Here and in many other places there are unneeded deletions... Is
> that what you wanted? I don't think so, since the hunk header says
> "@@ -34,9 +37,9 @@". I guess gmail has done a mess with your
> patch: git-am had some problems parsing the headers too.
>
> You should try to mail the same patch to yourself and re-apply that o=
n
> your tree to see if it fails.

I don't know what happened :-(

I'll redo the patch.

Thanks.

Regards,

--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
