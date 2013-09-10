From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 10 Sep 2013 10:26:00 +0200
Message-ID: <vpq4n9tjd5z.fsf@anie.imag.fr>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
	<CAMP44s0YaQo7xAkPcV3xVTcYQStUVuyY=we-=KMgtZ-xgZzz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:27:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJJHw-0005zQ-B5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab3IJI1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:27:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40843 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab3IJI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:26:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8A8Pxko032638
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Sep 2013 10:25:59 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJJGq-0000v0-A9; Tue, 10 Sep 2013 10:26:00 +0200
In-Reply-To: <CAMP44s0YaQo7xAkPcV3xVTcYQStUVuyY=we-=KMgtZ-xgZzz1Q@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 9 Sep 2013 18:17:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Sep 2013 10:25:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8A8Pxko032638
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379406360.09498@rLQFAAAMstlybZNtiO6wHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234425>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The problem is the newcomers, and the newcomers will most definitely
> not activate a configuration option to tell them that they are doing
> something potentially undesirable.

I teach Git to 200 newcommers each year. All of them run "git pull" the
first day, but believe me, very few of them want to know what a rebase
is at that time.

(I also work with experienced computer scientists, and actually, very
few of them want to know what a rebase is either :-( )

> By the time they learn about pull.mode, they probably already know
> what a rebase is. So what is the point of the configuration in the
> first place?
[...]
> That doesn't mean anything, you are assuming the user will do 'git
> pull --rebase', and there's no rationale as to why they would end up
> doing that.

So, you insist in asking the user to chose between rebase and merge, but
you also insist that they will not chose rebase? So, why ask?

> 'git commit' by default "prevents" users from creating commits without
> first adding changes to the staging area, and since it's a concept
> unique to Git, it's fair to say that none of the newcomers understand
> why 'git commit' is failing, the error messages is not particularly
> useful either.

I don't particularly agree that not defaulting to --all was a good idea,
but that's another topic.

But the error message is rather clear:

  no changes added to commit (use "git add" and/or "git commit -a")

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
