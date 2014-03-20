From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/8] ls_colors.c: enable coloring on u+x files
Date: Thu, 20 Mar 2014 12:46:52 +0100
Message-ID: <vpqpplhks7n.fsf@anie.imag.fr>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395310551-23201-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 12:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbRB-0007Hn-9q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 12:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbaCTLrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 07:47:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36153 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbaCTLq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 07:46:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2KBkpxU027676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Mar 2014 12:46:51 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2KBkqci017279;
	Thu, 20 Mar 2014 12:46:52 +0100
In-Reply-To: <1395310551-23201-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 20
 Mar 2014 17:15:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Mar 2014 12:46:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2KBkpxU027676
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395920815.87416@G0XtpAsTvYB2sLHGQvoRDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244541>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> git-compat-util.h does not seem to carry S_IXUGO. Anyway as far as Gi=
t
> is concerned, we only care one executable bit. Hard code it.

Why not use S_IXUSR instead of a hardcoded value? (already used in
path.c, so shouldn't be a problem wrt portability)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
