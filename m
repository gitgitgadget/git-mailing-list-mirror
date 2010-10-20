From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 20 Oct 2010 13:34:44 +0200
Message-ID: <vpqfww1ksh7.fsf@bauges.imag.fr>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<vpq8w1v5gce.fsf@bauges.imag.fr>
	<BED961D6-5C2A-4535-B706-BFB9727CE398@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 13:34:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8WwX-0000Ln-5a
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 13:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab0JTLes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 07:34:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48196 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab0JTLer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 07:34:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9KBSdwH007476
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Oct 2010 13:28:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P8WwP-0007WQ-6O; Wed, 20 Oct 2010 13:34:45 +0200
In-Reply-To: <BED961D6-5C2A-4535-B706-BFB9727CE398@gmail.com> (Thore Husfeldt's message of "Wed\, 20 Oct 2010 11\:53\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Oct 2010 13:28:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9KBSdwH007476
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288178920.47751@8Tl0G9qUBhPfjVFrRM1FMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159406>

Thore Husfeldt <thore.husfeldt@gmail.com> writes:

>> Branch bobsstuff set up to track remote branch master from bob.
>
> (By the way, I think =E2=80=9Cremote branch=E2=80=9D is useful and co=
rrect, here.)

But "track" should be "upstream" here to be consistant with
"--set-upstream". Maybe:

Remote branch master from bob set as upstream for bobsstuff.

?

> Let me see if I can use the proposed terminology:
>
> 1. bob/master *tracks* master.
> 2. bob/master is a remote-tracking branch

I do like the dash between remote and tracking.

This is roughly the current terminology, but as you pointed out, it's
not used consistantly in the doc.

> 3. master is a remote branch
> 4. bob/master has been marked as "upstream" from bobsstuff=20

That's my understanding too.

(no time for more detailed answer, sorry)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
