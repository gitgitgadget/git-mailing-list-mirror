From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: [PATCH v2] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 14:20:00 +0200
Message-ID: <964d34b0b5dcdb2e26cac78096629d44@telesun.imag.fr>
References: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
 <CA+hdvHjnVc50rOsxeKUHrwBxRHi4FjcG5sSnnKYWejwXLesKNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Simon Perrat <simon.perrat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeQ51-0007np-VF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 14:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab2FLMUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 08:20:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37145 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab2FLMUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 08:20:05 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5CCArJw019429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 14:10:53 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CCK1ng027880;
	Tue, 12 Jun 2012 14:20:01 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5CCK1Mi026892;
	Tue, 12 Jun 2012 14:20:01 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5CCK0Es026891;
	Tue, 12 Jun 2012 14:20:00 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <CA+hdvHjnVc50rOsxeKUHrwBxRHi4FjcG5sSnnKYWejwXLesKNg@mail.gmail.com>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 14:10:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CCArJw019429
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1340107854.24703@vqzGf5UcoYZcy6KpNYhOpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199779>

On Tue, 12 Jun 2012 10:44:40 +0200, Simon Perrat wrote:
> 2012/6/11 <Javier.Roucher-Iglesias@ensimag.imag.fr>
>
>> + =C2=A0 =C2=A0 =C2=A0 if ($op eq "fill") {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (<Reader>) =
{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 my ($key, $value) =3D /([^=3D]*)=3D(.*)/;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # error if key undef
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (not defined $key) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print STDERR "ERROR reciving rep=
onse=20
>> git
>> credential fill\n";
>
> rec*eiving re*sponse
>
>

Changed it

>> +sub ask_login {
>> + =C2=A0 =C2=A0 =C2=A0 run_credential("fill");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (!$mediawiki->login( {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lgname =3D> $wiki=
_login,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lgpassword =3D> $=
wiki_passwd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lgdomain =3D> $wi=
ki_domain,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } )) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print STDERR "Failed to log in mediawiki=20
>> user
>> \"$wiki_login\" on $url\n";
>
> Is there a reason for escaping $wiki_login alone ?
>

Ok, i have changed the message now there is no quotes

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print STDERR "URL:$wiki_domain $url\n";
>
> Space after :
>

Space added

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print STDERR "(error " .
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 $mediawiki->{error}->{code} . ': ' .
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 $mediawiki->{error}->{details} . ")\n";
>
> Broken indentation
>

indentation changed

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!$wiki_passwd=
) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #user knows, password not.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ask_login();
>
> know*n (other instances below)
> and don't forget space after # ;)
>
>
> Best regards.

Space added


Thanks
