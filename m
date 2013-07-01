From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Mon, 01 Jul 2013 09:46:03 +0200
Message-ID: <vpqfvvyoh8k.fsf@anie.imag.fr>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	<7vr4fnsafy.fsf@alter.siamese.dyndns.org>
	<CAETqRCjZdv-_V3jmhjxZj+_XU7AKRvMZ3ojo7=yW3m846F4E1w@mail.gmail.com>
	<vpqhagj9oux.fsf@anie.imag.fr>
	<CAETqRCiJZchP6ydr1F2wPogphyUQuDFxusq+Uczcxk1kmpoD=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 01 09:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtYoS-0005vq-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 09:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab3GAHqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jul 2013 03:46:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60224 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab3GAHqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 03:46:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r617k2fT012999
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 1 Jul 2013 09:46:02 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UtYoF-0005ov-G7; Mon, 01 Jul 2013 09:46:03 +0200
In-Reply-To: <CAETqRCiJZchP6ydr1F2wPogphyUQuDFxusq+Uczcxk1kmpoD=Q@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Sat, 29 Jun 2013
 13:09:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jul 2013 09:46:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229296>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> Another idea crossed my mind: for now the test suite creates a symlin=
k
> of git-remote-mediawiki in the toplevel if it's not installed. It
> would be better to use the bin-wrapper in the testsuite I think ?

Absolutely. The symlink was a dirty hack waiting for a better solution,
it even appears in untracked files in "git status". This bin-wrapper
should be the "better solution" hopefully.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
