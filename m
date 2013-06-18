From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to  and --bcc
Date: Tue, 18 Jun 2013 12:15:11 +0200
Message-ID: <f1cbf11015d6ebd9640b2b59ab4631e1@ensibm.imag.fr>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0mTWC87Z1E3eZ_gzjXrmtFb9ir6aY7mXVBfe9oHHXCHcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UosxB-0005ff-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab3FRKPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:15:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33310 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab3FRKPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:15:16 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IAFAv1001892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 12:15:10 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5IAFBAb010636;
	Tue, 18 Jun 2013 12:15:11 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5IAFBGD001586;
	Tue, 18 Jun 2013 12:15:11 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5IAFBCx001585;
	Tue, 18 Jun 2013 12:15:11 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CALkWK0mTWC87Z1E3eZ_gzjXrmtFb9ir6aY7mXVBfe9oHHXCHcQ@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 12:15:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228187>

Le 2013-06-18 12:12, Ramkumar Ramachandra a =C3=A9crit=C2=A0:
> Jorge-Juan.Garcia-Garcia@ensimag.imag.fr wrote:
>> The format of email list handled is pretty basic for now:
>>         $ git send-email --to=3D'Foo <foo@example.com>,=20
>> bar@example.com'
>> We thought it would be nice to have a "first-step" version which=20
>> works
>> before handling more complex ones such as:
>>         $ git send-email --to=3D'Foo, Bar <foobar@example.com>'
>
> Is this a regression?  I can't send emails to a recipient whose name
> contains a comma?
It is not. Previously the input would be considered incorrect:

-# Verify the user input
-
-foreach my $entry (@initial_to) {
-	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
-}
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
