From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCHv5 1/5] Scripts to install, delete and clear a MediaWiki
Date: Thu, 14 Jun 2012 11:20:06 +0200
Message-ID: <4FD9ACC6.50307@ensimag.imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6Dw-0008QU-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab2FNJUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 05:20:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57461 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab2FNJUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:20:07 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5E9K59j003294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 11:20:05 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5E9K47A026976;
	Thu, 14 Jun 2012 11:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 11:20:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E9K59j003294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340270406.39803@M86Dbq4rHDQz10DqTIzQCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199987>



On 14/06/2012 10:57, Matthieu Moy wrote:
> The script didn't work for me. I first applied the patches below
> (essentially style, but also a clearer error message). I get:
>
> $ ./install-wiki.sh install
> Instance already running. Restarting...
> kill: 45: No such process
>
> 2012-06-14 10:53:21: (log.c.166) server started
> mediawiki-1.19.0.tar.gz downloaded in /tmp. You can delete it later i=
f you want.
> Generating the SQLite database file. It can take some time ...
> Could not get page: http://localhost:1234/wiki/mw-config/index.php
> Can't create database file in TODO. Try to run ./install-wiki.sh dele=
te first.
>
> Indeed:
>
> $ ps -u moy | grep light
> $ telnet localhost 1234
> Trying 127.0.0.1...
> telnet: Unable to connect to remote host: Connection refused

Appears to be a local problem. Did you managed to run the script when=20
this was fixed ?

Anyway, please check out with the following wiki page if you have all=20
required package.

url: https://github.com/Fafinou/git/wiki

> Matthieu Moy (3):
>    chmod -x test-gitmw-lib.sh
>    Coding style
>    Explicit error when curl_exec() fails
>
>   contrib/mw-to-git/t/install-wiki/db_install.php | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>   mode change 100755 =3D>  100644 contrib/mw-to-git/t/test-gitmw-lib.=
sh
>

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
