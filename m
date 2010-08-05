From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Thu, 05 Aug 2010 18:47:21 +0200
Message-ID: <vpqfwytnh0m.fsf@bauges.imag.fr>
References: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:52:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3fk-0003Ni-0S
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933449Ab0HEQvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 12:51:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:58192 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab0HEQvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:51:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o75GlLCY008197
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 18:47:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oh3bF-00053X-G4; Thu, 05 Aug 2010 18:47:21 +0200
In-Reply-To: <AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Thu\, 5
 Aug 2010 13\:31\:18 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 05 Aug 2010 18:47:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152689>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

>> +in `$SHELL`, or the default shell if `$SHELL` is not set), so you c=
an
>> +use usual shell commands like "cd". The command is run from the
>
> I think that needs a definite article: ".. use the usual ..".

I don't think so, especially with a plural "commands" after.
Googlefight agrees with me ("use the usual commands" =3D> 350 results,
"use usual commands" =3D> 4900), but that's not a proof. Perhaps a
native speaker could help?

> As I pointed out in a previous comment to the series this sort of
> debug code should either be converted to use "test" or we should
> incorporate it into test-lib.sh and use it everywhere.
>
> I somewhat like the latter. It's sometimes hard to see what's going
> wrong with our tests. It'd also translate to TAP subtests.

I'll do both: use test -f in a first patch, and propose alternative in
the second. New patch serie follows.

I don't know TAP and TAP subtests, but if the functions exist, other
patches can be added on top to improve them.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
