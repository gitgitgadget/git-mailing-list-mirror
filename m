From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 12 Oct 2015 21:07:35 +0200
Message-ID: <vpq612bzz0o.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	<xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
	<vpq7fms9cjs.fsf@grenoble-inp.fr>
	<xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:07:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZliRs-0000rZ-O3
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbJLTHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:07:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33992 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbbJLTHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:07:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9CJ7XV4019797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 12 Oct 2015 21:07:34 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CJ7Z2c018936;
	Mon, 12 Oct 2015 21:07:35 +0200
In-Reply-To: <xmqq37xfncak.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 12 Oct 2015 11:59:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Oct 2015 21:07:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9CJ7XV4019797
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445281656.69664@MJqqreeSgICWzw4Bh+sEJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279404>

Junio C Hamano <gitster@pobox.com> writes:

> If you design a new infrastructure to help refactoring early
> (i.e. before adding many copies of code that need to be cleaned up
> later), it would make the work of reviewing of the design of the
> helper and refactoring using that helper smaller, not larger.

But most of the code concerned is already reviewed. The first instances
of the pattern to refactor is already in next. With a real time machine,
we could go back in past, refactor and then have cleaner series, but
with Git as our only tool we can't ;-).

The current series will just add one more instance of sub-optimal code,
it isn't hard to review. Inserting new code before them would make the
interdiff far bigger.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
