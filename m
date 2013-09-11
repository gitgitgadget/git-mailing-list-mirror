From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 09:24:16 +0200
Message-ID: <vpq61u7akin.fsf@anie.imag.fr>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 09:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJemr-00077u-77
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 09:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab3IKHYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 03:24:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44474 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab3IKHYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 03:24:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8B7OF6M011240
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Sep 2013 09:24:15 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJeme-0003ko-EV; Wed, 11 Sep 2013 09:24:16 +0200
In-Reply-To: <xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 Sep 2013 09:42:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Sep 2013 09:24:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8B7OF6M011240
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379489059.65361@OCFjRmSCNoJng2BcbYym3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234546>

Junio C Hamano <gitster@pobox.com> writes:

> But at the same time, I feel that these redundant lines, especially
> the latter one, would give the users a stronger cue than just saying
> that "bar is Untracked"; "do X to include" reminds that bar will not
> be included if nothing is done.

The one which draw my attention was "(use "git commit" to conclude
merge)" which is particularly counter-productive when you are already
doing a "git commit". The advice for untracked files is less
counter-productive, but while we're removing the non-sensical ones, I
think it makes sense to remove the essentially-useless ones too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
