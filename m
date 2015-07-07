From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: No one understands diff3 "Temporary merge branch" conflict markers
Date: Tue, 07 Jul 2015 23:44:38 +0200
Message-ID: <vpqd203lk1l.fsf@anie.imag.fr>
References: <CAOMsSXQVJsd0h1fnNMEJ5+cKpxbeF9mHraXva-wr6Y2zBCADbg@mail.gmail.com>
	<vpqbnfondsr.fsf@anie.imag.fr>
	<xmqqzj373lrn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Anderson <nilbus@nilbus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCafc-0004Il-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbbGGVot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:44:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33122 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbbGGVor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 17:44:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t67LiaAP027936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jul 2015 23:44:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t67LicxZ012798;
	Tue, 7 Jul 2015 23:44:38 +0200
In-Reply-To: <xmqqzj373lrn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jul 2015 10:44:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 07 Jul 2015 23:44:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t67LiaAP027936
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436910279.81122@K7pIrcaSYNNcecK/hWdA4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273606>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> ... I would say: the
>> recursive merge-base was computed internally, but not really meant to be
>> shown to the user.
>
> I wonder if the output becomes easier to read if we unconditionally
> turned off diff3-style for inner merges.

Or replace the whole conflict markers with "Sorry, cannot compute a
merge base" text when doing the recursive merge to build the merge base.

I don't know that area well enough to have a real opinion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
