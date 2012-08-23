From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] l10n: preserve trailing spaces in Vietnamese translation
Date: Thu, 23 Aug 2012 17:38:33 +0700
Message-ID: <CACsJy8BdhPdwC0Uy4nvny0HWSurvshy7Ve=m-DoRpeznsVUFQg@mail.gmail.com>
References: <1345640253-31705-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Marco Sousa <marcomsousa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 12:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Uot-0003Pc-4U
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 12:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933937Ab2HWKjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 06:39:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63563 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933899Ab2HWKjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 06:39:04 -0400
Received: by ialo24 with SMTP id o24so1084980ial.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=V4yr0FF/JqOojlIojK0JBeXOC0YCixG+DjNH4BY2zLc=;
        b=RsfDLPlxs5sr2L2U0kdywkloyl5pIJIbC2q9Ga0PO2SfQiarygZpNRcQ15Kji9g0c0
         iNZGxqiicn/00F1ffYJ39yP1wse/CKxBzxQu/2In6b/FNRJ48nbbbttnvuO7G1VYAYCK
         uu3j7zM6NFM2aZw4OTOC1PdLiKdW456pxR3lSs/6mUVONmFjP/osOfvTtBLcKgjiIjF+
         oj5oBXqATv4Tf5FAcRKeQr6w61GkNKHgdPCXe5aM4P8/so4yA9Eb5J7acGfD8pkV5hgZ
         6ZaZD3pKFuNUiJMiLN5Ijth42YLA1QmG6n0ApIFOvIS5NTHf/0APVGG6XfwO/fJ5qqFd
         K6YA==
Received: by 10.43.45.200 with SMTP id ul8mr800815icb.36.1345718343963; Thu,
 23 Aug 2012 03:39:03 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Thu, 23 Aug 2012 03:38:33 -0700 (PDT)
In-Reply-To: <1345640253-31705-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204144>

2012/8/22 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> The trailing spaces in msgid can be used to separate the next
> word. Accidentally removing it means we may see "On branchmaster"
> instead of "On branch master".

I don't speak Portugese but I think that translation has the same
problem. This is on git.git by the way, not git-l10n repository.

#: wt-status.c:737
msgid "On branch "
msgstr "Na rama"

>  #: wt-status.c:978
>  msgid "On branch "
> -msgstr "Tr=C3=AAn nh=C3=A1nh"
> +msgstr "Tr=C3=AAn nh=C3=A1nh "
--=20
Duy
