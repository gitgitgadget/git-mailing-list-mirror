From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 15:24:07 +0200
Message-ID: <vpqa8kwtjbc.fsf@anie.imag.fr>
References: <20160413222919.GA10474@glandium.org>
	<xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
	<20160413225234.GA21602@glandium.org> <vpqr3e8wo99.fsf@anie.imag.fr>
	<20160414093847.GA10852@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqhGB-0003CX-OE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 15:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbcDNNYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 09:24:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52967 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626AbcDNNYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 09:24:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3EDO5Fh015576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 14 Apr 2016 15:24:06 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3EDO75a001577;
	Thu, 14 Apr 2016 15:24:07 +0200
In-Reply-To: <20160414093847.GA10852@glandium.org> (Mike Hommey's message of
	"Thu, 14 Apr 2016 18:38:47 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 14 Apr 2016 15:24:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3EDO5Fh015576
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461245050.17231@l1VWTjco0WzBy9RnA7aUdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291522>

Mike Hommey <mh@glandium.org> writes:

> Yeah, that definitely is a weird corner case. Interestingly, it was
> complaining about "error: short SHA1 e34ff55 is ambiguous." when apply
> *other* commits that were in the list prior to it,

I think it did before: when normalizing the list to long sha1, i.e.
right after you closed your editor and befor starting anything else.

> That said, that would be less likely to happen if disambiguation was
> also checking checking the object type. Collisions between commits are
> less likely than between objects of different types.

Right.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
