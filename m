From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 12:06:41 -0700
Message-ID: <7vsj0oa2m6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com>
	<87li6g969j.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0kMvac7Sp3QwvEm+J_-Hj7JAn-AY-juDDw1HR3oQ+hamA@mail.gmail.com>
	<51B736FA.5010407@alum.mit.edu>
	<CALkWK0n=gbfeG87GCR0A=fZY5osjndLo9TPv1BH1uAf37eQ8=g@mail.gmail.com>
	<51B76FD6.7070304@alum.mit.edu>
	<CALkWK0kAhB8mimKMrW9i8JJkz+L7-jMDaes_U8bzjWyNq88fEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:06:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTu4-0001od-JT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab3FKTGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:06:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab3FKTGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E62F245A2;
	Tue, 11 Jun 2013 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MBe2xMG0Tr2XXw/pyzWN/ZQ/IR4=; b=GzpHrw
	gwDIVPoyfBGHtzimaaH6lT0wtK6kK9zNkF3jw6ircuIpaLvl8nNXjohkovR/TXtS
	kE16N+afISqvT6eW7VE64oYDM7YA7kmAULJ/eeyCH+ivi0psTI8sT9wsqmg2tBUH
	oEda19Snx9lnfI3jecMXeVe1vboTj9WVgw6w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGuQmdfEIriNw6o70uFVrRWj5hdEHasE
	1LbAz8M46DSabdIviqp+/BleknsZXQwysX4j09Qsecm4Z5XzHTUx2GidFsqSTP67
	qZbNuwTN+LzQRxYrpU5xszYlOZFPPiub94BYD9AyLxoHH55Npv49wjFibElJbMjP
	rOjzkGqAplM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42281245A0;
	Tue, 11 Jun 2013 19:06:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DB202459C;
	Tue, 11 Jun 2013 19:06:42 +0000 (UTC)
In-Reply-To: <CALkWK0kAhB8mimKMrW9i8JJkz+L7-jMDaes_U8bzjWyNq88fEQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 12 Jun 2013 00:25:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D859B6E-D2CA-11E2-BE1C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227499>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Michael Haggerty wrote:
>> I stopped reading your email here.  I've read enough tactless emails
>> over the last few days, but to be asked to read an email that was
>> *intentionally* written tactlessly is too detrimental to my quality of life.
>
> I'm sorry, but the problem has no solution then.
>
> The "problem" we are dealing with is irrational and/or out-of-tone
> emails.  Unless you possess some mind-control mechanism that will get
> all contributors to write emails that conform to your standards, there
> is no solution.

Actually there is.  Just ignore the troll.

In the past few days, I've learned to mostly skim mails from you and
Felipe on this topic (and perhaps some other topics) just enough to
see if there is anything worth reading and/or responding to in them,
and have ignored most of them.

That gave me some time back to do the real work.

If you argue that we should not punish "people" but "bad behaviour",
that is fine.  The "From:" field, combined with the "Subject: "
field, is often a pretty good indication to tell if a message is
worth reading and/or responding to, so ignoring such messages and
ignoring troll senders practically amount to the same thing.
