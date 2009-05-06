From: Francis Galiegue <fge@one2team.com>
Subject: Re: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed, 6 May 2009 16:49:25 +0200
Organization: One2team
Message-ID: <200905061649.25351.fge@one2team.com>
References: <1241620621-12188-1-git-send-email-julien@danjou.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Julien Danjou <julien@danjou.info>
X-From: git-owner@vger.kernel.org Wed May 06 16:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1iRF-0002Oa-BS
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 16:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760369AbZEFOt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760357AbZEFOt3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 10:49:29 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:37124 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760318AbZEFOt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 10:49:26 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 2D02192C021;
	Wed,  6 May 2009 16:49:18 +0200 (CEST)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id C6356174B0;
	Wed,  6 May 2009 16:49:25 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1241620621-12188-1-git-send-email-julien@danjou.info>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118345>

Le mercredi 06 mai 2009, Julien Danjou a =E9crit=A0:

[...]

Didn't you forget a little something in your patch?

[...]
> diff --git a/builtin-remote.c b/builtin-remote.c
[...]
> @@ -25,6 +25,7 @@ static const char * const builtin_remote_usage[] =3D=
 {
> =20
>  static int verbose;
> =20
> +static int get_one_entry(struct remote *remote, void *priv);
>  static int show_all(void);
[...]
> =20
>  	if (argc < 1)
> -		usage_with_options(builtin_remote_usage, options);
> +	{
> +		struct string_list list =3D { NULL, 0, 0 };
> +		int result =3D for_each_remote(get_one_entry, &list);



--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
