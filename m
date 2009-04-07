From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH 2/2] git-checkout.txt: clarify that <branch> applies when 
	no path is given.
Date: Tue, 7 Apr 2009 10:41:40 +0100
Message-ID: <e2b179460904070241y493ef876xc628d35b606e4032@mail.gmail.com>
References: <1239050722-1227-1-git-send-email-Matthieu.Moy@imag.fr>
	 <1239050722-1227-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 11:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr7po-000484-8L
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 11:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZDGJlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 05:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZDGJlo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 05:41:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:8462 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZDGJln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 05:41:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2648792rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yGo+BKwMgmrHLRsv3gkRMfgM2G/Lrqo99mvXjgMGBq0=;
        b=e2PtEkU0p/mTIAY+IJA7EprRsbZbTOk8paq7kParuO5eDGUc7g6n/K9BpWbGDK3fMB
         ozvq/p+T/mP4tPpCiZEsVNb0UzHIM349EvzP5w5MFnK0o4AZU4FzoUHweBd/e+INBNoi
         PRw+yvN++WtWAXkVEIf8O9XOziTg+b71+flx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MntgQrpwHTlWPMt3j1xdxIbPPcBdgW3AtnYjne6tNOpovVOWzUbHFs3/dVDGDIlpAh
         pGSIYQsSmFwkZ29VwdyoHGDv5Hncf+OImgdhAxTxdgaf+RCdeVwFbhwGCwaKO9El3FlO
         dRjumqSvdIglyUrGck1mDeZHCabqIteSvr8LY=
Received: by 10.141.29.14 with SMTP id g14mr1710570rvj.52.1239097300287; Tue, 
	07 Apr 2009 02:41:40 -0700 (PDT)
In-Reply-To: <1239050722-1227-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115940>

2009/4/6 Matthieu Moy <Matthieu.Moy@imag.fr>:
> Otherwise, the sentence "Defaults to HEAD." can be mis-read to mean
> that "git checkout -- hello.c" checks-out from HEAD.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 0b5485b..58bf508 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -126,9 +126,14 @@ the conflicted merge in the specified paths.
> =C2=A0<new_branch>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Name for the new branch.
>
> +<tree-ish>::
> + =C2=A0 =C2=A0 =C2=A0 Tree to checkout from (when path are given). I=
f not specified,
> + =C2=A0 =C2=A0 =C2=A0 the index will be used.
> +
> =C2=A0<branch>::
> - =C2=A0 =C2=A0 =C2=A0 Branch to checkout; may be any object ID that =
resolves to a
> - =C2=A0 =C2=A0 =C2=A0 commit. =C2=A0Defaults to HEAD.
> + =C2=A0 =C2=A0 =C2=A0 Branch to checkout (when no path are given); m=
ay be any object
> + =C2=A0 =C2=A0 =C2=A0 ID that resolves to a commit. =C2=A0Defaults t=
o HEAD.
> +

s/path are/paths are/g

Sorry if I come across as picking on your grammar, I think your
documentation improvements are very worthwhile.

Mike
