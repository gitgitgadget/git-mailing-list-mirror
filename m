From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3 0/4] submodule config lookup API
Date: Thu, 21 May 2015 20:50:11 +0200
Message-ID: <555E28E3.5020003@web.de>
References: <20150521170616.GA22979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:51:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVYi-0003q7-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbbEUSvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 14:51:04 -0400
Received: from mout.web.de ([212.227.17.12]:49572 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbbEUSvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:51:01 -0400
Received: from [192.168.178.27] ([79.253.158.202]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M4I2R-1ZD2XK3OlP-00rsbs; Thu, 21 May 2015 20:50:41
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150521170616.GA22979@book.hvoigt.net>
X-Provags-ID: V03:K0:K2TmWyevVE4bTKiWCeo0ZKe1CBotoK+0oSRU92HB3pRoMvcXGsx
 N2+pNtIuQ9IXcftOstCdv8rEDsAZQ3JPYoUmgEpRlxZE31fdlu9JxMdvqxs2SmWyA/yKV2n
 9fDHG9YC0Zg3S0jJfyCqkbzDh7UoGMK7EQI1IHz6xg6YBgA6aWsCzkFhQ6+lDL2wezxx1sg
 fx/P3ldBwAr6NDSSJvSRw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269645>

Am 21.05.2015 um 19:06 schrieb Heiko Voigt:
> diff --git a/submodule-config.h b/submodule-config.h
> index 9061e4e..58afc83 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const u=
nsigned char *commit_sha1,
>   		const char *name);
>   const struct submodule *submodule_from_path(const unsigned char *co=
mmit_sha1,
>   		const char *path);
> -void submodule_free(void);
> +void submodule_free();

Why this change?  With void it matches the function's definition.

Ren=E9
