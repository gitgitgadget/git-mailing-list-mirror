From: =?UTF-8?Q?Simon_Ponti=c3=a9?= <simon@le-huit.fr>
Subject: Re: [git-multimail] smtplib, check certificate
Date: Sun, 24 Apr 2016 21:14:43 +0200
Message-ID: <571D1B23.7090806@le-huit.fr>
References: <571949D2.10507@le-huit.fr> <vpqoa92rxew.fsf@anie.imag.fr>
 <5719C7A0.50403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Simon P <simon.git@le-huit.fr>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:11:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPQy-00039R-7c
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbcDXTLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 15:11:03 -0400
Received: from mail.gnubox.eu ([212.129.16.229]:41437 "EHLO mail.gnubox.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbcDXTLC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:11:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.gnubox.eu (Postfix) with ESMTP id A96BE5A6BC2;
	Sun, 24 Apr 2016 21:10:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at gnubox.info
Received: from mail.gnubox.eu ([127.0.0.1])
	by localhost (mail.gnubox.eu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUtQKCM-wg79; Sun, 24 Apr 2016 21:10:34 +0200 (CEST)
Received: from [192.168.0.112] (85-169-145-244.rev.numericable.fr [85.169.145.244])
	by mail.gnubox.eu (Postfix) with ESMTPSA id 344605A60B1;
	Sun, 24 Apr 2016 21:10:34 +0200 (CEST)
Openpgp: id=E0275791E6CB63F284093FAF1BC5D2ED8EDF838D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <5719C7A0.50403@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292430>


Le 22/04/2016 08:41, Michael Haggerty a =C3=A9crit :
> I hate that we even have to worry about this stuff, but
> graingert/secure-smtplib looks to be GPLv3, whereas git-multimail is
> GPLv2 (like the Git project and Linux); *not* "GPLv2 or later". So if
> "inspired" means "incorporated copyrightable content" then this patch
> might be problematic.

https://github.com/git-multimail/git-multimail/pull/150#issuecomment-21=
4020193

There is a GPLv3 on the secure-smtplib implementation:
https://github.com/graingert/secure-smtplib
but I also found an older code equivalent to my patch under MIT license
here: https://github.com/cybercase/django-smtp-starttls (code in
django_smtp_starttls.py, licence in setup.py)

I think there is not problem to re-use MIT code.

Simon.
