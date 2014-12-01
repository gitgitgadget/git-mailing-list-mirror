From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Sun, 30 Nov 2014 18:46:27 -0800
Message-ID: <xmqqh9xgrssc.fsf@gitster.dls.corp.google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
	<5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de>
	<20141127225334.GA29203@dcvr.yhbt.net> <547895F1.1010307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten =?utf-8?Q?B=C3=B6gershause?= =?utf-8?Q?n?= 
	<tboegi@web.de>, Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 01 03:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvH0V-0001Zz-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 03:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbaLACqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 21:46:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752582AbaLACqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 21:46:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 333F023912;
	Sun, 30 Nov 2014 21:46:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DYz09Q+O9rJpcb7HPsI9BD5aSEU=; b=c+Vewj
	VRMXEPwVkGXNpv6IfIRvd9N082oy6vQFJsqhgIEUK1vjOdSyVHeuL33Jd0iivYo4
	DvTL9NIRSfCIceCWeR9sSo2LIcKNfV5omXyAo/CU5Wba1y+HCgyrW5fCTVGQAX6J
	621yM3tvoYvRS+HEhCyML4xF7PXvr84HEloKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKooaaWCIjEVIjOCca/yvNklYnXEzWrk
	gD4Y8Aqla/JXSB2kyO7jbiLqERFntNjkrEsYs65pZlwIWeK8h+mUyuvksHM3meWb
	+2hkc9XElVuDJpu0eCVE4Bk2TFFVJ/TyrQCthOKby2+0KiAzvuIIxTxf1MpPqgVL
	0GCelJTyiMQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A10023911;
	Sun, 30 Nov 2014 21:46:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4DEE23910;
	Sun, 30 Nov 2014 21:46:28 -0500 (EST)
In-Reply-To: <547895F1.1010307@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 28 Nov 2014 16:34:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FF0B5C0-7904-11E4-A6A3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260462>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It seems like a few desirable features are being talked about here, and
> summarizing the discussion as "centralized" vs "decentralized" is too
> simplistic. What is really important?
>
> 1. Convenient and efficient, including for newcomers
> 2. Usable while offline
> 3. Usable in pure-text mode
> 4. Decentralized
>
> Something else?

As a reviewer / contributor (not speaking as the top maintainer), I
would say that everything in one place, and for that one place
mailbox is preferrable.

"Somebody commented on (this instance of | the central) Gerrit, come
look at it" is not usable; sending that comment out to those who
work in their MUA, and allowing them to respond via their MUA
probably adding their response as a new comment to Gerrit) would be
usable.

When I had to view a large-ish series by Ronnie on Gerrit, it was
fairly painful.  The interaction on an individual patch might be
more convenient and efficient using a system like Gerrit than via
e-mailed patch with reply messages, but as a vehicle to review a
large series and see how the whole thing fits together, I did not
find pages that made it usable (I am avoiding to say "I found it
unusable", as that impression may be purely from that I couldn't
find a more suitable pages that showed the same information in more
usable form, i.e. user inexperience).

Speaking of the "whole picture", I am hesitant to see us pushed into
the "here is a central system (or here are federated systems) to
handle only the patch reviews" direction; our changes result after
discussing unrelated features, wishes, or bugs that happen outside
of any specific patches with enough frequency, and that is why I
prefer "everything in one place" aspect of the development based on
the mailing list.  That is not to say that the "one place" has
forever to be the mailing list, though.  But the tooling around an
e-mail based workflow (e.g. marking threads as "worth revisiting"
for later inspection, saving chosen messages into a mailbox and
running "git am" on it) is already something I am used to.  Whatever
system we might end up migrating to, the convenience it offers has
to beat the convenience of existing workflow to be worth switching
to, at least to me as a reviewer/contributor.

As the maintainer, I am not worried too much.  As long as the
mechanism can (1) reach "here is a series that is accepted by
reviewers whose opinions are trusted" efficiently, and (2) allow
me to queue the result without mistakes, I can go along with
anything reasonable.
