From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Save terminal width before setting up pager and
 export term_columns()
Date: Tue, 14 Feb 2012 18:44:46 +0700
Message-ID: <CACsJy8Da=JMF7B9hW+WXzRXQFiGJxh0S7HYFg9+uweZ=pMOmTQ@mail.gmail.com>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org> <1329055953-29632-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 14 12:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxGpL-0007es-1n
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 12:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371Ab2BNLpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 06:45:20 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33567 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760520Ab2BNLpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 06:45:17 -0500
Received: by werb13 with SMTP id b13so4096703wer.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 03:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U8UHORfoSCKQo0dnV62up4x1qtQd3hWmwmW+hoFHAfo=;
        b=Op2rKy2derLyFEmtzhKxlEaSL00fc7Zv5DTrNt/jDHsDeZHQsib0+YoMA/KPAQ0Xbk
         zKalhBxkGNQaXlSA/C3oloNLSYClQFtPoAdJOIvo0eO32hwaB8oS/r45GBx97YkUXQYC
         E3KsICvnoyC77W2ZpIHztwjLcG7D7LsckteTE=
Received: by 10.180.107.2 with SMTP id gy2mr14108695wib.12.1329219916290; Tue,
 14 Feb 2012 03:45:16 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 14 Feb 2012 03:44:46 -0800 (PST)
In-Reply-To: <1329055953-29632-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190715>

2012/2/12 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
> This replaces cb0850f (Save terminal width before setting up pager -
> 2012-02-04) from Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and my pre=
vious patch to export
> term_columns().
>
> This is directly on top of v1.7.9 as requested.
>
> I removed Signed-off-by from Nguy=E1=BB=85n and Junio because the pat=
ch is
> substantially changed.

No problems. I will rebase my series on top of this patch (its final
version, that is).
--=20
Duy
