From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] quote.c: make sq_quote_print a slight wrapper of sq_quote_buf
Date: Sun, 19 May 2013 06:39:17 -0500
Message-ID: <CAMP44s0e6AFZ-7U=NxqWkgntMvVXg5CzFS-ZXztE5u=iAW22uA@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
	<1368959235-27777-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1xT-0004Xj-D1
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab3ESLjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:39:19 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:40279 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLjT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:39:19 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so5727865lbc.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=z4uldc/LXrEASSr+GMPGQT5HDaNlOHA0tSVc+r2Rd9M=;
        b=uOviQ2SottaGPqTvEwMfizoMZvPJIyNKUrFS5nzfvnNkNTn3vaJClmfFoWnwcY3u4u
         VnLTRZMYZSsBiQPU1CIvZZ2VuQ4HeIpFr0tAp56DikrOshwjJfDC/WNlYhmoEVeUvn4N
         NConTZKzs28cYSFE4HkJehfn/hRP1OyTqbf2Cri8jaSsrTfu+4LE5UD1T90GphzeVZet
         XRNd5O+4nlLLIYXcsyHpGYgqnUwv+dmNUVEVwBrQEwA+QyvUTl9OQ7r9NObtmBFgBzBY
         NssJ5fZFNlWR3T+R51dlHINyOTRX3KnQZ1dERt4Ptn2DOMaCPbBI6sK5ESg4E72JSBS4
         kIJw==
X-Received: by 10.112.172.40 with SMTP id az8mr14856122lbc.88.1368963557630;
 Sun, 19 May 2013 04:39:17 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:39:17 -0700 (PDT)
In-Reply-To: <1368959235-27777-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224857>

On Sun, May 19, 2013 at 5:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  quote.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

No functional changes I suppose.

--=20
=46elipe Contreras
