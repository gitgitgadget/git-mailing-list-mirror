From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 13:33:27 -0800
Message-ID: <xmqq60xnhviw.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
	<vpqziuzdr5r.fsf@anie.imag.fr>
	<20160217204528.GA22893@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@dwim.me>, Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 22:33:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW9j4-0000qc-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 22:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424307AbcBQVdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 16:33:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423542AbcBQVd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 16:33:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6FB144AB7;
	Wed, 17 Feb 2016 16:33:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2CGS8jqzgVoyijNq7ZPM6zlw5Do=; b=JLKBuN
	kHDnWR12bgI39Jgmr0FnmtMjgqnNsp/+s+nh8oKoDYPNEk0RvIiiqH87Y4Szt6Vn
	Wz16PCUTp7+jqD+FohSDdSN2QkpL7Ryo3iGc8xeSbu8YMTmRtwjxMH4J9RjaIzy+
	iLJZhuML4OjJ6rhno5OI7Cr/KEqBxuzJHklfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BaGgo09XE81qq5qPLKB6nPS+ie7aci9D
	h9yP4dQ8n5kmvC8FIHnnPcPT0QZbM/vv4iM/lBL4I0Whz6y4yWVTd/P+nLIxQXXQ
	jx0OBnrt2gYLGJe8OXDZPBVcp/y7YEUnAL+WnhE+D6FJa8EYttoEFDmsbi5xavmr
	XxO0/nliZCo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD1A244AB6;
	Wed, 17 Feb 2016 16:33:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24F6144AB5;
	Wed, 17 Feb 2016 16:33:28 -0500 (EST)
In-Reply-To: <20160217204528.GA22893@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 17 Feb 2016 15:45:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1549F4FE-D5BE-11E5-9EFF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286557>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 17, 2016 at 09:21:20PM +0100, Matthieu Moy wrote:
>
>> > I am wondering if we heard from libgit2 folks if they want us to
>> > host them (or they want to participate in GSoC at all).
>> 
>> The libgit2 mention is left from previous versions of this page. I left
>> a message on their IRC channel asking to join this thread if people were
>> interested (I don't know the libgit2 community really well, and I didn't
>> find a mailing-list to Cc here). 
>> 
>> I did not hear anything from them. We should probably remove the mention
>> of libgit2. Or, if anyone receiving this message is interested in having
>> libgit2 participate, or knows anyone who may be, speak now.
>
> I think they do a lot of their communication via GitHub issues. I've
> cc'd Carlos, the maintainer, who can ping the rest of the community as
> appropriate.
>
> I don't think we did a libgit2 project last year, and included the
> libgit2 references mainly so that we would not drop them with zero
> warning.

Understandable.  I do not mind seeing us hosting them if that is
what they want, but the candidate selection and mentor assignment
between two more-or-less independent projects would not work very
well unless there is _some_ degree of coordination ;-)
