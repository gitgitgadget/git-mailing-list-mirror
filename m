From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Mon, 14 Jun 2010 10:24:41 -0700
Message-ID: <7vvd9la5nq.fsf@alter.siamese.dyndns.org>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
 <7vbpbeazy5.fsf@alter.siamese.dyndns.org>
 <AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:25:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OODPK-0006y5-T0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab0FNRYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 13:24:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab0FNRYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 13:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 784BABC2D3;
	Mon, 14 Jun 2010 13:24:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=taFrZ1GQLxR+8EA5MTo7uM3AjSs=; b=A0YARl
	FEnjiwKP1GYDj+LYhPXLH+rC7VCLX7MuM2NcBxLtFxanQoUQkqkId5m4BN2zdYX4
	BeJyYhMUjLXPIcxAmnmTiAgslucKZceulPzAzeAKy0HpnKUM4ON++R+moS0MyYpi
	7PpuIi+xoKnFdE/A0vHaoxrt+rbFehAWpONBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VEeXfuXXoncTxSZQZyWe+LhGObVdFZ9F
	766y/nbZxXI1re6oxJiJ452DrAKsgVHpQ2gpW4mgusOaczw04sW3Nq4yCPoCpN6o
	tU66xonSWHZmp1GwJo+MHqdBDdVG2/Q2nL+HRZ1/+OcOyloxJEPuzIBJp8Qfwwl/
	CM9j9lzT4BY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53407BC2D1;
	Mon, 14 Jun 2010 13:24:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78A93BC2D0; Mon, 14 Jun
 2010 13:24:43 -0400 (EDT)
In-Reply-To: <AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
 (Scott Chacon's message of "Mon\, 14 Jun 2010 08\:31\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA637CCE-77D9-11DF-9173-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149131>

Scott Chacon <schacon@gmail.com> writes:

> Though the implementation of the solution is undeniably more elegant,
> I have some serious issues with the output.  As you mention next,
> 'show-branches' is second in the list, which is an issue, but there
> are several more.  'am', 'revert', 'daemon', 'shell', 'rebase' - none
> of these are appropriate for someone running 'git' and trying to see
> where to start.  If we put those aside, all we have is a big list of
> commands again which adds almost no value to what we had before.
> ...
>> If readers notice that there are some commands that are out of fashion
>> (e.g. I don't think many people use show-branch anymore in the presence of
>> "log --oneline --graph" and friends) listed in the "git help" output, that
>> is a _good thing_.  It will give us an incentive to keep the Everyday
>> document up to date, and with the effort spent for that, "git help" will
>> automatically be kept up to date as well for free ;-)
>
> That's a fine goal, but I feel like it shouldn't be an "everyday"
> document that generates that output, it should be a "beginner"
> document or a "how to start using Git" document that isn't really in
> the Git source.
>
> Thoughts?

Three points.

 - The fact that you noticed "show-branches" is _a good thing_.  If it
   doesn't deserve to be "this is the list of often used commands" given
   by "git help", it shouldn't be in (an early part of) Everyday either.

 - I think the "git help" list and "Everyday" document should serve the
   same purpose for two classes of audiences, ones that prefer online vs
   ones that prefer offline.  "Repository Maintenance" are pushed down in
   the Everyday document as they are sometimes needed but should not be
   necessary in "Everyday" operation.  I think it may be a good idea to
   stop generate-cmdlist.sh early before reading Everyday to the end,
   which would cut the cruft from "git help" output.

 - I do not necessarily agree with your notion that "git help" output is
   for "someone trying to see where to start".  To me, it is primarily to
   serve as a reminder for people who have been casually using git for
   some time (i.e. "I know what I do but I don't offhand recall how it is
   spelled").  Not everybody will stay as a newbie.

I think the last point is the crux of disagreement between us.  You have
been in the "git teaching" business for a long time, and I am very much
willing to be pursuaded, together with other participants on the list.
