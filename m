From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH] help.c: mark a file-local function static
Date: Tue, 19 May 2015 21:17:55 +0200
Message-ID: <555B8C63.8020606@gmail.com>
References: <555B8BEB.1050103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 19 21:18:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yun1h-00089I-FC
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbbESTSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 15:18:00 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35345 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbESTR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:17:59 -0400
Received: by wgfl8 with SMTP id l8so29045650wgf.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jQ602nXDkeIaJ/pX5cY29LPyNwh7jLl7N/I8spDK030=;
        b=SfRs58PcXRgbHDmY64uTXWNPvyPgUckfyz8zGq8ktJFPI3lxKaQAb6aAHcffoXW1Bc
         oBR4phpR4tlHeCpRvMI+iefzuk1wW44I+VrNLjbozA/smlykDOKlefAZ5IqWKJ9Wdt8q
         hpA0Z3T4oWC8FjpaKjuoTDL3GdmeeMSV0pAsmRt7GENxnxnBSak7ks4AMYuwCiBL7VDn
         o2QNLLhaUSEn3WV8ndc5iak57/6seluoR4B+/LOeYoOD4Ih7CSuqJcVcScNWYbOScLV7
         G98KuwgSyUmz1PZcVktnDzQgjxq4Pg0w5qimInrSXiHCSPrOLem+FChduf4ZV8mk8Si1
         oJUQ==
X-Received: by 10.180.88.8 with SMTP id bc8mr15477243wib.19.1432063077734;
        Tue, 19 May 2015 12:17:57 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id g8sm23118913wjn.18.2015.05.19.12.17.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 12:17:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <555B8BEB.1050103@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269389>

Hi Ramsay,

thanks for pointing that out, will squash it.

S=C3=A9bastien

On 05/19/2015 09:15 PM, Ramsay Jones wrote:
>
> Commit 4f671d74 ("help: respect new common command grouping",
> 18-05-2015) adds the 'cmd_group_cmp' funtion as an external
> symbol.
>
> Noticed by sparse. ("'cmd_group_cmp' was not declared. Should it
> be static?")
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Sebastien,
>
> If you need to re-roll the patches in your 'sg/help-group' branch,
> could you please squash this into the relevant patch (commit 4f671d74=
).
>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>   help.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index 71027b7..7881ab7 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,7 +218,7 @@ void list_commands(unsigned int colopts,
>   	}
>   }
>
> -int cmd_group_cmp(const void *elem1, const void *elem2)
> +static int cmd_group_cmp(const void *elem1, const void *elem2)
>   {
>   	const struct cmdname_help *e1 =3D elem1;
>   	const struct cmdname_help *e2 =3D elem2;
>
