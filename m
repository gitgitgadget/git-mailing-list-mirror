From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 01 Mar 2012 09:10:39 -0800
Message-ID: <7vmx80nt68.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:10:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39Wh-0007M3-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846Ab2CARKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 12:10:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758789Ab2CARKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 12:10:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BC16BA7;
	Thu,  1 Mar 2012 12:10:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DbQoloBhV+14
	shIjAjlKObq/qOU=; b=Diy1vnQqDqQE03RAKSGoZy81YheprgBKA/CEo1yRW4WS
	N3WHh8Ts5ilOSjxuaVhKDccfW7bztA90HLXFsbEMAU1uQsRCSzZBuT7w/SK5DCdB
	FNF1UrsX8tKZW/VflSUxNoAfLhLEX1HVHQvSClbL78P0++a17wFYCC/waV77wXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MM+YZZ
	7HH429FT2WPQdeoZKEGXjALV+s1dpzg5bzxBV1qqYVmA6yHuEaXui+L1O0GCtMO6
	ptLI0DmOjadH4iYSuIgMvTQCVbOkuNzjtqQS6PJ0Du8QpOrg4Eh+OGX3BjnHllKp
	RsFxw9bE9k8GLGfxtRKYwbweZ1MZnOF1CFWRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDB96BA4;
	Thu,  1 Mar 2012 12:10:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0DBF6BA2; Thu,  1 Mar 2012
 12:10:40 -0500 (EST)
In-Reply-To: <8762eoimp0.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 1 Mar 2012 12:29:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78F518D0-63C1-11E1-A466-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191946>

Thomas Rast <trast@inf.ethz.ch> writes:

> Nevertheless, AFAIK it has never been used for "real work", so you ma=
y
> want to look into why that happened, and do something different.

Hrm, I totally forgot about that site while we were discussing this
yesterday.  We only see three "issues" there, and that shows nobody
bothered to register issues, and it is very understandable.  People who
read the list know that all communication that is important to Git happ=
en
here, and it will be an additional burden for reporters if they have to=
 go
there (be it Jan's site, Andrew's one, or the issue system at GitHub fo=
r
that matter) and put what you already have posted.  People who do not r=
ead
the list had no chance knowing about Jan's site to begin with, given th=
at
even I didn't immediately remember.

Also more importantly, the issues posted here are picked up and acted o=
n
reasonably quickly---it often is more than "reasonably" quickly and I
often find myself looking at a new initial report, analysis of the prob=
lem
and a tested patch in a single thread, when I check my mailbox the morn=
ing.

Such an issue won't hit the tracker, and neither the initial reporter n=
or
the developers who responded should not do a lot of extra work to get t=
he
thread in a "bug tracker" system.

Something based on the idea mentioned in =C3=86var's message (downstrea=
m in
this thread) to seamlessly integrate with the e-mail traffic might have=
 a
chance to succeed.  I also think the integration must be two-way for it=
 to
be useful.  A summary of "new issues untouched for N weeks" and another
"older issues unclosed for N weeks" periodically sent here, or somethin=
g.

Perhaps collecting messages based on a handful of simple heuristics lik=
e
"A message mentioned the keyword 'bug', but no In-Reply-To for it from =
any
list regulars came in two weeks" might be a good place to start.
