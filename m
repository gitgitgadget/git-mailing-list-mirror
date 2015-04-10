From: Eugen Konkov <kes-kes@yandex.ru>
Subject: Re[2]: Feature request: implement '--follow' option for `git blame`
Date: Fri, 10 Apr 2015 09:40:38 +0300
Organization: ISP FreeLine
Message-ID: <209433431.20150410094038@yandex.ru>
References: <4215491428322362@web26m.yandex.ru> <xmqqvbh7baij.fsf@gitster.dls.corp.google.com>
Reply-To: Eugen Konkov <kes-kes@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: KES <kes-kes@yandex.ua>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 08:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgSj5-0005B9-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 08:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbbDJGrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2015 02:47:35 -0400
Received: from forward16.mail.yandex.net ([95.108.253.141]:37172 "EHLO
	forward16.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbbDJGrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 02:47:33 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2015 02:47:32 EDT
Received: from smtp16.mail.yandex.net (smtp16.mail.yandex.net [95.108.252.16])
	by forward16.mail.yandex.net (Yandex) with ESMTP id 2BD1CD220DB;
	Fri, 10 Apr 2015 09:40:42 +0300 (MSK)
Received: from smtp16.mail.yandex.net (localhost [127.0.0.1])
	by smtp16.mail.yandex.net (Yandex) with ESMTP id 9CFE06A005E;
	Fri, 10 Apr 2015 09:40:41 +0300 (MSK)
Received: from 46.219.241.240.freenet.com.ua (46.219.241.240.freenet.com.ua [46.219.241.240])
	by smtp16.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Xptjy8l2mB-eeMmrm3A;
	Fri, 10 Apr 2015 09:40:40 +0300
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1428648041;
	bh=Owt8VWHckFH2LDTE53kA34oIyQj+yWrjkI4Om7soIVg=;
	h=Date:From:X-Mailer:Reply-To:Organization:X-Priority:Message-ID:To:
	 CC:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=kvqgZpydbj2BTCKdBR726v289hC7VTNTpmSnQ2onYBAOHLtwVhDJxmTOZm0eoJZbF
	 zDz6Pzjv/lXm/EHOLFg7PfKEqcjbE2zAMDnWfBYGLb3WQTqbgI3nO+PioL8KMSTmsl
	 ca4oDkH39nSiQTIZZy/dHJaLZiqddDACTJlJN88M=
Authentication-Results: smtp16.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
In-Reply-To: <xmqqvbh7baij.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267007>

=C7=E4=F0=E0=E2=F1=F2=E2=F3=E9=F2=E5, Junio.

=C2=FB =EF=E8=F1=E0=EB=E8 8 =E0=EF=F0=E5=EB=FF 2015 =E3., 5:48:36:

JCH> KES <kes-kes@yandex.ua> writes:

>> **UPDATE:** Short answer

>> `git blame` follow renames but not for `git blame COMMIT^ -- <filena=
me>`

JCH> Suppose you have file A and file B in your version v1.0.
=2E...
As it does not make any sense to tell C to Git and
JCH> then magically make it guess you meant A in some cases and B in so=
me
JCH> other.  If v1.0 did not have C, the only sensible thing to do is t=
o
JCH> exit instead of making a guess (and without telling the user how i=
t
JCH> guessed).

I agree with your complex example. But it will be great to guess in sim=
ple case, when in version v1.0 only one file A which were renamed into =
C half year later.

`git blame COMMIT^ -- C`

=46or complex example the clue will be if user supply line number he wa=
nt to blame. So if user supply line 10 we follow A, if user supply 30 w=
e follow B.
Simple and great =3D) (I mean usefull for people)

`git blame --line 10 COMMIT^ -- C`  =20
`git blame --line 30 COMMIT^ -- C`







--=20
=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC,
 Eugen                          mailto:kes-kes@yandex.ru
