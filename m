From: Simon Perrat <simon.perrat@gmail.com>
Subject: Re: [PATCH v2] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 10:44:40 +0200
Message-ID: <CA+hdvHjnVc50rOsxeKUHrwBxRHi4FjcG5sSnnKYWejwXLesKNg@mail.gmail.com>
References: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 10:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeMis-000506-WE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 10:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab2FLIpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 04:45:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39475 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab2FLIpC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 04:45:02 -0400
Received: by obbtb18 with SMTP id tb18so8013421obb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=86FCUmZ2+Ah3azhBfwrUSBDJ3y2OG25WCOzqm+JJ1fQ=;
        b=mSNb/wffh/7qLRPEs5/N7IgAf4GqlFR7JEyeuWgFVrPcZKz8t0ULZqCpnS1lL6jPMT
         mvLfcx6byxs2eNFAWxn3M/0SPsmWSpZ8ONSMA7lMyfwxBX9XRf2I4bH0Rwyxppz/acxo
         iRFSHeLrjWxB8JCHA4iMsAFdf1V4fuAQTCoYPjz4/NXTUqn7OBdUVbwCiBB+CUwAStgf
         26oRm2sIBghlhDy8kPvEh3WoPmxB7E1fKyYSBP8hobj09JCoe/M+62xupBEkm8beJXKO
         LuvLs3pBvnCIaIicRzd28yCUh4WBxxvDd1nl7VWojkEsM6fnAIsswbykKQeOSJpD20D0
         3ikQ==
Received: by 10.182.5.164 with SMTP id t4mr19947712obt.1.1339490701516; Tue,
 12 Jun 2012 01:45:01 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Tue, 12 Jun 2012 01:44:40 -0700 (PDT)
In-Reply-To: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199771>

2012/6/11 <Javier.Roucher-Iglesias@ensimag.imag.fr>

> + =A0 =A0 =A0 if ($op eq "fill") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (<Reader>) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my ($key, $value) =3D /=
([^=3D]*)=3D(.*)/;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # error if key undef
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (not defined $key) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print S=
TDERR "ERROR reciving reponse git
> credential fill\n";

rec*eiving re*sponse


> +sub ask_login {
> + =A0 =A0 =A0 run_credential("fill");
> +
> + =A0 =A0 =A0 if (!$mediawiki->login( {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lgname =3D> $wiki_login,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lgpassword =3D> $wiki_passwd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lgdomain =3D> $wiki_domain,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } )) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "Failed to=
 log in mediawiki user
> \"$wiki_login\" on $url\n";

Is there a reason for escaping $wiki_login alone ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "URL:$wiki=
_domain $url\n";

Space after :

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "(error " =
=2E
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $mediawiki->{er=
ror}->{code} . ': ' .
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $mediawiki->{er=
ror}->{details} . ")\n";

Broken indentation

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!$wiki_passwd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #user knows, password n=
ot.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ask_login();

know*n (other instances below)
and don't forget space after # ;)


Best regards.
