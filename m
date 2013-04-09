From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 1/6] send-email: make annotate configurable
Date: Tue, 09 Apr 2013 15:51:36 +0200
Message-ID: <51641CE8.4000704@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com> <1365356784-24872-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 15:53:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPYz9-0000i9-3M
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 15:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765002Ab3DINwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 09:52:16 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:61337 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761650Ab3DINvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 09:51:41 -0400
Received: by mail-ea0-f172.google.com with SMTP id z7so2815838eaf.17
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=X3ResX0qlf8XoCmvJK1hvinYWM0a0mljwhxXONBfwIE=;
        b=YHHt3G6rAAi36i0+NPZdxDiHPkq8c56HoSh8NqPii+G7ldLpETXr7thJ680i9NCVYN
         jBlt7jZ68TUoafXFjjwqb7WVOuatIZqz3xnJLOytX/Yhg7eC/nB5DbiUYEikfi5/F0ba
         L3/sgpZgDlU4JDxTLXvksZgBXjpSk4uDUVqyWfZTMHLq7sHNmgN4rP7BGgYIkj8VGtUS
         rgHnwLGp7Bg4OYGoFflBN3vZfb7tj8v5hIgCoirwlRYYaY2HZeoCMEvS/U9owgSPGTb5
         PoCqM8VGo0JuJG15oCVIy8r792CEY7qGCCjGGFiLxfg70lZZst1ElHMTizPZnDOxZ4iJ
         mMKg==
X-Received: by 10.14.215.193 with SMTP id e41mr60258272eep.32.1365515499794;
        Tue, 09 Apr 2013 06:51:39 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id i53sm8844118eeu.5.2013.04.09.06.51.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 06:51:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <1365356784-24872-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220570>

W dniu 07.04.2013 19:46, Felipe Contreras pisze:
> @@ -212,7 +212,8 @@ my %config_bool_settings =3D (
>      "signedoffbycc" =3D> [\$signed_off_by_cc, undef],
>      "signedoffcc" =3D> [\$signed_off_by_cc, undef],      # Deprecate=
d
>      "validate" =3D> [\$validate, 1],
> -    "multiedit" =3D> [\$multiedit, undef]
> +    "multiedit" =3D> [\$multiedit, undef],
> +    "annotate" =3D> [\$annotate, undef]
>  );

Why not leave hanging "," to make it easier on future changes,
i.e.:

  -    "multiedit" =3D> [\$multiedit, undef]
  +    "multiedit" =3D> [\$multiedit, undef],
  +    "annotate" =3D> [\$annotate, undef],

--=20
Jakub Nar=C4=99bski
