From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3 v2] tests: factor HOME=$(pwd) in test-lib.sh
Date: Wed, 01 Sep 2010 18:57:23 +0200
Message-ID: <vpq7hj5xuz0.fsf@bauges.imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
	<AANLkTim6Cb4vegGYG0ZtJxXvAwBxHYGOY7bQFbGSAcXV@mail.gmail.com>
	<7vaao17ahi.fsf@alter.siamese.dyndns.org>
	<AANLkTi=+_+62LqhnO6dee9fv=1_naGoNzsusNt9OpX_N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:02:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqqhZ-0000Rb-Ov
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab0IARCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 13:02:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45591 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab0IARCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 13:02:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o81Grnko006079
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Sep 2010 18:53:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oqqcl-0003Ks-DM; Wed, 01 Sep 2010 18:57:23 +0200
In-Reply-To: <AANLkTi=+_+62LqhnO6dee9fv=1_naGoNzsusNt9OpX_N@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Wed\, 1
 Sep 2010 15\:40\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Sep 2010 18:53:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o81Grnko006079
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283964830.16636@CxpPmg7MpyNf1XyZI9pm9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155061>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

>> The originals all used $(pwd) as far as I saw, and it _is_ more fait=
hful
>> and correct refactoring not to use $TRASH_DIRECTORY in this patch, n=
o?
>> You can choose to change it to use $TRASH but that should be done in=
 a
>> separate patch.
>
> I just wanted to note it in case you didn't see it. It's a trivial
> issue and I don't really care, I just wanted to note it in case the v=
2
> went past you.

Just for the record: I don't care either ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
