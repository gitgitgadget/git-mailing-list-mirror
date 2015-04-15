From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git + SFC Status Update
Date: Wed, 15 Apr 2015 09:07:56 -0700
Message-ID: <xmqqfv81ml2b.fsf@gitster.dls.corp.google.com>
References: <20150413115613.GA4589@peff.net>
	<CAD0k6qT9Sj4VQ+4PKvXmwwfuZHFoGXNmAMGxTiorx81E0U11xg@mail.gmail.com>
	<xmqq7fte33u8.fsf@gitster.dls.corp.google.com>
	<20150414235425.GA2179@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Borowitz <dborowitz@google.com>, Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:08:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiPrB-0005j0-St
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbbDOQIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:08:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932203AbbDOQH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:07:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1322646CDE;
	Wed, 15 Apr 2015 12:07:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IzPXuen1JR2TfmK6WUnW9q4nVvQ=; b=AD7pix
	e3auGm6ssSENrXBZHQ3qy319iHj0yvhEj2htp4AK9pg3nTb77Xkw9QZITsSgncmQ
	ioqQMZ1hW6MqqDn6DGcIazJiH2aVnw2NA+aLdlaQqVPhN4wMdO0HoS/IZCJCTdev
	5jZfM75d4cfXEqN58ECFRFqSyX1B2coTf3OqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wf1lyfuL1sz2gtm/dIuAW+p9MAgBKY/J
	AAjt0NvWMn5GxYQK8LEUzftVOnI+dlMCISH12jXFVrEabhJPGOTt0dvJPZ7v5CRY
	xyNDqSC7kVkB9ptBwqecTHdlaSmjTMTt8Bx+jofLA6fZixpqVLiORYv/lB1Buoyy
	MP4Z3a72AsM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D5846CDD;
	Wed, 15 Apr 2015 12:07:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F0C346CDA;
	Wed, 15 Apr 2015 12:07:57 -0400 (EDT)
In-Reply-To: <20150414235425.GA2179@peff.net> (Jeff King's message of "Wed, 15
	Apr 2015 01:54:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94DA727A-E389-11E4-803F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267208>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 14, 2015 at 12:30:23PM -0700, Junio C Hamano wrote:
>
>> > If I recall correctly, Scott said onstage that some/all of the
>> > conference proceeds would be going directly into this fund. So this
>> > might need to be revised upward by 50-100% sometime soon :)
>> 
>> I think you misheard it.  The above is money earmarked for Git at
>> SFC; the admission for GitMerge were going to SFC general fund
>> without earmarked for us, IIUC.
>
> Yeah, that's my understanding as well.

To elaborate on this a bit more, there are two ways for people to
support software freedom conservancy (SFC) by donation:

 - People can give money to the Git project, a member of the
   conservancy.  90% of that money will be earmarked for the Git
   project's use, and the rest goes to general fund to run SFC.  The
   "Donate" button on http://git-scm.com/sfc goes to this pot.  The
   "Check" option on http://git-scm.com/sfc can be directed to this
   way by earmarking the money for the Git project.

 - People can give money direct to the conservancy.  The "Check"
   option on http://git-scm.com/sfc can be directed to this way by
   not earmarking the money for the Git project.
