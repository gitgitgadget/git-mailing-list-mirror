From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using Transifex in git.git
Date: Tue, 14 Jun 2011 14:07:08 +0200
Message-ID: <4DF74EEC.1050506@op5.se>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com> <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 14:07:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWSOu-0007ds-JL
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 14:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab1FNMHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 08:07:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62153 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab1FNMHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 08:07:12 -0400
Received: by eyx24 with SMTP id 24so1963940eyx.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 05:07:10 -0700 (PDT)
Received: by 10.223.21.215 with SMTP id k23mr544567fab.88.1308053230493;
        Tue, 14 Jun 2011 05:07:10 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id y14sm2672901fah.37.2011.06.14.05.07.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 05:07:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175763>

On 06/14/2011 11:37 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Tue, Jun 14, 2011 at 07:57, Ramkumar Ramachandra<artagnon@gmail.co=
m>  wrote:
>> Hi Dimitris et al,
>>
>> [+CC: Git List; for wider exposure]
>> [+CC: Jonathan Nieder; he has been involved with translations in the=
 past]
>> [+CC: Junio C Hamano; for authoritative policy advice]
>>
>> I think it's a good idea to use a system like Transifex to manage
>> translations for git.git, so that we can attract a large number of
>> non-technical translators.  Further, I think it's a good time to sta=
rt
>> off on this now, since many of the i18n bits from =C6var's series ar=
e in
>> 'master'.  So, I'm looking to start off a discussion about how to
>> adapt a translation system into our current patch workflow.  Dimitri=
s
>> is the lead developer of Transifex, and can help with the details.
>=20
> Turns out I have two E-Mails related to this in my inbox. Below
> follows the reply I sent to the other one in private mail, but applie=
s
> here too:
>=20
>   * Any way of editing the translations will have to comply with git'=
s
>    normal patch submission process.
>=20
>    When you normally submit a patch to Git you have to write a
>    sensible commit message for it, change one logical thing at a time=
,
>    and you have to agree to the contributor's agreement by adding a
>    Signed-off-by to your Git commit.
>=20

Historically, a translation for one language has been considered "one
logical change" in that respect. I think it's safe to assume that if
we want translators to stick around they shouldn't need to divide their
changes on a per-message or per-command basis. Especially since such
divisions wouldn't be very easy to do if all you've got to go on is
a pot-file.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
