From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Sun, 11 Oct 2015 18:21:44 +0200
Message-ID: <vpq4mhx2x5z.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 18:22:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJOF-0000iZ-RF
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbbJKQV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:21:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53465 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbJKQV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:21:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGLfMa028912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:21:42 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGLiYQ023688;
	Sun, 11 Oct 2015 18:21:44 +0200
In-Reply-To: <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 11 Oct 2015 18:18:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 11 Oct 2015 18:21:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BGLfMa028912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445185304.75859@OHITDe8yLgDMuOp/GL6Dug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279343>

Karthik Nayak <karthik.188@gmail.com> writes:

> Also does it make sense to integrate these changes here? Or would you like to
> have another series on this?

To me, the important in this series is to avoid introducing duplicated
and inconsistent code, because it would make further refactoring harder.

But this series starts getting close to finished, so you should not try
to add to much to it (at least for me: I spend some time reviewing v2
and I have an idea of what the interdiff should look like, I'd rather
avoid having new distraction in the v2->v3 interdiff).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
