From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: detached HEAD before root commit - possible?
Date: Mon, 24 Jun 2013 12:41:18 +0200
Message-ID: <vpqr4frzt81.fsf@anie.imag.fr>
References: <20130623225505.GO20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 24 12:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur4DK-0001Xv-GL
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 12:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab3FXKla convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 06:41:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50640 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab3FXKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 06:41:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OAfHsB027040
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 12:41:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur4D0-0006NW-QZ; Mon, 24 Jun 2013 12:41:18 +0200
In-Reply-To: <20130623225505.GO20052@goldbirke> ("SZEDER \=\?iso-8859-1\?Q\?G\?\=
 \=\?iso-8859-1\?Q\?\=E1bor\=22's\?\= message of
	"Mon, 24 Jun 2013 00:55:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 12:41:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228801>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

> I suspect that detaching HEAD before a root commit is not possible by
> design.  What would HEAD contain then!?  'git checkout' seems to
> corroborate:
>
> $ git init
> Initialized empty Git repository in /tmp/test/.git/
> $ git checkout --detach
> fatal: You are on a branch yet to be born

Is "git checkout --orphan" what you're looking for?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
