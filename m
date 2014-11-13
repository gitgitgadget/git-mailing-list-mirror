From: Junio C Hamano <gitster@pobox.com>
Subject: Re: appropriate mailing list for gitk patches
Date: Thu, 13 Nov 2014 13:32:28 -0800
Message-ID: <xmqqegt6zt03.fsf@gitster.dls.corp.google.com>
References: <54651E28.9090100@informatik.uni-kiel.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: lennart spitzner <lsp@informatik.uni-kiel.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:32:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp20L-0003VS-QX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934741AbaKMVcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:32:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934245AbaKMVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:32:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBAB21D9E7;
	Thu, 13 Nov 2014 16:32:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bXIv/WrhOZtZaJRyAj6U3Qzy6TY=; b=ltff0S
	BuBE1Junuw7nnY8iFMFuTfUJRP3MYML1ftHlLUcAceoqVOXMl87O/jeY3LUPee7X
	F4J0fxEG+gxmSCR0fBGPFWLg5pVFCgwcOrjWPty8cHVS7Qq/Zu/qWWGZw/nzMgyf
	gdx3/Be3HsiyB8fukCO0yF8ASvn5vv4YEAy9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AeXdqd34mtckNr31GE9p6lfU8MEBtXaV
	fBueyx2dCJWg7sfdz7YCk3UDc36sE/Fni8IY0G4icpIdAmwsY6QK1nZ6jGyQIE6F
	pTO69lL3ZTGVh/H+SBmyNaXNdssarzpgZVWyycOezFFHE/aPyb1DTuC99C+3UT+M
	eDXkb3vXPjM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A441D9E5;
	Thu, 13 Nov 2014 16:32:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 484081D9E4;
	Thu, 13 Nov 2014 16:32:29 -0500 (EST)
In-Reply-To: <54651E28.9090100@informatik.uni-kiel.de> (lennart spitzner's
	message of "Thu, 13 Nov 2014 22:10:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91BB641C-6B7C-11E4-A56D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lennart spitzner <lsp@informatik.uni-kiel.de> writes:

> I have a patch for gitk. Should i send it to this list, or is there some
> other?  git/Documentation/SubmittingPatches mentions
> git://ozlabs.org/~paulus/gitk (the master of which i based my commit
> on), but never mentions any list(s) by name (only "the Git mailing
> list", which i presume is this one).

You are in the right place ;-)  Make sure you Cc: paulus as the area
maintainer on your patches, though.

> Also, a minor question regarding patches: I wondered why patches do not
> mention the commit id that the patch(es) are based on. My current guess
> is that the diffs containing the sha1's is considered sufficient. Is
> this the case? Are there more/other aspects?

A new development is done based on the tip of 'master' by convention
around here, so people know it is meant to apply there unless the
patch submitter says otherwise explicitly.

People send patches on a random commit of their own that is not
available to the public (e.g. you may be working on some big topic,
discover a simple bug that is not related to the topic, and create a
fix for that simple bug right there on top and send that out as a
patch).  Base commit object name would be useless in such a case
anyway.
