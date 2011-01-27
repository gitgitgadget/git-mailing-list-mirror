From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Thu, 27 Jan 2011 23:35:14 +0000
Message-ID: <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com> <1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 00:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PibNW-00087b-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 00:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1A0Xfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jan 2011 18:35:46 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46158 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab1A0Xfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jan 2011 18:35:45 -0500
Received: by qyk12 with SMTP id 12so2943213qyk.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=QF/2TXVieC0XiEWxvjxrMRmyJ8RMY68lWrpNM69Y8Dg=;
        b=FtEdedpt4E0me3de+pXEtgCSE/LyLR+0E2zRVM55NaDCGSNIxajf3djcgBb3nIQ78l
         iiiZ+sxrKMCy1NK9zUQMA1jCrgeWnvOTEOvp0akOuMADO5zWFS76bashnWQhNj+SzFWT
         wjkqn7TPxX1wtNI28sLvr9X4PibM/UqW3Rn/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A9sOYfvOKGM7+XSjmeZ2W8h5Lteh2RKzCCzzx71ooP72utGcUbKM9aJn89Ug/W3rYv
         /i3FMN6WvrjT0kt2fV3QjPu3GyfhqXllfqW0IA0qBdUs+DFMGOyHivYCeCMbqf7IFPCG
         eldeqyM7r41q51KWuJXTwZQrSBc0vlV4l7Gg4=
Received: by 10.229.229.83 with SMTP id jh19mr274655qcb.234.1296171344814;
 Thu, 27 Jan 2011 15:35:44 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Thu, 27 Jan 2011 15:35:14 -0800 (PST)
In-Reply-To: <1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165597>

Hi everyone,

Could anyone comment the 3 patches I sent (being this the last one)?

Thanks in advance,
Vitor

On Thu, Nov 25, 2010 at 1:26 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> ---
> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 0ea3a44..a466847 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -618,7 +618,7 @@ class P4Submit(Command):
> =A0 =A0 =A0 =A0 if len(detectRenames) > 0:
> =A0 =A0 =A0 =A0 =A0 =A0 diffOpts =3D "-M%s" % detectRenames
> =A0 =A0 =A0 =A0 else:
> - =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRenames]
> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename]
>
> =A0 =A0 =A0 =A0 detectCopies =3D gitConfig("git-p4.detectCopies")
> =A0 =A0 =A0 =A0 if len(detectCopies) > 0:
> --
> 1.7.2.3
>
>



--=20
Vitor Antunes
