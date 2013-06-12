From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 14:41:25 +0200
Message-ID: <vpqehc7y00a.fsf@anie.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
	<CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
	<CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
	<fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:41:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkMn-0000Kf-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab3FLMl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 08:41:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53414 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3FLMl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:41:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CCfOsw003771
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 14:41:24 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmkMf-0000AY-Pe; Wed, 12 Jun 2013 14:41:25 +0200
In-Reply-To: <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr> ("Mathieu
	\=\?iso-8859-1\?Q\?Li\=E9nard--Mayor\=22's\?\= message of "Wed, 12 Jun 2013
 12:17:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 14:41:24 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227609>

Mathieu Li=E9nard--Mayor <mathieu.lienard--mayor@ensimag.fr> writes:

> $ git status
> # HEAD detached from ecb9f3e
> # You are currently editing a832578... my_commit_message [3/5] while
> rebasing.

Showing the commit message here is too much IMHO. With a typical
50-characters message, it already gives

# You are currently editing a832578 ___________________________________=
_______________ [3/5] while rebasing

and we usually try to fit everything on a 80-columns terminal.

My vote would go for just showing the short sha1. The user can run "git
show $sha1" to get more information if needed, it's just a copy-paste
away. If we want to show the commit message, it should be on its own
line.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
