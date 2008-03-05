From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 05 Mar 2008 13:54:10 -0600
Message-ID: <47CEFA62.4070209@freescale.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:55:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWzhj-00057R-FH
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYCETy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYCETy1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:54:27 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:35661 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYCETy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:54:26 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m25JsMn7002492;
	Wed, 5 Mar 2008 12:54:23 -0700 (MST)
Received: from [10.214.72.43] (mvp-10-214-72-43.am.freescale.net [10.214.72.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m25JsLb7004985;
	Wed, 5 Mar 2008 13:54:21 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76255>

Santi B=C3=A9jar wrote:
> Useful when you want a different email/name for each repository
>=20
> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> ---
>  Documentation/config.txt |    5 +++++
>  cache.h                  |    1 +
>  config.c                 |    5 +++++
>  environment.c            |    1 +
>  ident.c                  |    6 +++---
>  5 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4027726..d7e5b6d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -914,6 +914,11 @@ url.<base>.insteadOf::
>  	never-before-seen repository on the site.  When more than one
>  	insteadOf strings match a given URL, the longest match is used.
> =20
> +user.default::
> +	If false the defaults values for user.email and user.name are not

s/defaults/default

> +	used. Useful when you want a different email/name for each
> +	repository, normally set in the global config file.
> +

You already _can_ have a different email/name for each
repository, right?  Isn't the issue that you want to _force_
each repository to explicitly have these values set?

jdl

