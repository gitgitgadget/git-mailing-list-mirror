From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Wed, 08 Jul 2015 11:07:40 +0200
Message-ID: <vpqwpybf25f.fsf@anie.imag.fr>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
	<1436285177-12279-1-git-send-email-karthik.188@gmail.com>
	<559CDAC1.8030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 08 11:08:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZClKv-0001ZN-6M
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 11:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715AbbGHJII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 05:08:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59516 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932997AbbGHJHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 05:07:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6897deV031664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2015 11:07:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6897etl021452;
	Wed, 8 Jul 2015 11:07:40 +0200
In-Reply-To: <559CDAC1.8030600@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Wed, 8 Jul 2015 10:09:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jul 2015 11:07:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6897deV031664
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436951262.48981@SZflDygmXqXxSr4erdMiIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273654>

Torsten B=F6gershausen <tboegi@web.de> writes:

> Could we have a tweak for people without gpg?

I guess we need stg like

if ! test_have_prereq GPG; then
	skip_all=3D'skipping for-each-ref tests, gpg not available'
	test_done
fi

since we need GPG in the setup test and almost all other tests will rel=
y
on it.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
