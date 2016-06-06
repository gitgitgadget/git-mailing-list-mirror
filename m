From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Mon, 06 Jun 2016 18:54:31 +0200
Message-ID: <vpqporucl6g.fsf@anie.imag.fr>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
	<D1C9E2B7-EA50-4D36-A77F-00BE7E693B8F@grenoble-inp.org>
	<vpqy46my05v.fsf@anie.imag.fr>
	<F57B7CD2-8F8B-4D58-B145-285E69F9B4BE@grenoble-inp.org>
	<vpq7fe2rbno.fsf@anie.imag.fr>
	<A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:54:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xnc-0001RP-N9
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbcFFQyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:54:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48098 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcFFQyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:54:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56GsTBY007319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 18:54:29 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56GsVBg004549;
	Mon, 6 Jun 2016 18:54:31 +0200
In-Reply-To: <A8FD6EF510F149A4A05FE553BEDD8511@PhilipOakley> (Philip Oakley's
	message of "Mon, 6 Jun 2016 17:46:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 18:54:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56GsTBY007319
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465836871.12834@wDXVqA0/YNMHjtJCTtkNJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296538>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
>>
>> I don't think you will find a name that fits all use-cases. IHMO, be=
st
>> is to pick one rather general use-case, make the explanations for it=
,
>> and maybe explain somewhere that there are variants.
>>
>> If the fork is completely private, then your diagram with a "maintai=
ner"
>> arrow from it to upstream is not valid.
>
> That's only true for a Pull Request workflow. For a Patch workflow
> (such as Git) the user's home vault can be completely private.

But then the maintainer is not the one picking changes from it (you're
sending them by email), so the "maintainer" label is not really accurat=
e
in the diagram:

+------------               -----------
+| UPSTREAM |  maintainer   | ORIGIN  |
+|  git/git |- - - - - - - -|  me/git |
+------------       =E2=86=90       -----------
+         \                   /
+          \                 /
+     fetch=E2=86=93\               /=E2=86=91push
+            \             /
+             \           /
+             -------------
+             |   LOCAL   |
+             -------------

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
