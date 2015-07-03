From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 03 Jul 2015 11:16:51 +0200
Message-ID: <vpqegkp38jg.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	<vpqwpyh4rup.fsf@anie.imag.fr>
	<CAKDoJU7MT5PkoPKaF=NYne0sgNfGC6q+y7+57L0135dgxKThgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:17:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAx5k-00072K-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 11:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbbGCJRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 05:17:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52998 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbGCJQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 05:16:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t639Gor5012674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 11:16:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t639GpNh025490;
	Fri, 3 Jul 2015 11:16:51 +0200
In-Reply-To: <CAKDoJU7MT5PkoPKaF=NYne0sgNfGC6q+y7+57L0135dgxKThgw@mail.gmail.com>
	(Lawrence Siebert's message of "Fri, 3 Jul 2015 01:30:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Jul 2015 11:16:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t639Gor5012674
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436519811.85481@47XL1warud7+Al9hwRdCPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273289>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> Ok, I'll fix that.

(Note: this is a typical example of why we don't top-post here. I made
several remarks and I can't know what "that" refers to)

(Meta-note: don't take the note as agressive, I know that top-posting is
the norm in many other places, I'm just giving you a glimpse of the
local culture ;-) ).

> If it's acceptable practice, I'll just squash everything I do on this
> feature and it's tests into one commit with a more detailed comment,
> and send the patch for that.

I think at least two patches are better: your PATCH 1 is a typical
preparation step, best reviewed alone in its own patch.

Splitting history into several patches is good, but each patch should
correspond to one logical step. Splitting code Vs doc Vs tests is
usually not the right way.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
