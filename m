From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 8/8] Add git-ls, a user friendly version of ls-files and more
Date: Thu, 20 Mar 2014 12:56:23 +0100
Message-ID: <vpqd2hhkrrs.fsf@anie.imag.fr>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395310551-23201-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 12:56:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbaO-00042s-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 12:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbaCTL4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 07:56:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127AbaCTL43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 07:56:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2KBuMK7018330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Mar 2014 12:56:22 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2KBuNgq017371;
	Thu, 20 Mar 2014 12:56:23 +0100
In-Reply-To: <1395310551-23201-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 20
 Mar 2014 17:15:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Mar 2014 12:56:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2KBuMK7018330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395921386.1234@Ks4kFBW0KC5igjjvfnQ0AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244543>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
> +{
> +	struct argv_array av =3D ARGV_ARRAY_INIT;
> +	argv_array_pushl(&av, "ls-files",
> +			 "--color", "--column", "--max-depth=3D0",
> +			 "--exclude-standard", "--refresh-index",
> +			 NULL);

I already have "git ls" as an alias for "git ls-files
--exclude-standard", so this change would bring me even more goodies, I
like it.

I'm a bit hesitant on the --max-depth=3D0 part by default. I like the w=
ay
my "git ls" alias recurses by default, but that may be just because I'm
used to it. Also, disabling it is can only be done by adding
--max-depth=3D-1 to the command-line, which isn't very convenient. Perh=
aps
there should be a "git ls -R" shorthand for "git ls --max-depth=3D-1".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
