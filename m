From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better coding-style
Date: Mon, 10 Jun 2013 10:37:48 +0200
Message-ID: <vpqk3m2qs2r.fsf@anie.imag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulxby-00006D-H5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab3FJIhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:37:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47122 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3FJIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:37:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A8blHf018394
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:37:49 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ulxbo-0008I4-J5; Mon, 10 Jun 2013 10:37:48 +0200
In-Reply-To: <1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Mon, 10 Jun 2013
 00:22:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 10:37:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227262>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> @@ -1285,8 +1285,7 @@ sub get_mw_namespace_id {
>  		# Look at configuration file, if the record for that namespace is
>  		# already cached. Namespaces are stored in form:
>  		# "Name_of_namespace:Id_namespace", ex.: "File:6".
> -		my @temp =3D split(/\n/, run_git("config --get-all remote."
> -						. $remotename .".namespaceCache"));
> +		my @temp =3D split(/\n/, run_git("config --get-all remote.${remote=
name}.namespaceCache"));

I tend to prefer the former, as it avoids long lines (> 80 columns)

> @@ -1339,8 +1338,7 @@ sub get_mw_namespace_id {
> =20
>  	# Store explicitely requested namespaces on disk
>  	if (!exists $cached_mw_namespace_id{$name}) {
> -		run_git("config --add remote.". $remotename
> -			.".namespaceCache \"". $name .":". $store_id ."\"");
> +		run_git(qq(config --add remote.${remotename}.namespaceCache "${nam=
e}:${store_id}"));

Same.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
