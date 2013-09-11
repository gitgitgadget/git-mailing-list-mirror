From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 11 Sep 2013 13:38:18 +0200
Message-ID: <vpqbo3za8r9.fsf@anie.imag.fr>
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
	<vpq4n9tjd5z.fsf@anie.imag.fr>
	<CAMP44s2dmn48T=c6aSLrWeTY=CKf5AYnAv7gA8bLjLMyb9-MTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 13:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJim5-0001qw-LO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 13:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab3IKLjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 07:39:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52428 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab3IKLjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 07:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8BBcH4Y013496
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Sep 2013 13:38:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJikU-000745-OK; Wed, 11 Sep 2013 13:38:18 +0200
In-Reply-To: <CAMP44s2dmn48T=c6aSLrWeTY=CKf5AYnAv7gA8bLjLMyb9-MTA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 11 Sep 2013 05:53:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Sep 2013 13:38:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8BBcH4Y013496
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379504299.47898@QVfLiwylazgJ5dqJnnsQ6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234561>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Sep 10, 2013 at 3:26 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> So, you insist in asking the user to chose between rebase and merge, but
>> you also insist that they will not chose rebase? So, why ask?
>
> Because as you said, they don't know what that is.

That does not answer my question: why ask?

Look around you what people say about Git. See how many complain about
Git not exposing enough complexity to the user. See how many would
complain about Git not advertising rebase enough. Then, look how many
complain about Git exposing too much complexity and making it too easy
to use features like rebase.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
