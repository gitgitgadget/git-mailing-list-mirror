From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 09:14:02 -0800
Message-ID: <7vhaoxpehx.fsf@alter.siamese.dyndns.org>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
 <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
 <20121109201057.GA11368@sigill.intra.peff.net>
 <7vr4o2plmw.fsf@alter.siamese.dyndns.org>
 <20121110003850.GB12567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 18:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXEdR-0003XY-O3
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 18:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab2KJROJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 12:14:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab2KJROF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 12:14:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 342A992EA;
	Sat, 10 Nov 2012 12:14:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UD5BqYowjCuLAyncgE9bxXSMjRg=; b=Kxjuvw
	hT/LL6Y+fBwAwufnz0jrhOByi5eWhs8xwBrzvrjLbmKHFrSeFp14Iyyy1M+LCTVp
	Q6mbTdlKNcsi6WTtPNCd3yRrj5vZ08ZOyiPpJHIODsNEWzfETNHUDXC1y7LHdGXj
	OqyKcP8aq/Zt2szyelcDLo75HROlEj1GNgcTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ydats810VPf03tLKzecW0ll3zryunN3Q
	MdcYxsyBD2mv0Y27dGz5S758SFiq7ebGQgwJrlG9zuJzE+UheBtV5OsAS5KM+w7T
	hsy3LtQM8nH1A1WcG30VSXvRYBKThdQAvn/GO07OEL6hNsrim5cru6Ffwxb4zOI9
	zvc5csqyptg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B8A92E9;
	Sat, 10 Nov 2012 12:14:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5546F92E8; Sat, 10 Nov 2012
 12:14:04 -0500 (EST)
In-Reply-To: <20121110003850.GB12567@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Nov 2012 19:38:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07455AA4-2B5A-11E2-931E-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209284>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 09, 2012 at 12:27:35PM -0800, Junio C Hamano wrote:
>
>> What we should have arranged was to have https://github.com/git/git
>> (which is not even owned by me, but I asked somebody at GitHub to
>> assign me a write privilege) writable by the interim maintainer, so
>> that normal people would keep pulling from there, while the interim
>> maintainer can choose to publish broken-out branches to his
>> repository.
>
> Yes, I have write access to that repository, too, but I intentionally
> held off from updating it out of a sense of nervousness. I figured if I
> screwed up anything too badly, people who were clued-in enough to switch
> to pulling from my repository would be clued-in enough to rebase across
> any too-horrible mistake I made. ;)

That "nervousness" reminds me of myself when I took over.  Before I
could ask for a few weeks of practice period, Linus arranged to have
folks at k.org to chown the authoritative location to me, declaring
"no practice period; it's already done and it's all yours".

And I made at least one mistake pushing 'master' with one commit
rewound too much (corrected by pushing an extra merge).  Luckily,
the world did not end ;-).

> I think if we do this again, I will make the same split you do (git/git
> for integration branches, peff/git as a mirror of my private repo).

I am fairly sure I'll have to ask you (or somebody else) again next
year around late September.

>> And it is not too late to do so; from the look of your "What's
>> cooking", you are doing pretty well ;-).
>
> Any fool can merge topics to master. The real test will be how many
> regressions people report in the next two weeks. :)

I agree that the actual merging to 'master' is mechanical with the
procedure built around Meta/Reintegrate.  Important decisions are
made before you merge a topic to 'next' and mark topics as "Will
merge to 'master'."  My comment was about that, and your responses
to the list messages.

> By the way, I did not touch 'maint' at all while you were gone. I don't
> know what your usual method is for keeping track of maint-worthy topics
> after they have gone to master. The usual "what's cooking" workflow
> keeps track of things going to master, but no more; I'd guess you
> probably just merge to maint when you delete them from last cycle's
> "graduated to master" list.

That is done by eyeballing output from Meta/GRADUATED (which spits
out something that could be fed to shell, but I do not fully trust
its logic, and always eyeball them before I prepare the temporary
file to feed Meta/Reintegrate to update 'maint').
