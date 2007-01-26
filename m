From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: detached HEAD
Date: Fri, 26 Jan 2007 11:15:51 +0100
Message-ID: <8aa486160701260215p6a0af653qf110aa2679452c6@mail.gmail.com>
References: <87zm875d9u.fsf@gmail.com>
	 <7vireu63rg.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160701260145i4c50d564n90967a07f7ee62a9@mail.gmail.com>
	 <7vveiuyup7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 11:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAO7g-0005Ru-V5
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbXAZKPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 05:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbXAZKPy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:15:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52467 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161022AbXAZKPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jan 2007 05:15:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so676746uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 02:15:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SXnHv3K52yxh8OTHIfP/a6xFPY9Yr9bD/cNgcLLo+CheI3sg9M6/DMAsOCrxuccsZXTp/nMhIFXgndFVIhRvvQlycgj8oHi32zZ+2VwrdUcUB3Ck9BOQrj0YKfSJ/to6IDj0E8V9KVBxukB9UjIFkcERuDVKC30/rafoi4BPBvw=
Received: by 10.78.134.12 with SMTP id h12mr644341hud.1169806551113;
        Fri, 26 Jan 2007 02:15:51 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 26 Jan 2007 02:15:50 -0800 (PST)
In-Reply-To: <7vveiuyup7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37832>

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> >> > diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
> >> > index 87d3d63..8cef425 100644
> >> > --- a/builtin-fmt-merge-msg.c
> >> > +++ b/builtin-fmt-merge-msg.c
> >> > @@ -331,7 +331,8 @@ int cmd_fmt_merge_msg(int argc, const char *=
*argv, const char *prefix)
> >> >                       printf(" of %s", srcs.list[i]);
> >> >       }
> >> >
> >> > -     if (!strcmp("master", current_branch))
> >> > +     if (!strcmp("master", current_branch) ||
> >> > +         !strcmp("HEAD", current_branch))
> >> >               putchar('\n');
> >> >       else
> >> >               printf(" into %s\n", current_branch);
> >>
> >> Hmph.
> >>
> >> The reason is?
> >
> > For me, 'Merge ... into master' and 'Merge ... into HEAD' are equal=
ly
> > useful, so do not show them by default. And git always merges into
> > HEAD.
>
> I was wondering if people might prefer rewording it to "into
> detached HEAD".

I prefer my patch, but your rewording is OK also.

Santi
