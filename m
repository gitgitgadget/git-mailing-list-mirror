From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 01 Feb 2011 13:53:48 -0800
Message-ID: <7v1v3rzaj7.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311903320.8580@xanadu.home>
 <20110201014807.GA2722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:54:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOAp-0002ka-7o
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab1BAVyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:54:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab1BAVyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:54:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 506E74910;
	Tue,  1 Feb 2011 16:54:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1XozSSUbmgWx0qG8vu7GrZQNM74=; b=d4EtP9
	++XsdfyeabHqtJKQOZrphyHRdeRBHdfPotkJS5FBcnXI1FUd6YWmoS/VPicDl42w
	UAZnK7Gd1uJH32t8HpnXxc4EiZVFOYsNULKMcPbU6GUkdU8a5l2g8WdnQt1HgU02
	3arxvxO+kYdYQpq/ORkIOLuJnBxbPgp6x6s6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUTtyfsACjAiqzHKQfXEgE4X55g6quvI
	aDIAiuXLZle5Uv03HUZuye/wsLgzutl2aVLFz+pMQLC5SQ9LydmxHkX+w6O7dgtI
	TxegL5GpaOKS38GZ78hcKe44Se715NDTR5/vTiN8DK7rI+C00biJO0KaJVfaXfPI
	izaKZYLFWGk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1BF9490F;
	Tue,  1 Feb 2011 16:54:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2366490B; Tue,  1 Feb 2011
 16:54:42 -0500 (EST)
In-Reply-To: <20110201014807.GA2722@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 31 Jan 2011 20\:48\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E28ED20E-2E4D-11E0-BC2F-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165866>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 31, 2011 at 07:29:54PM -0500, Nicolas Pitre wrote:
>
>> > Yes, we do suck at rename following. The problem is that it is partially
>> [...]
>> This is no excuse not to do proper source tree reorganization.
>
> I think this is the crux of our disagreement. I don't agree that your
> proposal is any way more "proper" than what is there now. Leaving the
> rename issue aside (i.e., if we were starting a new project), I would
> still be slightly against a src/ directory. I find them annoying.
>
> But I don't care _that_ much, and I would rather not waste either of our
> time debating it more. I would much rather you spend your time on
> pack v4. :)

I am with you, both counts on this topic.  I don't necessarily agree that
having sources at the top-level is bad, I don't want to see Nico wasting
his time arguing, and I do see some value in the proposal that gives us an
opportunity for dogfooding (but we already have done so with builtin/ and
it was not all that annoying---I think the timing was rather good and the
tree was semi-quiescent).

Ehh, that makes it not "both" but "two and half" counts ;-).

As long as the new directories are named sanely (one of the things I
detest is abbreviated uppercase silliness like "Src", "Lib"), I am fine
with the proposal.  Also I have a mild preference to keep build-products
next to the source (i.e. no separate "obj" directory).
