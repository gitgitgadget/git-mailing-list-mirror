From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Mon, 01 Jun 2015 19:06:04 +0200
Message-ID: <vpqfv6b7403.fsf@anie.imag.fr>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTAQ-0000Tx-3o
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbbFARGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 13:06:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58490 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbFARGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:06:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t51H63TE019082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 19:06:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t51H64VU024215;
	Mon, 1 Jun 2015 19:06:04 +0200
In-Reply-To: <xmqqvbf7757q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 09:39:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jun 2015 19:06:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t51H63TE019082
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433783164.71429@1ON/3UHYVSNbw2YCHKnxcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270438>

Junio C Hamano <gitster@pobox.com> writes:

> Galan R=E9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>
>> Instead of removing a line to remove the commit, you can use the
>> command "drop" (just like "pick" or "edit"). It has the same effect =
as
>> deleting the line (removing the commit) except that you keep a visua=
l
>> trace of your actions, allowing a better control and reducing the
>> possibility of removing a commit by mistake.
>>
>> Signed-off-by: Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
>> ---
>
> Matthieu, is this part of your class project?

Yes it is.

> I vaguely recall that your school wants your sign-off to release
> patches to us or something like that, and that I saw some other
> patches came with your sign-off, so I am being curious.

There's no strict requirement, but since the students are working under
my guidance I think it makes sense to have my sign-off. The rule which
applies by default for students is "don't distribute your code"
(symmetrical to "don't use other students code"), which obviously does
not apply for this project: I do allow them to contribute their code!

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
