From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 16:12:30 +0000
Message-ID: <43d8ce650903030812n6fe857atb773f5068b6f0a17@mail.gmail.com>
References: <49AD3E78.1050706@sneakemail.com>
	 <20090303152333.GB24593@coredump.intra.peff.net>
	 <20090303154041.GA31265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXGI-0007xb-1b
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477AbZCCQMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZCCQMe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:12:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:15373 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbZCCQMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:12:33 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3375946wfa.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mRWYEcT85TS27Q0oJbzUnrYjUUh7nP/vRSrD2TpAvNU=;
        b=FuX+bEfJrwcNTdiDqaMZxh0t0MlOjOTKjmYXB9lhbWHDIl6Rldxe+IqoC0XjCtOd4l
         SUrHUQqT7OIp+ojlstHgcBGcdHP9nBW3PJc+lwCyGPeL3K0TJROz6RpCIjb4wNUVkFM4
         d2DV15DW04E8bpGtUr6VHHdWsj3Y0nai39PtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CbiP/hWU9/1JJnnCzBww1cjwSkBLIW2K3EE+X+7LOkMWE8m463wY2FkE0PBJtBcXqz
         sdsxh8xyb6v3qWlbPjW5xkNjv2j8tqfMfc+5tv6fOLRduK72CmWsZ67bY0cn1B+bUnbI
         Z66F7cgrfaCLVVEMU/WC6ni/z1SIP1EEdNT9M=
Received: by 10.142.144.16 with SMTP id r16mr3672185wfd.214.1236096750845; 
	Tue, 03 Mar 2009 08:12:30 -0800 (PST)
In-Reply-To: <20090303154041.GA31265@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112102>

2009/3/3 Jeff King <peff@peff.net>:
> The existing text was very vague about what exactly it means
> for difference to "contain" a change. This seems to cause
> confusion on the mailing list every month or two.
>
> To fix it we:
>
> =C2=A01. use "introduce or remove an instance of" instead of
> =C2=A0 =C2=A0 "contain"

I would read this to mean that it doesn't include modifying a line
containing that string.  But I also know that underneath the hood, a
change is a remove then an addition, so I would be confused :)

What about saying "modifies" rather than "contain" ?

>
> =C2=A02. point the user to gitdiffcore(7), which contains a more
> =C2=A0 =C2=A0 complete explanation
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I wonder if "gitdiffcore" is a little scary for new people who just w=
ant
> to use "-S", but hopefully point (1) above will get rid of most of th=
e
> confusion, and those who follow the link want to learn all about diff=
=2E
>
> =C2=A0Documentation/diff-options.txt | =C2=A0 =C2=A05 ++++-
> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-opti=
ons.txt
> index 813a7b1..9276fae 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -176,7 +176,10 @@ override configuration settings.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0number.
>
> =C2=A0-S<string>::
> - =C2=A0 =C2=A0 =C2=A0 Look for differences that contain the change i=
n <string>.
> + =C2=A0 =C2=A0 =C2=A0 Look for differences that introduce or remove =
an instance of
> + =C2=A0 =C2=A0 =C2=A0 <string>. Note that this is different than the=
 string simply
> + =C2=A0 =C2=A0 =C2=A0 appearing in diff output; see the 'pickaxe' en=
try in
> + =C2=A0 =C2=A0 =C2=A0 linkgit:gitdiffcore[7] for more details.
>
> =C2=A0--pickaxe-all::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0When -S finds a change, show all the chang=
es in that
> --
> 1.6.2.rc2.330.gba39e
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
