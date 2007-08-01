From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: [PATCH] Mention libiconv as a requirement for git-am
Date: Wed, 1 Aug 2007 00:03:15 -0300
Message-ID: <f329bf540707312003i60e910e9kf97d2f50fdecbed2@mail.gmail.com>
References: <20070731150948.GA9947@localhost>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <J.Sixt@eudaptics.com>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 05:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG4Uh-0002J1-BY
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 05:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXHADDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 23:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXHADDS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 23:03:18 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:43299 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXHADDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 23:03:16 -0400
Received: by py-out-1112.google.com with SMTP id d32so130940pye
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 20:03:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HOhO6HaPmDy7E5mte5pNgeVDb5oJ8gxeX7q96MS/L4GlrYEwzUx6doCfVGOIOkNuhaOwcmUKoYO//njF1HPszHAF1NkplmSyyxOGdsB5LGVgQcKXGXMhpfJ2sIj3UnmpvAYWNFk6cXuU3VxnDE/iOLFmV6lwegwGnlvb8YTJMvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZ9nQQn8XlkwvZbOSfduYbNP1nHKxRYSKJRFajyoMbxN8oPVAPkWRGQoNm7668y1AUOWWz6GnGE2Kb4GtPZKKaLFgKfs4bawMWY/U+gZB3Qj7ArgAiPEitOL/qqsNnBD6J9ZpanrhaMUTpzo+2MQcjOcGNGyTlanMpDMNIm2H+A=
Received: by 10.64.243.10 with SMTP id q10mr345040qbh.1185937395478;
        Tue, 31 Jul 2007 20:03:15 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Tue, 31 Jul 2007 20:03:15 -0700 (PDT)
In-Reply-To: <20070731150948.GA9947@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54400>

libiconv is already in there, version 1.11,

[lilydev@haring gub]$ grep bin.libiconv
target/mingw/gubfiles/installer-git-master-repo.or.cz-git-mingw.git/files.txt
\usr\bin\libiconv-2.dll

I don't understand your request: do you want to have some flags added
to the environment?

2007/7/31, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> ---
>  Han-Wen, any chance to include libiconv to the installer? You may need
>  to set NEEDS_ICONV, ICONVDIR and NO_ICONV properly to make git-am work.
>
>  README.MinGW |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/README.MinGW b/README.MinGW
> index 89b7065..c0b8f66 100644
> --- a/README.MinGW
> +++ b/README.MinGW
> @@ -28,6 +28,7 @@ In order to compile this code you need:
>         zlib-1.2.3-mingwPORT-1.tar
>         w32api-3.6.tar.gz
>         tcltk-8.4.1-1.exe (for gitk, git-gui)
> +       libiconv-1.9.2-1-{lib,bin}.zip (for git-am, from http://gnuwin32.sourceforge.net/packages/libiconv.htm)
>
>
>  STATUS
> --
> 1.5.0.7
>


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
