From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
	values for user.*
Date: Wed, 5 Mar 2008 21:44:14 +0100
Message-ID: <20080305204414.GB4877@steel.home>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-15?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0Tw-0001Fv-E8
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYCEUoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 15:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYCEUoS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:44:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:61822 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYCEUoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 15:44:17 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jDDhk=
Received: from tigra.home (Fae6c.f.strato-dslnet.de [195.4.174.108])
	by post.webmailer.de (klopstock mo30) (RZmta 16.8)
	with ESMTP id n03f7dk25HlGPd ; Wed, 5 Mar 2008 21:44:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E66EE277BD;
	Wed,  5 Mar 2008 21:44:14 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7F93D56D24; Wed,  5 Mar 2008 21:44:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76262>

Santi B=E9jar, Wed, Mar 05, 2008 20:18:04 +0100:
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -914,6 +914,11 @@ url.<base>.insteadOf::
>  	never-before-seen repository on the site.  When more than one
>  	insteadOf strings match a given URL, the longest match is used.
> =20
> +user.default::
> +	If false the defaults values for user.email and user.name are not

"If false the default values"... An "s" in "default" was superflous

> @@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHOR_NAME";
>  static const char co_env[] =3D "GIT_COMMITTER_NAME";
>  static const char *env_hint =3D
>  "\n"
> -"*** Your name cannot be determined from your system services (gecos=
).\n"
> +"*** Your name cannot be determined.\n"

Why not?

