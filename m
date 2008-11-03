From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 03 Nov 2008 10:18:56 -0800 (PST)
Message-ID: <m38ws0fzca.fsf@localhost.localdomain>
References: <200811031943.30033.angavrilov@gmail.com>
	<200811031754.00545.fg@one2team.net>
	<bb6f213e0811030926n32c1befcj5d9add6378f7dce4@mail.gmail.com>
	<200811031845.46451.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:30:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4Bq-0005oD-Nr
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYKCS3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 13:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYKCS3A
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:29:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:59078 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbYKCS27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 13:28:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1055845nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 10:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=+WFpTiokltdkkD0uY1PWnyROicUMBExaU1l/iH0YZ7I=;
        b=gySxUl4axQCezC+BJUn/JCjakVj8TqLqyp0RcU4v97rtus/ZBwcjJBh1UHkzkfV0ox
         y3v3Z4LAoMRq37iVaGPceIz8Bf34REPZCdwQyGaqbutc08ijgJBGSLli4V80RzMcDE8g
         YmoDp9lsJU+Fuvv90uFu/qWWxOs2dNbxAsJA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=VvvMQqLLi3IqYxOF8FADu1JXue9aOGpxgSAHT375TC1of5RlpaJeW8aatJjxfbu398
         f3lW67v0Q6xCdvIqgy5n22+V6PdNczCiXTO7vMgcgfeHZMTgAdV1tTdAenH64et8Ba2b
         tafM8KIK/tUlQ+22lAvuwGMe/G+BSS60Cz+KI=
Received: by 10.210.139.15 with SMTP id m15mr440853ebd.182.1225736337844;
        Mon, 03 Nov 2008 10:18:57 -0800 (PST)
Received: from localhost.localdomain (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id c9sm5142366nfi.26.2008.11.03.10.18.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 10:18:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA3IIDY3020100;
	Mon, 3 Nov 2008 19:18:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA3IHvx4020096;
	Mon, 3 Nov 2008 19:17:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200811031845.46451.fg@one2team.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99976>

=46rancis Galiegue <fg@one2team.net> writes:
> Le Monday 03 November 2008 18:26:44 Alexander Gavrilov, vous avez =C3=
=A9crit=C2=A0:
>> On Mon, Nov 3, 2008 at 7:54 PM, Francis Galiegue <fg@one2team.net> w=
rote:
>>>
>>> It just seems to me that this is emulating functionality that
>>> multiple Web servers already provide...
>>>
>>> What's more, knowledge about these Web servers are _much_ more
>>> widespread than knowledge about gitweb.
>>>
>>> Why reinvent the wheel?
[...]

>> If you are speaking of web servers as in 'Apache', then how would it
>> know which files are going to be accessed when it executes
>> cgi-bin/gitweb.cgi?p=3Dvery/private/project.git to check permissions=
?
>>=20
>=20
> Well, as far as Apache is concerned, it can do:
>=20
> * basic .htpasswd authentication,
> * LDAP,
> * PAM,
> * SSL certificate check (via mod_ssl),
> * probably others.
>=20
> Plenty of possibilities.
[...]

Well, the question is if Apache (and other web servers used with
gitweb) can do authentication based on path_info or on query-string.
Because it is encoded in gitweb (via $projectroot) where to find git
repositories...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
