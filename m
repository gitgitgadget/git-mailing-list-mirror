From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Added hint about using .gitignore in git status while 
	printing untracked files
Date: Thu, 18 Feb 2010 16:58:27 +0530
Message-ID: <e72faaa81002180328g65e10fbdqf483dcb527bcac27@mail.gmail.com>
References: <e72faaa81002180148k47881f47qdfd5d268e4b2b44@mail.gmail.com>
	 <alpine.DEB.2.00.1002181058450.11095@ds9.cixit.se>
	 <4B7D21A0.4000706@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 12:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4Yj-0002Fm-E7
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab0BRL2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 06:28:30 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:42965 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab0BRL22 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 06:28:28 -0500
Received: by ywh27 with SMTP id 27so855861ywh.22
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0k0cZ4+kVmvJnINuDkRc8OdmrqBqvbBWtHEdpFzTVu8=;
        b=YiQE5aOQB9wFcjH6s/oGafhMiGmTi6+Euqc5cLOwknXiIPZvCzEw31zijnfbC3Sz0K
         jKlHxllh3MX/+FX6AUH7OGN7iLD+Vk5o5c7tDlnLWJssctkw+2I+Fp0MTCNEdL7suRjN
         wQtI0bS/DcbERO44gOIAk9uOTMXBxkaisF3zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AEARGOXjDp9TEAbLHYWSCu7Hc9PRf5PdZN2G9g2HBHK6kZS308yYBegmj5+FM+xWVq
         Dwacc5KhCeF3ja7DY58e/tIP3kJPypgqlYsadGpX2vZvKJ7oZIUHcLmv1AmasAyZmePZ
         eVa0tkzpZPSi6T4zdAm2n+VlHXD1tj3cxITHo=
Received: by 10.91.142.16 with SMTP id u16mr5612439agn.11.1266492507721; Thu, 
	18 Feb 2010 03:28:27 -0800 (PST)
In-Reply-To: <4B7D21A0.4000706@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140318>

>
> Also, an "or" may make things clearer, and "untrack" is wrong: to
> untrack is to stop tracking, but this is about untracked files. So, h=
ow
> about:
>
> ---
> =A0wt-status.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 5807fc3..f17300f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -100,6 +100,7 @@ static void
> wt_status_print_untracked_header(struct wt_status *s)
> =A0 =A0 =A0 =A0if (!advice_status_hints)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0color_fprintf_ln(s->fp, c, "# =A0 (use \"git add <file=
>...\" to include
> in what will be committed)");
> + =A0 =A0 =A0 color_fprintf_ln(s->fp, c, "# =A0 (or add its path to .=
gitignore to
> ignore it permanently)");
> =A0 =A0 =A0 =A0color_fprintf_ln(s->fp, c, "#");
> =A0}
>
> --
>

I Think that is good :)

-pavan
