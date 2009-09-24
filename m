From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Per-remote tracking branch
Date: Thu, 24 Sep 2009 18:00:07 +0200
Message-ID: <vpqskec5o54.fsf@bauges.imag.fr>
References: <vpq4or48bux.fsf@bauges.imag.fr>
	<20090924112550.GA6540@atjola.homenet>
	<20090924113537.GA14113@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 18:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqqkJ-0007Q9-TU
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 18:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZIXQAU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZIXQAS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 12:00:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54138 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbZIXQAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 12:00:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8OFuthN032213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Sep 2009 17:56:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mqqjn-0002Lu-7e; Thu, 24 Sep 2009 18:00:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mqqjn-0004mu-6L; Thu, 24 Sep 2009 18:00:07 +0200
In-Reply-To: <20090924113537.GA14113@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s message of "Thu\, 24 Sep 2009
 13\:35\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Sep 2009 17:56:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8OFuthN032213
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254412617.29208@hG0l93u//iTaKHmU4YypLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129047>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

>> Setup "foo" so that it fetches "master" only, i.e. have
>> remote.foo.fetch =3D refs/heads/master:refs/remotes/foo/master
>>=20
>> You get that setup with: git remote add -t master foo git://...
>>=20
>> Then there's only one possible choice for "git pull", and it will ta=
ke
>> that.
>
> Ah, crap, spoke too soon. That works only when branch.<name>.merge is
> not set. Though that's not that much of a problem. When your "primary=
"
> remote (the one set for branch.<name>.remote) also fetches just a sin=
gle
> branch, "git pull" will still work, even if branch.<name>.merge is no=
t
> set.

Yes, that's it. Thanks for your anwser, it works.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
