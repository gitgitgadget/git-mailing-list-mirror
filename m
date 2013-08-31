From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 31 Aug 2013 09:46:54 +0200
Message-ID: <52219F6E.6090605@web.de>
References: <20130829180129.GA4880@nysa> <vpqli3kqqkp.fsf@anie.imag.fr> <521f998d25eb4_174378fe7481879@nysa.mail> <521FA90A.9040903@web.de> <CAMP44s3m_7UffHfie8=_izPt5tCw+9SXPa4sqoHuphuVyTHqcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 09:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFfu6-0001al-81
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 09:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab3HaHr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 03:47:26 -0400
Received: from mout.web.de ([212.227.17.12]:52603 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab3HaHrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 03:47:25 -0400
Received: from [192.168.2.102] ([79.253.149.114]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LsQLM-1VzpRb36nA-011xre for <git@vger.kernel.org>;
 Sat, 31 Aug 2013 09:47:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s3m_7UffHfie8=_izPt5tCw+9SXPa4sqoHuphuVyTHqcw@mail.gmail.com>
X-Provags-ID: V03:K0:KzmfcvthgyLNvk1r714ZuEdr210vG2sah+1GuEaZOIagEFezzr/
 619Eq/9PKteAz8KBuRk3wA0BI76Xxw21SDjqk/X0WrsHj4GQ4kNTg5OZlwn7969YDAXDW0G
 9CKNyq9409YqFr0duvRqB+9KiKpgCnhkdEqJA84HO1c7TDbHK53gde8QWffXBcpeF6Eezba
 onoCyqEaHagHFefFQ4ilg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233506>

Am 29.08.2013 22:36, schrieb Felipe Contreras:
> On Thu, Aug 29, 2013 at 3:03 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> If you have a --work-tree option then parseopt accepts --work as wel=
l,
>> unless it's ambiguous, i.e. another option starts with --work, too. =
 So you
>> can have a descriptive, extra-long option and type just a few charac=
ters at
>> the same time.
>
> Right, but what do we use in the documentation? Writing --work-tree i=
n
> the 'git reset' table for example would be rather ugly. I'm fine with
> --work-tree, but I think it would be weird to have short-hands in the
> documentation, although not entirely bad.

I don't see what's so ugly about it.

The git command itself has a --work-tree parameter for specifying the=20
location of the checked-out files, however.  It could be confusing to=20
have the same parameter do different things:

	$ git reset --work-tree=3D/some/where reset --work-tree

Perhaps a note in the documentation is enough to clear this up.


In general I think that the full long option should be mentioned in=20
synopsis and description, while abbreviated parameters could be used in=
=20
an example.  The ability to understand unambiguous shortened options is=
=20
a general feature and doesn't have to be explained in the manpage for a=
=20
specific command.

NB: It would be nice to have more commands use parseopt, for that=20
feature alone.

Ren=C3=A9
