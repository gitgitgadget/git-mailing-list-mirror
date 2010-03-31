From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push doesn't honor .git/config
Date: Wed, 31 Mar 2010 17:14:27 +0200
Message-ID: <vpq1vf0a5gs.fsf@bauges.imag.fr>
References: <h2x530ac78e1003310754v88853e2bj6d59d835025ec140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 17:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwzcx-0005il-Lu
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 17:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab0CaPOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 11:14:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41123 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab0CaPOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 11:14:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o2VFAGcI002972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Mar 2010 17:10:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nwzch-0003L9-Uz; Wed, 31 Mar 2010 17:14:28 +0200
In-Reply-To: <h2x530ac78e1003310754v88853e2bj6d59d835025ec140@mail.gmail.com> (Phil Lawrence's message of "Wed\, 31 Mar 2010 09\:54\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Mar 2010 17:10:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2VFAGcI002972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1270653019.33981@BaAk9f/FPKxClcAQP9JHHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143680>

Phil Lawrence <prlawrence@gmail.com> writes:

> I renamed a local branch from MIS-59 to MIS-59_project, and did the f=
ollowing:
>   git branch --set-upstream MIS-59_project origin/MIS-59
>   git push --set-upstream origin MIS-59_project:MIS-59
>
> However, .git/config is not being honored by git push; I have to
> supply all the parameters to actually push changes.

=2E.. or read the man better ;-)

       branch.<name>.merge
           [...] It tells git-fetch/git-pull which branch to merge and
           can also affect git-push (see push.default). [...]

       push.default
           [...]
           =B7   matching push all matching branches. [...] This is the=
 default.
           =B7   tracking push the current branch to its upstream branc=
h.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
