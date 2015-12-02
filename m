From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Wed, 02 Dec 2015 08:12:57 +0100
Message-ID: <565E99F9.2020906@web.de>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org> <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?windows-1252?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 08:14:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a41c6-0001t6-7o
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 08:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbbLBHOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 02:14:01 -0500
Received: from mout.web.de ([212.227.17.11]:61565 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172AbbLBHOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 02:14:00 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LyUsk-1aOKCx2dpG-015qxc; Wed, 02 Dec 2015 08:13:41
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:yrTiOEIcYaaItnCjeL33CmKbvwWiQFjfiPA3b+QvpMzmxH4hPUr
 PQYjArifx/KzeIATSapzGpVy73Rpd5NoniNMOLyXX83iacGBxX27WtR0kxdpm9slv6I2aqC
 sOR4+kupf3/vLKNuAInFSgS59O/Us9z54zrRDEZGrXAVFY8u9Z/VvuYWxnyzBR2RkMdkMa7
 JjkSI3cNnpmibhYfXvZEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4kNRdT5dvjo=:0v9GX0b8Km3cB6EJEY9jAh
 O9LPYPpJ90E/snJJWnHzK9Ex/FSc1bSEFTsukVRym1ATMh3qJ8fNhZkgG6uq7ma3TiQmS4uMa
 CgbDJYbwJOPbT5a9CylH4EVZ+sRFBHuXbtAhaWjAEVQ9Yqrv/FVAAxtH2uo982l5YupB8EO7M
 eG9XVmK5x3uQJm4WdElh8/brTWTZGCOTvna9Sc/OJhMXAmqjyHgUFRYr0O0xDTRZkoo0qw0kf
 RdRQkSPqMot1u+O+EjGDDLhUuAs0MDwn6mFsyh6V6MVz0lBqO2ARUsTzmbfQk+k0TT6e3H9KM
 +YAglN5p5bWxONrtWYvw9tlhvosTGS8VUXk6L60aMgh7Dk59Uaz0NHi7/l/i/tJQ6sDdcWkYC
 P53Cq+h7dkZlulKMZms3Pdc5hPn44ktmhKPVbxIzryVRuqWVhqbABy+IbRGltERtll0UKffjQ
 Cp5k47hOPjORzgRHtKnMzxDIdbFtgJiU2mopII1pAtkXq31VGJfecIpBN82QsE/tKH4pu5GEh
 ePwDVlDTFZDJUuocqnmI6xURdLUi4NaXAZr2834BGyRSnUwWO1Uz5/N4gZdxC2xoX+yaa0z2G
 NEGUUjioz9ETTMv26MeLjPU4yymPSt5sup4sWbJVB82T5WzKe4WFijopU2z+AzSR8frm7QMA5
 WJ+2rlZF+8EeOs+u/zrN3OoGwPU0bznILCHAPxqE/d9N9oAVMZP9eqUuJkVVLqnD0WiE/M48g
 JFWjEvgNSnt62XvpWQgJ1MWTKVLMrZDm9MaKKcHb/yJn2J125rxvYb66T0e4U9wErIDwc1t5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281881>

On 12/01/2015 09:31 PM, Christian Couder wrote:
> When we know that mtime is fully supported by the environment, we
> might want the untracked cache to be always used by default without
> any mtime test or kernel version check being performed.
I'm not sure if ever "we know" ?
How can we know without testing ?
I personaly can not say "I know" in all the different system I am using,
so I always want to test and verify that the untracked cache is working,
before I rely on it.


> Also when we know that mtime is not supported by the environment,
> for example because the repo is shared over a network file system,
> then we might want 'git update-index --untracked-cache' to fail
> immediately instead of it testing if it works (because it might
> work on some systems using the repo over the network file system
> but not others).
Same here.
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   Documentation/config.txt               | 10 ++++++++++
>   Documentation/git-update-index.txt     | 11 +++++++++--
>   builtin/update-index.c                 | 28 ++++++++++++++++++----------
>   cache.h                                |  1 +
>   config.c                               | 10 ++++++++++
>   contrib/completion/git-completion.bash |  1 +
>   dir.c                                  |  2 +-
>   environment.c                          |  1 +
>   wt-status.c                            |  9 +++++++++
>   9 files changed, 60 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b4b0194..bf176ff 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -308,6 +308,16 @@ core.trustctime::
>   	crawlers and some backup systems).
>   	See linkgit:git-update-index[1]. True by default.
>   
> +core.untrackedCache::
> +	If unset or set to 'default' or 'check', untracked cache will
> +	not be enabled by default and when
> +	'update-index --untracked-cache' is called, Git will test if
> +	mtime is working properly before enabling it. If set to false,
> +	Git will refuse to enable untracked cache even if
> +	'--force-untracked-cache' is used. If set to true, Git will
> +	blindly enabled untracked cache by default without testing if
> +	it works. See linkgit:git-update-index[1].
> +
Please no.
The command line option should always be able to overwrite any settings
from a config file.


Sorry, I may missing the big picture here.
What exactly should be achieved ?

A config variable that should ask Git to always try to use the untracked 
cache ?
Or a config variable that tells Git to never use the untracked cache ?
Or a combination ?

core.untrackedCache::
  false: Never use the untracked cache ?
  true: Always try to use the untracked cache ?
        Try means: probe, and if the probing fails, record that if fails in the index,
        for this hostname/os/kernel/path (Don't remember all the details)
unset: As today,

   
