From: Andreas Ericsson <ae@op5.se>
Subject: Re: git: cannot rename foo to Foo on a case-insensitive filesystem
 (e.g. on Windows)
Date: Wed, 29 Aug 2007 12:00:09 +0200
Message-ID: <46D543A9.3050105@op5.se>
References: <3f4fd2640708280117k3f1cd03el676a87084a83480f@mail.gmail.com> <46D3ED4E.6030606@op5.se> <82tzqjgbx0.fsf@mid.bfk.de> <5A2EFA05-7A86-440B-B027-6360DA04CD89@wincent.com> <46D42C07.50001@op5.se> <54CFD615-6E05-42AC-A0D7-063B146295B8@wincent.com> <Pine.LNX.4.64.0708282144250.28586@racer.site> <301B4A5B-1765-426E-B72C-F6248894A3E0@wincent.com> <Pine.LNX.4.64.0708290321530.28586@racer.site> <1BA15C6C-1F37-401B-B8D8-4BD147CF5225@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Florian Weimer <fweimer@bfk.de>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKLT-0001Bu-Hw
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbXH2KAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 06:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756122AbXH2KAO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:00:14 -0400
Received: from mail.op5.se ([193.201.96.20]:55337 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbXH2KAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:00:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CB64C19441D;
	Wed, 29 Aug 2007 12:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6posYiPqRDF; Wed, 29 Aug 2007 12:00:11 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id E935A1943C3;
	Wed, 29 Aug 2007 12:00:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <1BA15C6C-1F37-401B-B8D8-4BD147CF5225@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56924>

Wincent Colaiuta wrote:
> El 29/8/2007, a las 4:23, Johannes Schindelin escribi=F3:
>=20
>>
>> I acknowledged that.
>>
>> But it does not change the _meaning_ of Andreas' criticism.  They to=
ok a
>> perfectly sane system, and turned it into a mess.
>=20
> I don't think it's productive to enter into arguments about whether a=
=20
> particular operating system is a "monstrosity", "sane" or "a mess";=20
> that's why I limited my comment to a correction of a factual=20
> misstatement by Andreas and left the opinion part unchallenged. We co=
uld=20
> have avoided this thread if instead of "doesn't even have a case=20
> sensitive filesystem", he'd started his flame with "defaults to a usi=
ng=20
> a case-insensitive filesystem".
>=20
>> Yes, you _can_ change the setting.  No, most don't.  Yes, the effect=
=20
>> is...
>> you guessed it: the same as if they did not allow case sensitivity a=
t=20
>> all.
>=20
> While I agree that most just accept the default, your argument here a=
nd=20
> in your previous email is spurious; it amounts to saying "A and B is=20
> offered, but because A is the default it is the same as if B were not=
=20
> supported at all", which isn't valid logic. If you limited your argum=
ent=20
> to criticizing case-insensitive filesystems then I would have to agre=
e=20
> with you; I am not a fan of them. Likewise, if you said that the defa=
ult=20
> has undesirable consequences I would also concur. It's your attempt t=
o=20
> extend your claim to an argument for equivalence that I can't buy.
>=20

My original comment was in error. I was unaware that Apple shipped
different filesystems and that there was actually a choice. Me having
sat by a friend who did his installation didn't realize I had the optio=
n
of using a case-sensitive filesystem, so I assumed it wasn't there, whi=
ch
only goes to show that assumption indeed is the mother of all fuckups. =
Not
wanting a pointless discussion in which everyone agrees in spirit but
nitpicks about factual details, I didn't respond to any of the posts.

Since it seems we all agree that case-insensitive, case-reporting file-
systems are disgusting and it's now thoroughly proven that Apple does
indeed ship a proper filesystem with its OS X releases, can we please
drop this now and move on to trying to improve things? I'll take
universal silence on the subject as "good idea, let's do that"

>=20
>> and we have to suffer.
>=20
> but, don't you think you're exaggerating a bit here? How much=20
> "suffering" has this really caused you?

Plenty enough, I should imagine. As David Kastrup mentioned, Dscho
does extensive work on MSYS/MingW while not using it himself.

Besides that, there are all these timeconsuming threads that some
ignorant dumbass (in this case me) turn into silly pie-fights with
some uninformed remark that is overly tainted by personal opinion.

My apologies. I shall do my research better in the future.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
