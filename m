From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better
 coding-style
Date: Mon, 10 Jun 2013 13:00:06 +0200
Message-ID: <51B5B1B6.4000206@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr> <1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr> <vpqk3m2qs2r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 13:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulzpg-0008PL-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 13:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3FJLAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 07:00:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52462 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3FJLAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 07:00:09 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AB0595021722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 13:00:05 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AB06QT013161;
	Mon, 10 Jun 2013 13:00:06 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AB06HX009480;
	Mon, 10 Jun 2013 13:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqk3m2qs2r.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 13:00:06 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227271>

Le 10/06/2013 10:37, Matthieu Moy a =E9crit :
> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>=20
>> @@ -1285,8 +1285,7 @@ sub get_mw_namespace_id {
>>  		# Look at configuration file, if the record for that namespace is
>>  		# already cached. Namespaces are stored in form:
>>  		# "Name_of_namespace:Id_namespace", ex.: "File:6".
>> -		my @temp =3D split(/\n/, run_git("config --get-all remote."
>> -						. $remotename .".namespaceCache"));
>> +		my @temp =3D split(/\n/, run_git("config --get-all remote.${remot=
ename}.namespaceCache"));
>=20
> I tend to prefer the former, as it avoids long lines (> 80 columns)

The 80-columns rule is already broken in *many* places in this file.
I know this is not a valid reason to do it more often, but in my opinio=
n
the second version is easier to read (it's easy to miss the dots in the
first version), so we would gain from the change.


--=20
C=E9lestin Matte
