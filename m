From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
Date: Wed, 7 Aug 2013 11:48:20 +0200
Message-ID: <87haf1vnkr.fsf@linux-k42r.v.cablecom.net>
References: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
	<1375813604-10565-1-git-send-email-Matthieu.Moy@imag.fr>
	<871u65yj0v.fsf@linux-k42r.v.cablecom.net>
	<vpqy58dj1ly.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 07 11:48:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V70M7-00034F-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 11:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab3HGJsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 05:48:23 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:1958 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab3HGJsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 05:48:22 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 7 Aug
 2013 11:48:18 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 7 Aug 2013 11:48:20 +0200
In-Reply-To: <vpqy58dj1ly.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	07 Aug 2013 11:23:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231817>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>>> +	grep -v "	" error
>>
>> Umm, doesn't that only test that _some_ line in the error does not
>> contain a tab?
>
> Indeed. It does work as the error message is just a one-liner, but let's
> be robust anyway.

Err, right.  I actually applied the patch and verified that the test
"erroneously" passed without the fix, but that's simply because I use
bash instead of dash.  The error message indeed is only one line, the
rest of the rebase output goes to stdout.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
