From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: add some crossrefs between manual pages
Date: Wed, 12 Nov 2014 12:58:49 -0800
Message-ID: <xmqqbnoc3zli.fsf@gitster.dls.corp.google.com>
References: <1415737027-44589-1-git-send-email-max@quendi.de>
	<xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
	<96693472-344E-4ED3-B027-49A8303AF8C0@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, spearce@spearce.org, jrnieder@gmail.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:59:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xof0C-0003fs-2f
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbaKLU6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:58:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753248AbaKLU6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2469C1D133;
	Wed, 12 Nov 2014 15:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8pjPadS5tsSS6EKuLvP1GId+beM=; b=yflEEI
	NjRGj+mIe362UPNgD407rUdR6hOcQoa8lcPFA/eZmVta5vV6IQt/8HVO38IGCR3z
	7nSjwZWn96K/RvnWUzP0QFbu6kf4NCO0Oj2BzvBEhyDFUz+U4rUlA+4lUhKB3hMs
	T13G1JkS+6KjFPwUu9Gocu2M/J+bVZ1IvhqHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Of5EZqVd9/kOvYc1Ufw3kf49dtWrEZp6
	n2XQ/tPUpPsyqMS6dS8mz5O+0RDX/S34gWWiQeob4zNy4p2HOsV3/EZguPvDscVQ
	0x4iyk/iTwjUH324Qi1anLhb3HUc6HPH1fcoYxASDMCmPG92f5YGtBdK7BqXI2LJ
	RSBEU4gxGTY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BCDA1D131;
	Wed, 12 Nov 2014 15:58:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95A421D12F;
	Wed, 12 Nov 2014 15:58:50 -0500 (EST)
In-Reply-To: <96693472-344E-4ED3-B027-49A8303AF8C0@quendi.de> (Max Horn's
	message of "Wed, 12 Nov 2014 21:47:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4178C1C-6AAE-11E4-9688-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Horn <max@quendi.de> writes:

> On 11.11.2014, at 23:51, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>> +linkgit:git-fast-import[1]
>> 
>> This looks somewhat out of place; fast-import is not the only or
>> even the primary way to do a remote-helper, is it?
>
> It depends on how you look at it, I'd say. If you write a remote-helper that
> uses the import/export feature, it is absolutely vital.  All remote helpers
> I ever worked on are of that kind, so to me it is the primary way ;-),
> although of course I realize there are others. So, how would you determine
> which of the various methods is the "primary" one?

You don't.  If there exists no clear "primary" one, you do not have
to designate a random one as the "primary".

I just thought that these references are to related/relevant pages
in the same family of commands, and not a place to list possible
implementation technologies.  We do not say "see also libcurl" only
because we have the curl-based remote helper that almost everybody
uses to interact with other repositories over https:// URLs here,
and do not list send-pack or receive-pack, even though the pair
would be a natural way to implement 'fetch' and 'push' methods to a
helper to interact with a native Git repository, either.
