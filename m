From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 3 Jun 2016 11:52:22 +0200
Message-ID: <D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org> <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org> <9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Matthieu.Moy@grenoble-inp.fr
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:54:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8lmb-0003PN-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbcFCJw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 05:52:27 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:42581 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcFCJw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 05:52:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8022A257E;
	Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulGII-CuCSTB; Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 700E02576;
	Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 644822077;
	Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvRar3FVGtgM; Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
Received: from eduroam-032227.grenet.fr (eduroam-032227.grenet.fr [130.190.32.227])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4B6142066;
	Fri,  3 Jun 2016 11:52:23 +0200 (CEST)
X-Priority: 3
In-Reply-To: <9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296296>

> From: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
>> This document attempts to help you configure a Triangular Workflow.
>> +Here is an example of configuration:
>> +
>> +........................................
>> +------------               -----------
>> +| UPSTREAM |  maintainer   | ORIGIN  |
>=20
> UPSTREAM and ORIGIN are two different types of description. Origin be=
ing a too generic Git name that is used multiply elsewhere.
>=20
> That said, trying to find a good name for that 'third place' is not e=
asy. It's neither upstream, nor downstream (for Junio - the maintainer =
special case - git.git would be his downstream). The me/git repo is lik=
e a ferryman's landing across the other side of the river flow, a safe =
harbour if you will.
>=20
> Finding a suitable name has all the same issues as deciding the gener=
ic public name for the staging area / index. The ability to have a seco=
nd perfect copy is very new - historically all the dictionary names rel=
ate to copies or forgeries (you could only have one master - DVCS break=
s that mould). Perhaps (poorly) "MyFork", or "MyServer". There maybe a =
good French word we can use.
>=20


You=E2=80=99re right, finding a good name is not easy.=20
=46irstly, I wanted to use DOWNSTREAM and UPSTREAM. But git doesn=E2=80=
=99t make the difference between those words. =20

Looking for the description of the third place, I wrote that it=E2=80=99=
s the remote used to push modifications.=20
Assembling the main words push and remote, it creates PUSH_REMOTE which=
 seems a good name.=20
e.g. That=E2=80=99s clear to say "I push to the push_remote".  =20

As the option `branch.<branch>.pushRemote` exists, a little text has to=
 be added in order to prevent confusion.=20
By the way, in the documentation, confusions will be avoided by using `=
branch.<name>.pushRemote` and =E2=80=98push_remote`.

Like PUSH_REMOTE, the remote where we fetch can be called FETCH_REMOTE.=
=20
e.g. That=E2=80=99s clear to say "I fetch from fetch_remote".=20

Do you agree?


>=20
>> +------------       =E2=86=90       -----------
>> +         \                   /
>> +          \                 /
>> +     fetch=E2=86=93\               /=E2=86=91push
>> +            \             /
>> +             \           /
>> +             -------------
>> +             |   LOCAL   |
>> +             -------------
>> +........................................
>> +
>> +CREATE YOUR REPOSITORY
>> +----------------------
>> +The first step is to create your own repository. To do that you can=
:
>> +
>> +- a. fork (e.g. GitHub) the main project (e.g git/git), or
>> +- b. create an empty repository
>> +
>> +a. Fork the project
>> +~~~~~~~~~~~~~~~~~~~
>> +Go to the repository of the project (e.g. git/git) you want
>> +and fork it.
>=20
> As I understand it one issue is to clearly suggest that it is best to=
 fork and then clone from your me/fork project such that the origin and=
 it's fetch/push are set up the easiest way.
>=20
> If the user clones the main project before forking and then tries to =
add the me/fork there are more hoops to jump through to get all the fet=
ch/push settings re-arranged (this does depend on the Github fork metho=
d, but at least the issue of which repo is cloned should be noted)
Thank you, I will work on it.=20
