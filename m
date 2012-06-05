From: nguyenki <nguyenki@ensibm.imag.fr>
Subject: Re: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Tue, 05 Jun 2012 19:11:52 +0200
Message-ID: <d94a39850ce5bbf2dcab73c751574a1a@ensibm.imag.fr>
References: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
 <vpqvcj6lq1m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbxda-0003SQ-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab2FERdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 13:33:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41630 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab2FERdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:33:37 -0400
X-Greylist: delayed 1299 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2012 13:33:37 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55H3Hug027810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 19:03:17 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55HBr9h028679;
	Tue, 5 Jun 2012 19:11:53 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q55HBri3017618;
	Tue, 5 Jun 2012 19:11:53 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q55HBqeQ017617;
	Tue, 5 Jun 2012 19:11:52 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to nguyenki@ensibm.imag.fr using -f
In-Reply-To: <vpqvcj6lq1m.fsf@bauges.imag.fr>
X-Sender: nguyenki@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 19:03:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55H3Hug027810
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: nguyenki@ensibm.imag.fr
MailScanner-NULL-Check: 1339520601.86122@jd32L9mU050rIhey/xVMIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199271>

On Mon, 04 Jun 2012 23:34:29 +0200, Matthieu Moy wrote:
> NGUYEN Kim Thuat <kim-thuat.nguyen@ensimag.imag.fr> writes:
>

>> +		} else {
>> +			my $content =3D run_git_raw("cat-file blob $new_sha1");
>> +			mw_connect_maybe();
>> +				$mediawiki->{config}->{upload_url} =3D=20
>> "$url/index.php/Special:Upload";
>
> Broken indentation.
>
> Does this work on wiki configured in foreign languages, like french=20
> that
> has Sp=C3=A9cial:T=C3=A9l=C3=A9verser instead?
>

[[Special:Upload]] will work on any wiki, since the English names=20
(known
internally as the "canonical" page) will work regardless of the wiki's
language.

=46or example, if you go to http://fr.wikipedia.org/wiki/Special:Upload=
,=20
you'll
see that it redirects automatically.
