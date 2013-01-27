From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] branch: mark more strings for translation
Date: Sun, 27 Jan 2013 03:55:16 -0800
Message-ID: <20130127115516.GD4228@elie.Belkin>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 12:59:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzQtY-0005qY-2e
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 12:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab3A0LzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 06:55:23 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:33793 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab3A0LzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 06:55:22 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so825451dak.34
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 03:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Siq7FhPs1oDxJb5I4b40hS1+GDLep73p7cnddQsyjIg=;
        b=iylvBSxe5pW/sQ/YVdDGxtndVmCh7dFCTC4zcDt+YIoY9y3qXWM25T8cq/oB0d9pRD
         AbqH/0sXY58jXPRNVFquUVmnY0r41SNdaOTJdAJW/QBHYG2m5L0rODSKExhm6T5YoT12
         bYubMAnMElyQulpfPRB72Tmp0Udsde3LohzERg1/rcg0oWy+lgbrWrQzuIZ05qROKThz
         jX7FTK34DAVtie37qOqUyNBMULHhdggnQLyAoejTAJ2nonPMkf90P3dEY3OTBLtKNwm4
         7gTvggfIJBajp8itprYNXdeonO6Yvw1YCjvUCdkPFBTEcx/QmGWoKOeqaRt3me9FcXt1
         AI9Q==
X-Received: by 10.68.137.167 with SMTP id qj7mr28661677pbb.148.1359287721834;
        Sun, 27 Jan 2013 03:55:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wr4sm4260014pbc.72.2013.01.27.03.55.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 03:55:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359118225-14356-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214693>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -466,7 +466,7 @@ static void add_verbose_info(struct strbuf *out, =
struct ref_item *item,
>  			     int verbose, int abbrev)
>  {
>  	struct strbuf subject =3D STRBUF_INIT, stat =3D STRBUF_INIT;
> -	const char *sub =3D " **** invalid ref ****";
> +	const char *sub =3D _(" **** invalid ref ****");

This worried me for a second --- is it an actual message that gets
emitted, a placeholder used only in code, or some combination of
the two?

Luckily it really is just a message (or rather, a value for the commit
message column in the " f7c0c00 [ahead 58, behind 197] vcs-svn: drop
obj_pool.h" message).

=46or what it's worth, assuming this passes tests,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
