From: Peter Dave Hello <hsu@peterdavehello.org>
Subject: Re: contrib/diff-highlight: stop hard-coding perl location
Date: Mon, 22 Feb 2016 14:49:57 +0800
Message-ID: <CA+boQ6bCH35hu9GfQY_P5bNZCdJ8Knr8zQ+S41RGF0z-JamVgw@mail.gmail.com>
References: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
 <CAPig+cSE77JbD9CShrxnFsDLd9DrG9L15BSecERk_Qih9CMOig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:50:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXkKU-0003v1-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 07:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbcBVGum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 01:50:42 -0500
Received: from sender163-mail.zoho.com ([74.201.84.163]:25367 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbcBVGum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 01:50:42 -0500
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com [209.85.220.174]) by mx.zohomail.com
	with SMTPS id 1456123838440901.386625081597; Sun, 21 Feb 2016 22:50:38 -0800 (PST)
Received: by mail-qk0-f174.google.com with SMTP id s68so52390735qkh.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 22:50:38 -0800 (PST)
Received: by 10.140.37.69 with HTTP; Sun, 21 Feb 2016 22:49:57 -0800 (PST)
X-Gm-Message-State: AG10YOTw9yQyPpFPLXZ9d8simCGdJHYKayTor8EF6bajz7aXE5TlOnZAwTNFAq1ntLUgFgZtky8ZBxRiVMcndw==
X-Received: by 10.55.78.131 with SMTP id c125mr32446533qkb.71.1456123837505;
 Sun, 21 Feb 2016 22:50:37 -0800 (PST)
In-Reply-To: <CAPig+cSE77JbD9CShrxnFsDLd9DrG9L15BSecERk_Qih9CMOig@mail.gmail.com>
X-Gmail-Original-Message-ID: <CA+boQ6bCH35hu9GfQY_P5bNZCdJ8Knr8zQ+S41RGF0z-JamVgw@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286885>

Hi Eric,

Thank you, is there anything I should do? Or I should just wait?

Best,
Peter

2016/2/22 =E4=B8=8B=E5=8D=881:56=E6=96=BC "Eric Sunshine" <sunshine@sun=
shineco.com>=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Feb 22, 2016 at 12:54 AM, Peter Dave Hello
> <hsu@peterdavehello.org> wrote:
> > From: Peter Dave Hello <hsu@peterdavehello.org>
> >
> > Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`,
> > the util "env" can help located the "perl",
> > so that it can work on FreeBSD and other platforms.
> >
> > Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
>
> Better, thanks.
>
> > ---
> >  contrib/diff-highlight/diff-highlight | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/diff-highlight/diff-highlight
> > b/contrib/diff-highlight/diff-highlight
> > index ffefc31..b57b0fd 100755
> > --- a/contrib/diff-highlight/diff-highlight
> > +++ b/contrib/diff-highlight/diff-highlight
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/perl
> > +#!/usr/bin/env perl
> >
> >  use 5.008;
> >  use warnings FATAL =3D> 'all';
