Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAA81F516
	for <e@80x24.org>; Sun, 24 Jun 2018 13:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFXNrt (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 09:47:49 -0400
Received: from mout.web.de ([217.72.192.78]:54569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeFXNrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 09:47:47 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0ymZ-1gJhgF2mwJ-00v9pD; Sun, 24
 Jun 2018 15:47:44 +0200
Date:   Sun, 24 Jun 2018 15:47:43 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] Documentation: declare "core.ignorecase" as internal
 variable
Message-ID: <20180624134743.GA31295@tor.lan>
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
 <aa841316-5fc0-b69b-a3d0-15911b0776f4@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa841316-5fc0-b69b-a3d0-15911b0776f4@syntevo.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:2nP83JFDj7HT+jE3tR8B/dgJtQ4n0sL5ng8tC5e3v5UvH1FLncE
 okO78fXLqo3rKq++dEIHceNZxzIR57xxOfzuXaO+sfzlq+8UoQ9fai32pB66j8RSWmjUPzI
 i4tqoxd9sjwG87j6uMv/m8d7xqb6qtP5NVaZYUD21gHm25y6U0h9jHy65z7g/WXbj/+4nIU
 Da/qTMfx7Xw0+RMb4NQBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Pr8dbhrBmw=:rBQ4dHklYPkv+JI8//KOUl
 ao+DZhCTzDjnWWN65bwPk+L4Y650aGPOadICvQ7Bnk+Ri/2NI35iGJGU93odCUxB6JQRvalsf
 4PSCO/u0ST8bDZTIbdTjhpV0IW3oItlfs/y5Ye+bLZLARfMdAdIzOBJp9UkunS80zqibAAHEz
 WKI3tRH5W7hvq7VJSuCBcsw2aaDgEMxD/JIDgl4PEk3HFDIjhtEml7B7WruUJy+/arv2o0y17
 RIm9nt6agplSvImqb0qirV6g4GviMsWNqYvO9ti3hg5zY4AbQPKHaD9RR+bPZVdkRbn9YpXsn
 VNqaUleNpyQZ+u5NOueubUVaVsAV/xyWh099t6kWQyLv3Pp7/OmT3S3AdqN2YvyQ21XrwJst9
 u2GdPw2c6msXyCvnfG65wXPqXfRtqHqKcxVe+WHjQJI5GHzOKTs6YH/Th1i19KjiX2rM9zoBA
 Ot70wXbWcpUd9K8e2Z7UTjFGZ/bay1Cne2LWoTfNpmHKVrMy0i/F/wqb5nyi6xprTk6PL6Zym
 +PebRXrqVLr/0pjP1R278fZTHbJBi8XVLeaL1h7HbP5gQEjSHSGh/7loXzHHXUMlWcjb56RWh
 IjuC8Xp9fuueQ9UckVk2QeRw+SKchflYors9BTqHFZLTvTAkMxhWIK1j5P1snygJUwETOzE+J
 +YJOsrUc2vf1Xt6QzX0B2QJCeTUiLwtECzXTiSst6GFemM+/5Kr88U0YeyAnRYoiOY9py12iG
 xuUTlMHAU4ALk0fxvwg2ydS5A2T5kz9vyw5swRNBAeP1jxXvwEd0BbFMmIQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 24, 2018 at 12:44:26PM +0200, Marc Strapetz wrote:
> The current description of "core.ignoreCase" reads like an option which
> is intended to be changed by the user while it's actually expected to
> be set by Git on initialization only. This is especially important for
> Git for Windows, as noted by Bryan Turner [1]:
> 
>     Git on Windows is not designed to run with anything other than
>     core.ignoreCase=true, and attempting to do so will cause
>     unexpected behavior. In other words, it's not a behavior toggle so
>     user's can request the functionality to work one way or the other;
>     it's an implementation detail that `git init` and `git clone` set
>     when a repository is created purely so they don't have to probe
>     the file system each time you run a `git` command.

This is a nice explanation, thanaks for that,
Some users of Mac OS or SAMBA will see core.ignoreCase=true, and are not
supposed to change it.

The same explanation (Git for Windows)
is alse valid for HFS+ and APFS under Mac OS and VFAT under all OS.
(or even an ext4 file system under Linux exported to Mac OS using SAMBA)

May be something like this?

     Git on a case insensitve file system (Windows, Mac OS, VFAT, SAMBA)
     is not designed to run with anything other than
     core.ignoreCase=true, and attempting to do so will cause
     unexpected behavior. In other words, it's not a behavior toggle so
    .....



> 
> [1] https://marc.info/?l=git&m=152972992729761&w=2
> 
> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
> ---
>  Documentation/config.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a..c25693828 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -390,7 +390,7 @@ core.hideDotFiles::
>  	default mode is 'dotGitOnly'.
> 
>  core.ignoreCase::
> -	If true, this option enables various workarounds to enable
> +	Internal variable which enables various workarounds to enable
>  	Git to work better on filesystems that are not case sensitive,
>  	like FAT. For example, if a directory listing finds
>  	"makefile" when Git expects "Makefile", Git will assume
> @@ -399,7 +399,7 @@ core.ignoreCase::
>  +
>  The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
>  will probe and set core.ignoreCase true if appropriate when the repository
> -is created.
> +is created. Modifying this value afterwards may result in unexpected
> behavior.
> 
>  core.precomposeUnicode::
>  	This option is only used by Mac OS implementation of Git.
> -- 
> 2.17.0.rc0.3.gb1b5a51b2
