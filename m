From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 10:05:14 +0200
Message-ID: <vpqfvtb7phh.fsf@anie.imag.fr>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
	<vpq61u7akin.fsf@anie.imag.fr>
	<CALZVapmYzKO=fvVgSd+3fzAhdGrawU0C=iETkoJ5fxG87o4KtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 10:05:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJfQl-0003ed-1v
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 10:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab3IKIFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 04:05:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42409 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3IKIFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 04:05:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8B85EYj031771
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Sep 2013 10:05:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJfQJ-0004OK-0j; Wed, 11 Sep 2013 10:05:15 +0200
In-Reply-To: <CALZVapmYzKO=fvVgSd+3fzAhdGrawU0C=iETkoJ5fxG87o4KtA@mail.gmail.com>
	(Javier Domingo's message of "Wed, 11 Sep 2013 09:42:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Sep 2013 10:05:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8B85EYj031771
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379491520.68282@AFHZaeFcVs3xtGlCPUHfAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234549>

Javier Domingo <javierdo1@gmail.com> writes:

> IMHO, It is alright as it is.
>
> I have been using git for 4~ years now, and I still find very useful
> those lines. They are like a git status while committing, and it's the
> key to avoid accidental commits of objects or forgetting files in a
> commit.

Having the list of staged/unstaged/untracked is the key to that, and I'm
not planning on changing that. Having advices on how to change it
("run ... to ...") is another matter.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
