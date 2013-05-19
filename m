From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/9] for-each-ref: convert to use *_quote_buf instead of _quote_print
Date: Sun, 19 May 2013 06:39:38 -0500
Message-ID: <CAMP44s0O7CN0rCt8vLq9h6xVJF25D0gOPqyg4yO9qyC2=6+x-g@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
	<1368959235-27777-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:39:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1xo-0004rN-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab3ESLjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:39:40 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33433 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:39:40 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so5744393lbi.32
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=vlDgsTvohYVb0oQhO8Yl/UUZWjtrAAwmFAVi4CIpuWk=;
        b=SgEk08eBlYXNiqRIcuemKtH0GEuhTr0MJ4i8eH78/8eCtavsVX2Hz990FBO2cYwKvZ
         JTgSrC1ri6ybuyf6dVLFyPnwwsXbOErVZLf6FHW8OlfkeTSe/TAxZmZJUunFC6Sidjg0
         TFiqwSOD02Abko+LpZhJRvyc9Wsfs9t9Hs88Zx39wgsarv3bGTLCLwJyuRDk/MpSYDAU
         /jfYAAzmKOcaN8xV45IKuRg+pPe4JwysnzBl/gCNuWhzkklgiMeu8Jt6+Z1B4MrWMs+i
         5yEv9KD8GB2OkOI3o1ZWm0oGzKDIIhibXpZ/HgO3D4oNbk52tBJECw1bD4i9GNZZTBep
         PIsw==
X-Received: by 10.112.135.70 with SMTP id pq6mr26018186lbb.82.1368963578480;
 Sun, 19 May 2013 04:39:38 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:39:38 -0700 (PDT)
In-Reply-To: <1368959235-27777-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224858>

On Sun, May 19, 2013 at 5:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/for-each-ref.c | 14 ++++++++++----
>  quote.c                | 44 ++++++++++++++++++++++------------------=
----
>  quote.h                |  6 +++---
>  3 files changed, 35 insertions(+), 29 deletions(-)

No functional changes I suppose.

--=20
=46elipe Contreras
