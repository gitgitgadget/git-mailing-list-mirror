From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Thu, 05 Sep 2013 08:32:26 +0200
Message-ID: <vpqbo4722yt.fsf@anie.imag.fr>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
	<vpq7gew6c0v.fsf@anie.imag.fr>
	<xmqqfvtkmm2d.fsf@gitster.dls.corp.google.com>
	<52279D91.2030802@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 05 08:32:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHT7S-0004Og-T6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab3IEGci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:32:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57267 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab3IEGch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:32:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r856WPZ7021895
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 08:32:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHT7C-0004XR-Bg; Thu, 05 Sep 2013 08:32:26 +0200
In-Reply-To: <52279D91.2030802@web.de> (Jens Lehmann's message of "Wed, 04 Sep
	2013 22:52:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Sep 2013 08:32:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r856WPZ7021895
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378967548.1269@h5Hw0DlPCItbPrw/g3B8Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233934>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.09.2013 21:19, schrieb Junio C Hamano:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> 
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> * mm/status-without-comment-char (2013-08-29) 5 commits
>>>>  - status: introduce status.displayCommentChar to disable display of #
>>>>  - SQUASH: do not fprintf() random strings
>>>>  - get rid of "git submodule summary --for-status"
>>>>  - wt-status: use argv_array API
>>>>  - builtin/stripspace.c: fix broken indentation
>>>>
>>>>  Allow "git status" to omit the prefix to make its output a comment
>>>>  in a commit log editor, which is not necessary for human
>>>>  consumption.
>>>
>>> I'm waiting for the situation of "git submodule --for-status" to be
>>> settled to send a reroll. Don't merge this for now, and let
>>> bc/submodule-status-ignored converge.
>> 
>> Thanks.  I had an impression that bc/submodule-status-ignored was
>> still being discussed.  Has what I have in 'pu' settled?
>
> Almost (see my other mail concerning bc/submodule-status-ignored).
> If the removal of the --for-status option is reverted from patch #3
> here (which I outlined in $gmane/233764) this series can be merged
> without really depending on bc/submodule-status-ignored (even though
> the temporarily unused --for-status option may look a bit strange
> until the latter is merged).

I'll also need to reword the commit messages.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
