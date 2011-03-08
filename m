From: Michal Rokos <rokos@nextsoft.cz>
Subject: Re: [PATCH] Honor HP C's noreturn attribute
Date: Tue, 8 Mar 2011 23:09:41 +0100
Message-ID: <3597D63F-589A-4BD5-B052-FA720A593301@nextsoft.cz>
References: <32EABE0E-2447-4189-A3CE-05B68A5E18EF@nextsoft.cz> <7v4o7dfndw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:09:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px56H-0003dg-4S
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1CHWJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 17:09:47 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:37967 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1CHWJq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 17:09:46 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 55F192819; Tue,  8 Mar 2011 23:09:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 02C3112DF;
	Tue,  8 Mar 2011 23:09:42 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjqAIh2MiE3J; Tue,  8 Mar 2011 23:09:41 +0100 (CET)
Received: from [10.0.10.2] (gw.rokos.cz [188.175.127.20])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTPSA id CADF1B8;
	Tue,  8 Mar 2011 23:09:41 +0100 (CET)
In-Reply-To: <7v4o7dfndw.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168707>

Dear Junio,

On 8.3.2011, at 20:00, Junio C Hamano wrote:

> Michal Rokos <rokos@nextsoft.cz> writes:
>=20
>> The __HP_cc define detects the HP C compiler version. Precede the
>> __GNUC__ check so it works well when compiling with HP C using -Agcc
>> option that enables partial support for the GNU C dialect. The -Agcc
>> defines the __GNUC__ too.
>=20
> I love it when people write a very readable log message to explain wh=
y the
> patch _has_ to be the way it is.  Very good job.
>=20
> Except for the overlooooooooong lines in the message, which I line-wr=
apped
> locally before applying, that is.


thank you for your review. I will try to improve overall patch and the =
commit
log quality when sending something more.

Michal

--

Michal Rokos

NextSoft spol. s r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
Czech Republic
mobile: +420 736 646 591
fax:    +420 267 224 307
e-mail: rokos@nextsoft.cz
