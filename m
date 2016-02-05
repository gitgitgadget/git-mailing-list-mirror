From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri, 5 Feb 2016 12:57:53 +0100
Message-ID: <CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
	<1454662677-15137-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 12:57:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRf1S-0006F4-Rk
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcBEL5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 06:57:55 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33260 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbcBEL5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 06:57:54 -0500
Received: by mail-vk0-f66.google.com with SMTP id c3so393945vkb.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 03:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xt3gUPNnv64fgWHtd+Eo9zdQ4KQaRsdaXWQmPQxuYV0=;
        b=htYZ7LmR+UMyXXm84AEenLs1d22WwpbK3tKcvnkudLSY8P+bJ3/dFkBljZDjRm1wab
         NHcqMBwFujEW9rLkP1HJlWGt9ag/9a0jSsYVEP70qBM4SdsHI5SDimCN6IGnJ0sUslop
         bKhXCQuURW4+GODmXbyuSWkdiEWCW0FgfZSGfvgxxQ1JBXLlnNaUfGfVvl1Jd28r1t1a
         rx9dASdliNenH2UBxakDkRi9LkU9/O3BLHVlurRGDXrSaUUfnqrc5S+2B39eMao0Xnz7
         wgwfrL9OdLfWO1WSC5c/zNAkk6NjHkO1tujtM8fFLzVPbhGrl3hQjJrzm9m3H04QXcFa
         LafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xt3gUPNnv64fgWHtd+Eo9zdQ4KQaRsdaXWQmPQxuYV0=;
        b=hAIOcuciVZfA62+XU3VXLlhkQNoSx8kZiLSbuwv3SloUVSLXeOTa0MPe/Vha5Y5pPX
         huZMx+bOTWnHq/8YEiPZyOAFY1UOMayRBvXV8nqnBkeEs+WXYL5wvsiNbez9+trEvS2X
         1de4qMJNVguvL0In2KIHxshkUmQRZgTp1PJ6wLSEN9EIH+GLvp1eVcxDqgp6a9i3kaiJ
         UbLp1r+moYeOC0cGq3AGhxzA1QBxVuxEeLyRkWmnDXhlySVTsV8LGqDf7p08BShkljqW
         mlPi5OCJTuc3+WNlkw5t3+mfiLbSIaTo9wRrQEz4xnIUauoWRMy6su7BTTWY5fbznqWw
         L2RA==
X-Gm-Message-State: AG10YOQDAFGo9M15wd0GeDiBT98MLoVJGt74a8UseKNQGu7II13EldUcw4XDhLgnUn8aIVrvJHFRQk+MjAv/Sg==
X-Received: by 10.31.141.2 with SMTP id p2mr9265640vkd.37.1454673473364; Fri,
 05 Feb 2016 03:57:53 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Fri, 5 Feb 2016 03:57:53 -0800 (PST)
In-Reply-To: <1454662677-15137-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285573>

2016-02-05 9:57 GMT+01:00 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com>:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t5544-fetch-resume.sh (new +x) | 42 ++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100755 t/t5544-fetch-resume.sh
>
> diff --git a/t/t5544-fetch-resume.sh b/t/t5544-fetch-resume.sh
> new file mode 100755
> index 0000000..dfa033d
> --- /dev/null
> +++ b/t/t5544-fetch-resume.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description=3D'what'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'what' '
> +       test_commit one &&
> +       git clone --no-local .git abc &&
> +       (
> +       cd abc &&
> +       mv `ls .git/objects/pack/*.pack` pack &&

No, please. From the git coding guideline : "We prefer $( ... ) for
command substitution; unlike ``, it properly nests.
It should have been the way Bourne spelled it from day one, but
unfortunately isn't."

http://stackoverflow.com/questions/4708549/whats-the-difference-between=
-command-and-command-in-shell-programming

Thank you
> +       git unpack-objects < pack &&
> +       rm pack &&
> +       git fsck
> +       ) &&
> +       test_commit two &&
> +       test_commit three &&
> +       (
> +       cd abc &&
> +       git fetch --resume-pack=3Dfoo origin HEAD &&
> +       git log --format=3D%s origin/master >actual &&
> +       echo one >expected &&
> +       test_cmp expected actual &&
> +       rm .git/FETCH_HEAD &&
> +       mv `ls .git/objects/pack/*.pack` pack &&
> +       head -c 123 pack >tmp &&
> +       git fetch --resume-pack=3Dtmp origin &&
> +       test_path_is_missing tmp &&
> +       cmp pack .git/objects/pack/*.pack &&
> +       git fsck &&
> +       git log --format=3D%s origin/master >actual &&
> +       cat >expected <<EOF &&
> +three
> +two
> +one
> +EOF
> +       test_cmp expected actual
> +       )
> +'
> +
> +test_done
> --
> 2.7.0.377.g4cd97dd
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
