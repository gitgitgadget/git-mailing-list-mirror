From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/4] textconv: make diff_options accessible from blame
Date: Fri, 04 Jun 2010 09:59:47 +0200
Message-ID: <vpqy6evut1o.fsf@bauges.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
	<7vvd9z5owr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>, git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 10:07:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKRvx-0007sC-61
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 10:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab0FDIHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 04:07:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:59185 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab0FDIHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 04:07:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o547xmNl014479
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Jun 2010 09:59:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OKRoh-0004Mh-VI; Fri, 04 Jun 2010 09:59:48 +0200
In-Reply-To: <7vvd9z5owr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 03 Jun 2010 22\:48\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 04 Jun 2010 09:59:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148384>

Junio C Hamano <gitster@pobox.com> writes:

> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>
>> Diff_options specify whether conversion is activated or not. Blame n=
eeds
>> to access these options in order to concert files with external driv=
ers
>>
>> Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
>> Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr=
>
>> Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
>
> The name of Cl=E9ment is spelled correctly on the mail header while S=
-o-b
> line is corrupt.

Actually, it's valid UTF-8, but there's no header specifying the
encoding in the email, therefore, the reader's default applies. My
mailer displays it correctly, but yours doesn't.

> Perhaps you have recorded your commits in UTF-8 but allowed your MUA
> to send in 8859-1?

The MUA seems to be git-send-email. According to the source (I didn't
find it in the doc), git-send-email looks at the patch's headers to
specify the encoding.

On my machine, the patch applies well, and if I re-export it using
format-patch, I do get the headers:

Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

If I send myself the patch with git-send-email, I also get the headers
in the email (I tried from ensibm, which is the machine which sent the
patch serie). So, it doesn't look like a bug in git, but rather a
miss-use.

Axel, can you give us the exact command(s) you used to send the patch?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
