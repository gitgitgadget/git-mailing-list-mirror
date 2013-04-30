From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 19:05:12 +0200
Message-ID: <vpqy5c0oson.fsf@grenoble-inp.fr>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	<7va9ogezzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Szakmeister <john@szakmeister.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEI9-0003eu-U7
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab3D3RYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:24:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40896 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932652Ab3D3RYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:24:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3UH5AcO002627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 30 Apr 2013 19:05:10 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UXDzM-00069O-Mj; Tue, 30 Apr 2013 19:05:12 +0200
In-Reply-To: <7va9ogezzx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Apr 2013 09:37:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Apr 2013 19:05:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3UH5AcO002627
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367946311.51316@wn3mSnxKCMRqtgpnbwC2VQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222955>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, these options are _not_ about "showing merge commits
> that introduce code", and they do not help your kind of "security".
> As I repeatedly said, you would need "-p -m" for that.

Actually, while defaulting to --cc may be convenient, it would indeed
increase the security risk: currently, "git log -p" shows nothing for
merges, so it's rather clear that _everything_ is omitted. With --cc,
the user would see a diff, and could hardly guess that not everything is
shown without reading the doc very carefully.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
