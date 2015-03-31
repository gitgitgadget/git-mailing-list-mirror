From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.conf.txt: fix typo
Date: Tue, 31 Mar 2015 15:06:49 +0200
Message-ID: <551A9BE9.3070907@gmail.com>
References: <1396558187-5674-1-git-send-email-git-patch@agt-the-walker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: =?UTF-8?B?SsOpcsO0bWUgWmFnbw==?= <git-patch@agt-the-walker.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 15:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycvsi-0003Dy-8r
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 15:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbCaNG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 09:06:56 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36231 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbCaNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 09:06:54 -0400
Received: by wgra20 with SMTP id a20so18446874wgr.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5gGf3tNxUzlQRc7LkRXTXfrfTN7vCVzWXQmW+aGBbas=;
        b=jIcGokRDK/jOFwf4dwE7/hdLvBSDeOX8IBtYluUuSrofQf503nOB1RjB9eFCyMDt9W
         BUV85mZJFeZhNyyrg9hRI1+L1CrLxuAuYaJXDFiOF3LVwKqGechIUF2gYw+2pG3JbINS
         jzZXAzIHbdjO21c1rapbJKRRLQS2X31zt9w36iJecMgNncAABI6BgKEhLQTozSTY1qgV
         GVM2A2IDUIk36h79d6QRhXm3qHd+BSHoOPXrEMVZiCDBqBRgY4FZpHfGkK+Pz3/fDxcR
         pg2VMMRz09APQYqPUQfhHgmi5lhuSHD8IDhSorlicVtxAi+8mYdrvF6HmMFERsiyVgAP
         XfgQ==
X-Received: by 10.195.13.168 with SMTP id ez8mr72730649wjd.30.1427807213757;
        Tue, 31 Mar 2015 06:06:53 -0700 (PDT)
Received: from [192.168.130.220] ([158.75.2.130])
        by mx.google.com with ESMTPSA id lg18sm20867300wic.23.2015.03.31.06.06.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 06:06:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1396558187-5674-1-git-send-email-git-patch@agt-the-walker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266523>

On 2014-04-03 at 22:49, git-patch@agt-the-walker.net wrote:
> From: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>
>
> "build-time" is used everywhere else.
>
> Signed-off-by: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>

You are right, it is variable set during build process,
not after project is built.

ACK (for what it is worth).

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>   Documentation/gitweb.conf.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.con=
f.txt
> index 952f503..8b25a2f 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -482,7 +482,7 @@ project config.  Per-repository configuration tak=
es precedence over value
>   composed from `@git_base_url_list` elements and project name.
>   +
>   You can setup one single value (single entry/item in this list) at =
build
> -time by setting the `GITWEB_BASE_URL` built-time configuration varia=
ble.
> +time by setting the `GITWEB_BASE_URL` build-time configuration varia=
ble.
>   By default it is set to (), i.e. an empty list.  This means that gi=
tweb
>   would not try to create project URL (to fetch) from project name.
>
>
