From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] t9902: fix 'test A == B' to use = operator
Date: Tue, 9 Jul 2013 11:27:22 +0200
Message-ID: <87fvvogk1x.fsf@linux-k42r.v.cablecom.net>
References: <8761wli0fe.fsf@linux-k42r.v.cablecom.net>
	<b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
	<7v1u790xzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 11:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwUCn-0003un-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 11:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab3GIJ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 05:27:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34479 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab3GIJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 05:27:25 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 11:27:21 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Jul 2013 11:27:22 +0200
In-Reply-To: <7v1u790xzj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 08 Jul 2013 10:20:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229921>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> The == operator as an alias to = is not POSIX.  This doesn't actually
>> matter for the execution of the script, because it only runs when the
>> shell is bash.  However, it trips up test-lint, so it's nicer to use
>> the standard form.
>
> OK, my knee-jerk reaction was "this is only for bash" as you said,
> but the test-lint part I agree with.
>
> But then test-lint _ought_ to also catch the use of "local" in the
> ideal world, so perhaps in the longer term we would need to treat
> this bash-only script differently from others anyway???

True.  I didn't really think about wider implications; I just noticed
that there was an easy-to-fix complaint from test-lint :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
