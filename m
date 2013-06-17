From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Mon, 17 Jun 2013 10:07:58 +0200
Message-ID: <8738shi2ht.fsf@linux-k42r.v.cablecom.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 10:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoUTy-0007KR-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 10:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305Ab3FQIID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 04:08:03 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34242 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304Ab3FQIIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 04:08:00 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 10:07:54 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 17 Jun 2013 10:07:56 +0200
In-Reply-To: <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 16 Jun 2013 19:38:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228050>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Isn't it a bit of an academic question?
>> ...
>> And once you have that, it seems a nicer and cleaner idea to generate
>> 'fixup! A' each time, instead of a successive sequence of
>>
>>   fixup! A
>>   fixup! fixup! A
>>   fixup! fixup! fixup! A
>>   ...
>
> As to reordering, you are absolutely correct.
[...]
> Does dropping these leading "fixup!" (or "squash!") at commit time
> make the application in "rebase -i --autosquash" significantly
> easier to do?

Conveniently enough we have seen both already ;-)  Andrew's version for
commit.c could use a bit of refactorization, since it inserts the same
code in two places, but then it's about the same complexity as the
change for rebase.

I'm not sure it's worth arguing about whether the "fixup! fixup!"  is a
symptom of some underlying problem, and changing rebase is only tapering
over the symptom; or whether it's actually a useful distinction.  Either
one works fine as a fix for an annoyance that Andrew had, and that bit
me in the past too.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
