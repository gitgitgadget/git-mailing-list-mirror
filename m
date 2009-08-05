From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] Add push by "export"
Date: Wed, 5 Aug 2009 11:08:23 +0200
Message-ID: <36ca99e90908050208m52a9705focc86ca579780a55b@mail.gmail.com>
References: <alpine.LNX.2.00.0908050056510.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcUQ-00058S-Bw
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933850AbZHEJIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 05:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933794AbZHEJIZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:08:25 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:39902 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639AbZHEJIY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 05:08:24 -0400
Received: by fxm28 with SMTP id 28so3643784fxm.17
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pWmWZTy7m6MRBiN+xSZDfBA0Gxkbj3lFoFceTwjusds=;
        b=ZWc73nOZCUQ/PShId0SZtCv8i0ezKxdpt47PRY+Tk5X/fbm2btRr2CEgAPJWOs0BWz
         RjT+zuvynYIqETWF0ZtjiNR1YyHJxdZzU7eGjSSwv0pfv8j4BrGPy468Mhdq+k0D2ykL
         0veXdbN2mvC6b2h4BBiJTR18HlZ1K5Kes/PcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w8LJvPXL86rg1JQCMMW2aze52LYzKWcsE+goBEtt5riIblCjDDCv4uvSZdsljVbfWp
         XFLGQBm2oy67glBItD9tmKnqABsmkBgv49arr0Id83suG0GTdrjjfbvvGMmShCQIb/4Z
         ckNGaDpf/HoGQLw6tPBzVOiwwoUcLy/kyxh7U=
Received: by 10.223.111.129 with SMTP id s1mr1482241fap.12.1249463303816; Wed, 
	05 Aug 2009 02:08:23 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908050056510.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124876>

On Wed, Aug 5, 2009 at 07:02, Daniel Barkalow<barkalow@iabervon.org> wr=
ote:
> ---
> =C2=A0Documentation/git-remote-helpers.txt | =C2=A0 33 ++++++++++++++=
++++
> =C2=A0transport-helper.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 62 ++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 95 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git=
-remote-helpers.txt
> index 9a3c5bc..dede2e5 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -75,6 +86,10 @@ CAPABILITIES
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and --export-marks option to git-fast-impo=
rt for more details)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0located at the given filename.
>
> +'export' [flags]::
> + =C2=A0 =C2=A0 =C2=A0 This helper supports the 'export' command. The=
 flags specify
> + =C2=A0 =C2=A0 =C2=A0 features of the history that may be exported (=
see below).
> +
I can't find any code or usage of these flags in the patch!

Bert
