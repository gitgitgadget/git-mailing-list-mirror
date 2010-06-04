From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/4] textconv: make diff_options accessible from blame
Date: Fri, 04 Jun 2010 19:23:12 +0200
Message-ID: <vpq1vcmaf0f.fsf@bauges.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
	<7vvd9z5owr.fsf@alter.siamese.dyndns.org>
	<vpqy6evut1o.fsf@bauges.imag.fr>
	<57f94007bc6d4f34d1929a005110073f@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: bonneta <bonneta@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 19:28:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKah1-00053d-N8
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 19:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab0FDR2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 13:28:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:45346 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab0FDR2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 13:28:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o54HNC6Q012408
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Jun 2010 19:23:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OKabw-0007nT-9E; Fri, 04 Jun 2010 19:23:12 +0200
In-Reply-To: <57f94007bc6d4f34d1929a005110073f@ensimag.fr> (bonneta@ensimag.fr's message of "Fri\, 04 Jun 2010 12\:21\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 04 Jun 2010 19:23:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148430>

bonneta <bonneta@ensimag.fr> writes:

> On Fri, 04 Jun 2010 09:59:47 +0200, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

>>>> Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.=
fr>
>>>
>>> The name of Cl=E9ment is spelled correctly on the mail header while=
 S-o-b
>>> line is corrupt.
>>=20
>> Actually, it's valid UTF-8, but there's no header specifying the
>> encoding in the email,
[...]
>> Axel, can you give us the exact command(s) you used to send the patc=
h?
>
> I made the patch with "git send-email --cover --annotate", and then e=
dited
> the messages with vim.
>
> I added the S-o-b lines by copy-pasting them=20

OK, I got it. You ran "git format-patch", and it didn't find any
non-ascii characters, so it didn't add any encoding header. Then you
added UTF-8, and the header still wasn't there.

You can use "git rebase -i" to edit the commit messages directly, and
add the s-o-b there, then git format-patch will DRT.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
