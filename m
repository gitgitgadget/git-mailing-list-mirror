From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Mon, 22 Jun 2015 21:21:33 +0200
Message-ID: <vpqpp4nblc2.fsf@anie.imag.fr>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-4-git-send-email-karthik.188@gmail.com>
	<CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
	<CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z77Hv-0007JM-NS
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbFVTVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:21:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56689 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbbFVTVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:21:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MJLV1H014280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Jun 2015 21:21:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MJLXLX019762;
	Mon, 22 Jun 2015 21:21:33 +0200
In-Reply-To: <CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 23 Jun 2015 00:33:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Jun 2015 21:21:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5MJLV1H014280
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435605693.40293@hKNijmW5DM+KiC6I7ZlQXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272404>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Jun 22, 2015 at 6:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  3 & 4 as a single patch may make more sense, if we were to tolerate the
>> "let's copy & paste first and then later remove the duplicate" as a way to
>> postpone touching "tag.c" side in order to first concentrate on for-each-ref.
>>
>> I have not formed a firm opinion on what the right split of the series is, but
>> so far (assuming that the temporary duplication is the best we can do) what
>> I am seeing in this series makes sense to me.
>>
>> Thanks.
>
> That would mean squashing 3&4, 6&7 and 10&11 also on similar lines.

I have a slight preference for keeping the pairs not squashed. This way,
we have a clear separation "write reusable library code" / "use it". But
I'm fine with squashing if others prefer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
