From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/2] config.mak.uname: Darwin: define NO_GETTEXT for
 OS X 10.9 and later
Date: Mon, 23 Nov 2015 12:57:12 +0100
Message-ID: <5652FF18.20602@web.de>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com> <1448267108-55652-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 12:57:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0pkn-0006YU-DU
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 12:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbbKWL5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 06:57:50 -0500
Received: from mout.web.de ([212.227.17.12]:51657 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbKWL5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 06:57:49 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MPHC8-1ZwPtg0KFU-004RCO; Mon, 23 Nov 2015 12:57:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1448267108-55652-2-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:Wa1MtGMiVU3Nw94ONKF4lCMMNm0Z0hMNpUd5R6xKVZe/McoWmO2
 NMBEogATfw5Jr+wLXP8tf6O3zuxkBV+SBZOV1AqBDUJ8HJd7jWhTSbxetaZBcTOouxaIlM4
 VPIEjo7c7YJ9cXIaUnskMC5qaQ3xOXoIqu/BeC9/fqV38ipfE9MpKwRQ0e6UBgxmMoP1EC2
 3xuqc47cCbrZmz/lckp8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i7UBbFDWTcY=:w6oQC9juia2sIysYE1QmvL
 AysPhJZOpy6BcynYgr4EsSnXEO3jaaClucqvapCaW9zS56JEM8TMkEMjn0A+CyePfe72vN/zA
 IS93EWLQJLHa787T/zOKJhhPhccp4iGoEir4RtzMANSFdT4ITSKFXOO6B1/k5V+GXr715YN5w
 Tud+pwSa871uzQo/EK1ukFiLQDcPcWNRmYnkYdPz6yLB49VvuABm0YElW6z0qWAxTf86eamfU
 GQRiZAwuOY8uIq6+JETgfU/f5V1LvWAvLwdfAZ3w6pJ32fYaV+QG0x+7flXgc8PUP4h4JC/KW
 lkohcGh9O2WrGrdjAbwESYfPqFcKYziQMU8XUJYt7AMYwYlwqLj5/EBVwbvIbvnSK15NtkNVr
 98zYSfXWQgBdKmvafvCIlSyq2xUkdpXYTOPpjv3c1wHLMlhNNZbSxvqg8wzx+RBgF4TovpslH
 u6UYLXtTFkaiMhqbwMhmBgV8KL+CjwElNnLKP8rQU5GeUZcaezpzOY5piwwBeMn/8vK5bH3yj
 /ytlmMAqPjOxKo/KGPGBBt3miXigvM7V7voPjgb5U12Td/bFJF/GWFdhQAvmX3IEmXs6iai+1
 1cA1HlpsTQUUPGVhvBqFUl+k6pPwo5/W3jCQ8BowLJ9a4WP2HMCAwnC20aq2g7K93PZ4EyoTz
 Ace8xn3lYKGEnXeWY0ZBJwiYBiyyhN8qtLamfGENVA3ExCRdz0l7XbDlXFsSYlm0mf9jLO6XZ
 Mb+TCWRMjcAJi1Vratr5lU+bVH+dsz8VVyjBOXJAx87T9BJ6icqZ/ANQXtL0GaEMJN1q6bQ4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281580>

On 11/23/2015 09:25 AM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> At least since OS X 10.9 Mavericks "libintl.h" is not available on OS X
> anymore. Disable the support with the NO_GETTEXT flag.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   config.mak.uname | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index f34dcaa..f3d98bb 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -102,9 +102,14 @@ ifeq ($(uname_S),Darwin)
>   	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>   		NO_STRLCPY = YesPlease
>   	endif
> +	# MacOS 10.7 Lion and higher
>   	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
>   		HAVE_GETDELIM = YesPlease
>   	endif
> +	# MacOS 10.9 Mavericks and higher
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 13 && echo 1),1)
> +		NO_GETTEXT = YesPlease
> +	endif
>   	NO_MEMMEM = YesPlease
>   	USE_ST_TIMESPEC = YesPlease
>   	HAVE_DEV_TTY = YesPlease
Unless I'm wrong, no Mac OS X had libintl.h, and the "unwritten 
agreement (?)" was
that either
a) libintl ist installed in some way (fink, mac ports, brew, other ways)
or
b) people use
NO_GETTEXT=yes make

Doesn't this patch close the door for b), making it impossible to build 
Git against libintl ?
A better test may if libintl is installed may help, or better documentation.
