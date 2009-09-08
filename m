From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 08 Sep 2009 08:20:55 +0200
Message-ID: <vpqhbvekldk.fsf@bauges.imag.fr>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	<81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:22:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mku5p-0001rS-Bc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbZIHGVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 02:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbZIHGVA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:21:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37076 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbZIHGU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:20:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n886HBOe002390
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Sep 2009 08:17:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mku4V-0004Ps-A7; Tue, 08 Sep 2009 08:20:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mku4V-00079E-8i; Tue, 08 Sep 2009 08:20:55 +0200
In-Reply-To: <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com> (Alex Riesen's message of "Tue\, 8 Sep 2009 07\:44\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Sep 2009 08:17:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n886HBOe002390
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252995433.52351@dDW67+ezeUxfDVjMDwLiuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127970>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Tue, Sep 8, 2009 at 07:11, Thiago Farina<tfransosi@gmail.com> wrot=
e:
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> ---
>> =A0INSTALL | =A0 =A09 +++++++++
>> =A01 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/INSTALL b/INSTALL
>> index ae7f750..67abfc7 100644
>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -1,6 +1,15 @@
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Git installation
>>
>> +To install git follow these 4 steps inside your git directory:
>> +$ autoconf =A0 =A0 =A0# Generates the configure file from configure=
=2Eac
>> +$ ./configure =A0 # Configures everything needed to build git
>> +$ make all =A0 =A0 =A0# Compiles git based in the Makefile
>> +$ make install =A0# Installs git in your own ~/bin directory

Your commit message doesn't say what's wrong with

| Alternatively you can use autoconf generated ./configure script to
| set up install paths (via config.mak.autogen), so you can write
| instead
|=20
|         $ make configure ;# as yourself
|         $ ./configure --prefix=3D/usr ;# as yourself
|         $ make all doc ;# as yourself
|         # make install install-doc install-html;# as root

which is already in INSTALL a few lines after what your patch adds.

>> +If you don't have autoconf installed, you can do this by:
>> +$ sudo apt-get install autoconf
>
> ... if you're on a Debian-derived system.=20

and if you have sudo configured.

BTW, apt-get is anyway somehow deprecaded, you should
s/apt-get/aptitude/.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
