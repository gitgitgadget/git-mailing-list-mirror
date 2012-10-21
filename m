From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree in Git
Date: Sun, 21 Oct 2012 12:51:02 -0700
Message-ID: <7vfw57fvtl.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
 <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
 <87fwbgbs0h.fsf@smith.obbligato.org>
 <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl>
 <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com>
 <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
 <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
 <7vbofwgwso.fsf@alter.siamese.dyndns.org> <5084102A.2010006@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dag@cray.com, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Sun Oct 21 21:51:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ1YO-0006xu-Bt
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2JUTvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:51:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab2JUTvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:51:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FAF88069;
	Sun, 21 Oct 2012 15:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xfkfucjRA7F7UxOMjyCS3CS8ldY=; b=Pm3BTq
	OBAz8Gf711VW7QQ5qIJsXasFYv8FO/ZJKHuF4J5YUcf5KY+Ur2Nd3fo/gQEE/A8U
	NLpXZ0xC36pSYrUZP+MePh6bZD2HanR8Ero6NcFnX2jQRlBqyWEHWaHTou8lgmr9
	psjz/rWOs4cljBtC3XPz7PSLhKc5VQK6SnO9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfA1pXklISIJ38fmBK1d2RZUpfahAkMQ
	W49rKVk7cKCOouQyFD/DMSI4I3QXEFL++F/iv1w/wc8XFoB3dejabAJeVU+pyYtH
	d6bE1eJ20VoA0YnDor34eE1m0WZ6ZnmvvLdCOofzASMRKyUgWMWx58UEVQfbZ7ND
	yYHC9wfF9pY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED8A8068;
	Sun, 21 Oct 2012 15:51:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41BDA8067; Sun, 21 Oct 2012
 15:51:04 -0400 (EDT)
In-Reply-To: <5084102A.2010006@initfour.nl> (Herman van Rink's message of
 "Sun, 21 Oct 2012 17:09:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5B82754-1BB8-11E2-ADF8-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208141>

Herman van Rink <rink@initfour.nl> writes:

> On 10/21/2012 08:32 AM, Junio C Hamano wrote:
>> Herman van Rink <rink@initfour.nl> writes:
>>
>>> Junio, Could you please consider merging the single commit from my
>>> subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates
>> In general, in areas like contrib/ where there is a volunteer area
>> maintainer, unless the change something ultra-urgent (e.g. serious
>> security fix) and the area maintainer is unavailable, I'm really
>> reluctant to bypass and take a single patch that adds many things
>> that are independent from each other.
>
> Who do you see as volunteer area maintainer for contrib/subtree?
> My best guess would be Dave. And he already indicated earlier in the
> thread to be ok with the combined patch as long as you are ok with it.

Yes, dag volunteered to be the area maintainer to act as a
gatekeeper for me.

The message you addressed to me was sent as a response to his
message, where he gave you specific suggestions to improve the patch
and turn it into a readable series instead of a single ball of wax
and it looked to me as if you are trying to bypass him and shove the
single ball of wax to our history over his objection.

I haven't formed an opinion on the particular change as to how bad
its collapsing unrelated changes into a single change is. Maybe they
are not as unrelated and form a coherent whole.  Maybe not.  Also I
personally do not mind too much if the area maintainer for contrib/
has a lower standard for atomicity of commits compared to the rest
of the system.  But I do prefer the decision to be made at the level
of area maintainer's, and have issues when people try to bypass
without a good reason.

Note that I was not following the thread very closely, so I may have
misread the discussion.  I read his "Unless Junio accepts..." to
mean "I (dag) still object, but if Junio accepts that patch I object
to directly, there is nothing I can do about it".  That is very
different from "I am on the fence and cannot decide it is a good
patch or not.  I'll let Junio decide; I am OK as long as he is".

Thanks.
