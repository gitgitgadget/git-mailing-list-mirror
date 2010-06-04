From: bonneta <bonneta@ensimag.fr>
Subject: Re: [RFC/PATCH 2/4] textconv: make =?UTF-8?Q?diff=5Foptions=20accessible?=
 =?UTF-8?Q?=20from=20blame?=
Date: Fri, 04 Jun 2010 12:21:07 +0200
Message-ID: <57f94007bc6d4f34d1929a005110073f@ensimag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr> <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr> <7vvd9z5owr.fsf@alter.siamese.dyndns.org> <vpqy6evut1o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 13:03:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKUgo-0002Ok-Km
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 13:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0FDLDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 07:03:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58561 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034Ab0FDLDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 07:03:43 -0400
X-Greylist: delayed 2553 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 07:03:43 EDT
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o54ADeHa016228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Jun 2010 12:13:40 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o54AL76S010074;
	Fri, 4 Jun 2010 12:21:07 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o54AL7uY028075;
	Fri, 4 Jun 2010 12:21:07 +0200
In-Reply-To: <vpqy6evut1o.fsf@bauges.imag.fr>
X-Sender: bonneta@ensimag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Jun 2010 12:13:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o54ADeHa016228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: bonneta@ensimag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148398>

On Fri, 04 Jun 2010 09:59:47 +0200, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>>
>>> Diff_options specify whether conversion is activated or not. Blame
needs
>>> to access these options in order to concert files with external
drivers
>>>
>>> Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
>>> Signed-off-by: Cl=C3=83=C2=A9ment Poulain <clement.poulain@ensimag.=
imag.fr>
>>> Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
>>
>> The name of Cl=C3=A9ment is spelled correctly on the mail header whi=
le S-o-b
>> line is corrupt.
>=20
> Actually, it's valid UTF-8, but there's no header specifying the
> encoding in the email, therefore, the reader's default applies. My
> mailer displays it correctly, but yours doesn't.
>=20
>> Perhaps you have recorded your commits in UTF-8 but allowed your MUA
>> to send in 8859-1?
>=20
> The MUA seems to be git-send-email. According to the source (I didn't
> find it in the doc), git-send-email looks at the patch's headers to
> specify the encoding.
>=20
> On my machine, the patch applies well, and if I re-export it using
> format-patch, I do get the headers:
>=20
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> If I send myself the patch with git-send-email, I also get the header=
s
> in the email (I tried from ensibm, which is the machine which sent th=
e
> patch serie). So, it doesn't look like a bug in git, but rather a
> miss-use.
>=20
> Axel, can you give us the exact command(s) you used to send the patch=
?

I made the patch with "git send-email --cover --annotate", and then edi=
ted
the messages with vim.

I added the S-o-b lines by copy-pasting them from the test mail I
had send to Matthieu (from thunderbird). I saw there was a problem of
encoding with the "=C3=A9" of
Cl=C3=A9ment, so I modified it.

I think I should have written the S-o-b lines directly in vim.
