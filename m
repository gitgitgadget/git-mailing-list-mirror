From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Our cumbersome mailing list workflow
Date: Thu, 27 Nov 2014 19:24:12 +0100
Message-ID: <vpqoars7b8z.fsf@anie.imag.fr>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
	<5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 19:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu3jw-0006gR-M1
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 19:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbaK0SYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2014 13:24:24 -0500
Received: from mx2.imag.fr ([129.88.30.17]:45928 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbaK0SYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 13:24:24 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sARIOABJ013028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Nov 2014 19:24:10 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sARIOCe5006004;
	Thu, 27 Nov 2014 19:24:12 +0100
In-Reply-To: <54776367.1010104@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Thu, 27 Nov 2014 18:46:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Nov 2014 19:24:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sARIOABJ013028
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1417717452.04013@jih6VNklx2yynvrYX3dFEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260350>

Torsten B=F6gershausen <tboegi@web.de> writes:

> On 2014-11-25 01.28, Michael Haggerty wrote:
> []
>> Let me list the aspects of our mailing list workflow that I find
>> cumbersome as a contributor and reviewer:
>>=20
>> * Submitting patches to the mailing list is an ordeal of configuring
>> format-patch and send-email and getting everything just right, using
>> instructions that depend on the local environment.
> Typically everything fits into ~/.gitconfig,
> which can be carried around on a USB-Stick.

I personnally submit all my Git patches from a machine whose
/usr/sbin/sendmail knows how to send emails, so for me configuration is
super simple. But I can imagine the pain of someone working on various
machines with various network configuration and normally using a webmai=
l
to send emails. Sharing ~/.gitconfig does not always work because on
machine A you only can use one SMTP server, and on machine B only
another ...

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
