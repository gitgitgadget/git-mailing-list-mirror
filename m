From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 17:50:16 +0200
Message-ID: <vpqwrhevkxz.fsf@bauges.imag.fr>
References: <20110524210758.GH16052@localhost>
	<20110524224525.GI16052@localhost> <vpqfwo3ush3.fsf@bauges.imag.fr>
	<20110525150631.GA29161@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed May 25 17:50:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPGMD-0006ke-0l
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954Ab1EYPun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:50:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49386 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959Ab1EYPun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:50:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4PFoFa1004080
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 May 2011 17:50:15 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QPGLh-0005qX-0C; Wed, 25 May 2011 17:50:17 +0200
In-Reply-To: <20110525150631.GA29161@localhost> (Chris Wilson's message of
	"Wed, 25 May 2011 11:06:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 May 2011 17:50:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4PFoFa1004080
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1306943419.19686@Gqs1CezFMaG3VwmpAGzbEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174419>

Chris Wilson <cwilson@vigilantsw.com> writes:

> On Wed, May 25, 2011 at 09:52:56AM +0200, Matthieu Moy wrote:
>> Chris Wilson <cwilson@vigilantsw.com> writes:
>> 
>> > Oops, I see others putting the patches inline. Here you go.
>> 
>> Please, read Documentation/SubmittingPatches. Especially read about
>> signed-off-by and the way patches should be formatted (git send-email
>> would help).
>
> Thanks, trying this again.

Still not right ;-). The text here (above ---) will become the commit
message when applied, and you don't want the commit message to mention
this discussion. This discussion could have been added below ...

> Like I said before, the author should investigate if this variable
> should have been used before removing it.
>
> Signed-off-by: Chris Wilson <cwilson@vigilantsw.com>
> ---

=> this is the place for informal discussions.

>  sh-i18n--envsubst.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)

If you don't follow this, then the maintainer has to do this manually,
and we all prefer his time to be invested in better activities ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
