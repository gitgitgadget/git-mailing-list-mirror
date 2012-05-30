From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: [PATCH/RFC]Test environment for Git-MediaWiki
Date: Wed, 30 May 2012 18:30:04 +0200
Message-ID: <4FC64B0C.6070507@ensimag.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	charles.roussel@ensimag.fr, julien.khayat@ensimag.imag.fr,
	Simon PERRAT <Simon.Perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 18:52:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZm8X-0003gv-O0
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 18:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2E3QwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 12:52:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37875 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab2E3QwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 12:52:17 -0400
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 May 2012 12:52:17 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4UGLjaE032052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 18:21:45 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4UGU2hI014526;
	Wed, 30 May 2012 18:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 May 2012 18:21:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4UGLjaE032052
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1338999705.84414@Jewi1933qH5sPiYo0xprIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198818>

Hello all,

We are developing the test environment for the Git-MediaWiki project.
=46or now, we have focused mainly on the environment with some simple t=
est=20
cases.

In this version, we have developed a script to install and delete a=20
MediaWiki wiki easily.
The environment provides shell functions to manage a wiki (fetch,=20
delete, edit a page, compare the content of a page) and a git-mediawiki=
=20
() repository.
There are two simple test cases for git clone.

You can find all the code in our Github:=20
https://github.com/Fafinou/git/wiki and how to install and run the test=
s.

We would like you to give us a lot of comments about our code :)

Note
* In this version we have a binary file "wikidb.sqlite" which contains=20
an empty SQLite3 database. We know this is not a good thing to put a=20
binary file in a repository so we will change this bad behavior later=20
(we will generate the "wikidb.sqlite" file with a http request to the=20
config page of MediaWiki)
* We will add simple test cases for pull and push the soonest

Thanks you in advance for your time ;)

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
