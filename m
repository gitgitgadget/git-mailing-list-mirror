From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: =?UTF-8?Q?=5BPATCH=5Fv=31=5D=20add=20=27git=20credential=27?=  =?UTF-8?Q?=20plumbing=20command?=
Date: Sun, 10 Jun 2012 19:41:17 +0200
Message-ID: <38899eac92a1ea5c17b98f5e7bd5d948@telesun.imag.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120609215236.Horde.J-h4cnwdC4BP06mEUeqxRlA@webmail.minatec.grenoble-inp.fr>
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
To: <konglu@minatec.inpg.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 19:41:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdm8l-000367-0e
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 19:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab2FJRlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 13:41:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35030 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474Ab2FJRlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 13:41:22 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5AHWQie022033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 19:32:26 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5AHfHqc013509;
	Sun, 10 Jun 2012 19:41:17 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5AHfHas032341;
	Sun, 10 Jun 2012 19:41:17 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5AHfHDX032340;
	Sun, 10 Jun 2012 19:41:17 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <20120609215236.Horde.J-h4cnwdC4BP06mEUeqxRlA@webmail.minatec.grenoble-inp.fr>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 10 Jun 2012 19:32:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5AHWQie022033
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1339954348.81867@gaolsq1J5hTok/6IsSkiOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199613>

On Sat, 09 Jun 2012 21:52:36 +0200, konglu@minatec.inpg.fr wrote:
> Javier.Roucher-Iglesias@ensimag.imag.fr a =C3=A9crit=C2=A0:
>
>> +git-credential - Providing and strore user credentials to git
>
> s/Providing/Provides/ & s/strore/store
>
>> +-If git-credential system have the password already stored
>> +git-credential will answer with by STDOUT:
>
> s/have/has/
>
>> +Then if the password is correct, (note: is not git credential
>> +how decides if password is correct or not. Is the external system
>> +that have to authenticate the user) it can be stored using command
>> +'git crendential approve' by providing the structure, by STDIN.
>
> Wouldn't the note be "it's not git credential that decides if the=20
> password is
> correct or not. That part is done by the external system" ?
>
>> +1. The 'git credential fill' makes the structure,
>> +with this structure it will be able to save your
>> +credentials, and if the credential is allready stored,
>> +it will fill the password.
>
> s/allready/already/
>

Thank's for the english writting corrections
it will be change it for the next patch

>> +void cmd_credential (int argc, char **argv, const char *prefix){
>> +	const char *op;
>> +	struct credential c =3D CREDENTIAL_INIT;
>> +	int i;
>> +
>> +	op =3D argv[1];
>> +	if (!op)
>> +		usage(usage_msg);
>> +
>> +	for (i =3D 2; i < argc; i++)
>> +		string_list_append(&c.helpers, argv[i]);
>> +
>> +	if (credential_read(&c, stdin) < 0)
>> +		die("unable to read credential from stdin");
>> +
>> +	if (!strcmp(op, "fill")) {
>> +		credential_fill(&c);
>> +		if (c.username)
>> +			printf("username=3D%s\n", c.username);
>> +		if (c.password)
>> +			printf("password=3D%s\n", c.password);
>> +	}
>> +	else if (!strcmp(op, "approve")) {
>> +		credential_approve(&c);
>> +	}
>> +	else if (!strcmp(op, "reject")) {
>> +		credential_reject(&c);
>> +	}
>> +	else
>> +		usage(usage_msg);
>
> Braces for the last "else" part. In general, the structure should be
>
>       if (...) {
>                /*code*/
>       } else if (...) {
>                /*code*/
>       } else {
>                /*code*/
>       }
>
> If juste one block needs brances, all the other "else if"/"else" part
> need it too.
>
> BTW, please be aware of the white spaces (here mostly in the doc) :).
>
> Lucien Kong.

I will remove brances.
