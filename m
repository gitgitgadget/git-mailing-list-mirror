From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Add completion for 'git help'
Date: Fri, 25 Jul 2008 14:02:15 -0700
Message-ID: <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com>
 <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
 <20080725204051.GB23202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lee Marlow <lee.marlow@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUSW-0005FL-VS
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbYGYVCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYGYVCX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:02:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYGYVCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 17:02:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D896840511;
	Fri, 25 Jul 2008 17:02:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 18E9C4050E; Fri, 25 Jul 2008 17:02:17 -0400 (EDT)
In-Reply-To: <20080725204051.GB23202@spearce.org> (Shawn O. Pearce's message
 of "Fri, 25 Jul 2008 15:40:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F97EE86A-5A8C-11DD-8591-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90114>

Thanks for an Ack, but personally I do not think the completion of "all
commands" is worth it.

I've been busy with day-job for the past few days, and haven't had chan=
ce
to push things out today, but FYI here is what I already have on 'maste=
r'
privately, relative to what have already been pushed out.

  Documentation: clarify how to disable elements in core.whitespace (Ju=
nio C Hamano)
  Makefile: fix shell quoting (Junio C Hamano)
  tests: propagate $(TAR) down from the toplevel Makefile (Junio C Hama=
no)
  index-pack.c: correctly initialize appended objects (Bj=C3=B6rn Stein=
brink)
  send-email: find body-encoding correctly (Peter Valdemar M=C3=B8rch)
  document that git-tag can tag more than heads (Jonathan Nieder)
  perl/Makefile: update NO_PERL_MAKEMAKER section (Brandon Casey)
  bash: offer only paths after '--' for 'git checkout' (SZEDER G=C3=A1b=
or)
  checkout: mention '--' in the docs (SZEDER G=C3=A1bor)
  git-checkout: improve error messages, detect ambiguities. (Pierre Hab=
ouzit)
  update test case to protect am --skip behaviour (Olivier Marin)
  Teach fsck and prune about the new location of temporary objects (Bra=
ndon Casey)
  git-checkout: fix command line parsing. (Pierre Habouzit)

At this point immediately before -rc1, I am giving much higher preceden=
ce
to real fixes than clean-ups, "use parse-opt", or new features.  Please=
 do
not get alarmed if your non-fix patches are left unresponded for a whil=
e.

BTW, has anybody taken a look at this one?

  Subject: BUG: fetch incorrect interpretation of globing patterns in r=
efspecs
  Date: Thu, 24 Jul 2008 09:07:21 +0200
  Message-ID: <71295b5a0807240007k246973abj1897895d0d67bb6c@mail.gmail.=
com>

If not, I think I probably need to take a look at this, reproducing and
possibly fixing, before applying non-fix patches.
