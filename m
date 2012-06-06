From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 1/3] Script to install, delete and clear a MediaWiki
Date: Wed, 06 Jun 2012 15:49:20 +0200
Message-ID: <4FCF5FE0.4030608@ensimag.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr> <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr> <7vhauppuwu.fsf@alter.siamese.dyndns.org>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGcB-00023x-PN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2FFNtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 09:49:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56079 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab2FFNtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:49:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q56Dehxc007389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jun 2012 15:40:43 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q56DnJ1F011406;
	Wed, 6 Jun 2012 15:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vhauppuwu.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jun 2012 15:40:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56Dehxc007389
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339594843.1678@rYdEvrOmv2t9DVJgn+xiLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199332>



On 05/06/2012 18:48, Junio C Hamano wrote:
> Simon Cathebras<simon.cathebras@ensimag.imag.fr>  writes:
>
>> From: Guillaume Sasdy<guillaume.sasdy@ensimag.imag.fr>
>>
>> install_wiki.sh expects the first argument to be 'install' or 'delet=
e'
>> 'install' installs a MediaWiki on the web's server with SQLite3
>> 'delete' deletes the previously created wiki.
>> Note those functionnalities are made to be used from the user comman=
d line in
>> the directory t/
>>
>> install_wiki also defines a function wiki_reset which clear all cont=
ent
>> of the previously created wiki. Note this functionnality is made to =
be
>> used only by our test function in a subdirectory of t/
>>
>> Signed-off-by: Simon Cathebras<simon.cathebras@ensimag.imag.fr>
>> Signed-off-by: Guillaume Sasdy<guillaume.sasdy@ensimag.imag.fr>
>> Signed-off-by: Julien Khayat<julien.khayat@ensimag.imag.fr>
>> Signed-off-by: Simon Perrat<simon.perrat@ensimag.imag.fr>
>> Signed-off-by: Charles Roussel<charles.roussel@ensimag.imag.fr>
>> Signed-off-by: Matthieu Moy<matthieu.moy@imag.fr>
>> ---
>>   t/install-wiki.sh                |  38 ++++++++++
>>   t/install-wiki/LocalSettings.php | 129 +++++++++++++++++++++++++++=
+++++
>>   t/install-wiki/db_install.php    | 110 +++++++++++++++++++++++++++=
+
>>   t/test-gitmw-lib.sh              | 154 +++++++++++++++++++++++++++=
++++++++++++
> Hrm, I see my name on the Cc: list, but is this meant to go into my t=
ree?

Yes, but we would like to apologize for the poor choice of word. It wou=
ld
be more correct to say that we are proposing to you an improvement for
git-remote-mediawiki, currently in git/contrib/mw-to-git/t.
This improvement is actually a test environment for git-remote-mediawik=
i.



> The t/ directory is a very strange place to put an installation
> procedure for anything.

Sorry again, we intended to move our test environment from t/ to *PATH*=
=2E
Unfortunately, we made a wrong manipulation and we couldn't solve this
issue. But it will be fixed in the next patch.



>    Is this because later test scripts that
> test mw-to-git gateway need to have a mediawiki instance that runs
> locally?

Exactly.


>
> I am wondering why it is not sufficient to structure the MediaWiki
> related tests more like existing tests that require a running HTTP
> server, namely, t/lib-httpd.sh that allows such tests to proceed
> only if a suitable server is available, but we do not ship a script
> to install Apache for that.

Actually, we are providing an install script for a MediaWiki, because w=
e
need some specific configurations on it to run all the tests correctly.=
 Without forget to mention that our test are creating several page on t=
he wiki used for the tests, and reset it several times... It wouldn't b=
e realy smart to use a real and realy used wiki to test git-mw. As a
matter of fact, it is easier to create a script than providing a comple=
x
documentation on "how to install our specific mediawiki" for the user.
In addition, we are providing function of reset and deletion on the
mediawiki, for purpose of tests. And it is impossible to do if we do no=
t
install it ourselves.
Anyway, it is possible to skip those tests if a wiki is not intalled.
=46or all those reason, we believe that we must keep this script to ins=
tall a wiki in our code.



>>   mode change 100644 =3D>  100755 t/test-lib-functions.sh
>>   mode change 100644 =3D>  100755 t/test-lib.sh
> Why?


A wrong manipulation during the development: chmod +x on those file... =
We
have forgotten to correct it. Correction in the next patch.

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
