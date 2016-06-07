From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Tue, 07 Jun 2016 09:03:07 +0200
Message-ID: <vpqportbhw4.fsf@anie.imag.fr>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
	<D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org>
	<vpqy46my05v.fsf@anie.imag.fr>
	<F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org>
	<vpq7fe2rbno.fsf@anie.imag.fr>
	<A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley>
	<vpqporucl6g.fsf@anie.imag.fr>
	<0B6B083EAEAA4E428C26CDAFE56E2FF6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:03:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAB2n-0001b7-3f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbcFGHDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 03:03:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42899 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbcFGHDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 03:03:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u57736X8014121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jun 2016 09:03:06 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u57737hm013959;
	Tue, 7 Jun 2016 09:03:07 +0200
In-Reply-To: <0B6B083EAEAA4E428C26CDAFE56E2FF6@PhilipOakley> (Philip Oakley's
	message of "Mon, 6 Jun 2016 20:21:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 07 Jun 2016 09:03:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u57736X8014121
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465887789.28255@oz4lK1n2fxtmhqxVKeuo4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296606>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
>
>> But then the maintainer is not the one picking changes from it (you'=
re
>> sending them by email), so the "maintainer" label is not really accu=
rate
>> in the diagram:
>>
>> +------------               -----------
>> +| UPSTREAM |  maintainer   | ORIGIN  |
>> +|  git/git |- - - - - - - -|  me/git |
>> +------------       =E2=86=90       -----------
>> +         \                   /
>> +          \                 /
>> +     fetch=E2=86=93\               /=E2=86=91push
>> +            \             /
>> +             \           /
>> +             -------------
>> +             |   LOCAL   |
>> +             -------------
>>
> Ahh, that's a useful clarification. I use my git repo both for the G4=
W
> (which does take pull requests) and for Junio's Git.
>
> The use of the 'home-vault' fork as being for
> (a) backup,
> (b) open viewing, and
> (c) sending pull requests
> are subtle distinctions for the naming (of both the forked repo, and
> the workflow).
>
> It's probably even worse in a corporate environment as to how persona=
l
> the personal home vault is, as compared to just having a namespace in
> a centralised dev server/repo. (the question of how to make such
> arrangements seems to come up moderately often on the various lists)

Yes, but again, the point of this thread is to document *one* workflow,
not all possible uses of pushRemote. It's much easier to describe "one
typical triangular workflow" in a concrete way than to try to be
completely general and end up with a description that average users
would just not understand.

It would be different to me if we were writting the pushRemote part of
config.txt, where we have to be as general as possible.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
