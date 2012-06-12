From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Tue, 12 Jun 2012 11:25:46 +0200
Message-ID: <vpqmx48x4o5.fsf@bauges.imag.fr>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
	<1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
	<CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>, git@vger.kernel.org,
	Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Simon Perrat <simon.perrat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:26:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNML-0006Uv-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2FLJZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 05:25:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59223 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab2FLJZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 05:25:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5C9GpNF011405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 11:16:52 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeNMB-0007TP-Ou; Tue, 12 Jun 2012 11:25:47 +0200
In-Reply-To: <CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com>
	(Simon Perrat's message of "Tue, 12 Jun 2012 11:06:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 11:16:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5C9GpNF011405
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340097414.36988@k29I+D/OMv/rmIHf/SphLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199775>

Simon Perrat <simon.perrat@gmail.com> writes:

> 2012/6/11 Pavel Volek <Pavel.Volek@ensimag.imag.fr>:
>
>> +sub get_mw_all_pages {
>> + =A0 =A0 =A0 my $pages =3D shift;
>> + =A0 =A0 =A0 # No user-provided list, get the list of pages from th=
e API.
>> + =A0 =A0 =A0 my $mw_pages =3D $mediawiki->list({
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D> 'allpages',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 aplimit =3D> 500
>> + =A0 =A0 =A0 });
>
> Indentation should be 8 columns wide.

More precisely, indentation in Git is done with tabs, and should displa=
y
well with 1 tab =3D=3D 8 characters.

It is actually the case in Pavel's patch. When seen as patches, the
first column is used for + and -, so the first tab is rendered as only =
7
characters, but that's normal.

Or did I miss something?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
