From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/25] list-files redesign
Date: Mon, 6 Apr 2015 20:58:16 +0700
Message-ID: <CACsJy8B1M1wwGFgcguaq1_p0qMPCiooKq-mhYT+mPfENdE9ttg@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7YB-0000JU-TY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbbDFN6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:58:48 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36062 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbbDFN6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 09:58:47 -0400
Received: by igblo3 with SMTP id lo3so21420884igb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PX/3lz2g9WVY+ZImH2pFhUsrGQ2j1RlieFGkfSV83Ps=;
        b=P7LDY6vWBCYp8jVTCTdBtviUUfqE+RAcv5Nh49vNKZo4O9IUaNQ/UHwmfiDgJI5Sfb
         NFHWumUq24clpvbfk9TCntSJIE+yMUn4LslKNR+BoC3at70jzofwrwEYVP2zkh0F+QLn
         i2paaWvIcGG/2sMvu2jswygjed64FPIUmCjD5hS9C485wYWEbiiXtFaX8JsYoWe7fqp/
         tI6nmjvc6z3yaiFz+p9yx7gHG5yQsYCpFHPYcTk5+6jE2yHUA8ju9FssTvlNpMhmCzND
         AyFsI8WXWmmNo11z8YhZRX1wXtINGfX/6W+8+TLcuOBnWHh8sOb209+I6LeUgw5rLISZ
         a/aA==
X-Received: by 10.107.36.6 with SMTP id k6mr22327060iok.83.1428328726643; Mon,
 06 Apr 2015 06:58:46 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Mon, 6 Apr 2015 06:58:16 -0700 (PDT)
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266871>

On Mon, Apr 6, 2015 at 8:52 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> The UI part is the same (or nearly the same) with the last round. The
> internal data structure is reorignized to avoid abusing string_list.
> Tests and documentation are added back.

It's supposed to be a reply to the last round [1] but I missed
--in-reply-to and screwed it up. Sorry.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/265142
--=20
Duy
