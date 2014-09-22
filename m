From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Mon, 22 Sep 2014 10:34:53 -0700
Message-ID: <xmqqsijjlfsy.fsf@gitster.dls.corp.google.com>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
	<20140919093910.GA15891@peff.net>
	<CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
	<xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
	<CALKQrgd3PzwgxuhrTpNCi-zuOj3PYviknpKgfPYVWP6bNS8AqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7Vs-0000sQ-5d
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaIVRe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:34:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59968 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbaIVRe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:34:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 735663C14C;
	Mon, 22 Sep 2014 13:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WzF+2AXFnFl7Kpb+Yn8Bpz2Y95Y=; b=qhm3ku
	83R9Dc0BMGKbF4FHIi7osDzDF8+W9o/emWnpmSRO2SAHIKQ/MPdYcozfdcf8Xcvs
	7bDpO1JcpfeeO+9PxKGSGNDHRtaHnm7JVyeyysn4fCwczsyu9re5DokAaY3uUKOZ
	GhPo1Co5DLfRvNRwqgZEU7XezYMgF9aJBL0LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i/ORfhxG7TP3lKFEXHI8JT0IAYUPssaX
	xJ1m6oI06vCNyIj05+3mBUul4syeRHwNo/zBdj5qxVHqi/R847qhK7i81KYkyRK2
	/jjGNh/E5nW63hLvuacZVLmykQXrU8peM/DnHALWkjnnj7itR2YpcGtLjaP5iGz/
	iRb5ShZ1tPI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6AC493C14B;
	Mon, 22 Sep 2014 13:34:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA4203C14A;
	Mon, 22 Sep 2014 13:34:54 -0400 (EDT)
In-Reply-To: <CALKQrgd3PzwgxuhrTpNCi-zuOj3PYviknpKgfPYVWP6bNS8AqQ@mail.gmail.com>
	(Johan Herland's message of "Sat, 20 Sep 2014 02:01:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C401715E-427E-11E4-AE4D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257369>

Johan Herland <johan@herland.net> writes:

>> Assuming that this is we all agree to go in that direction, let's
>> make a list of things to be done to codify it, and do them.  For a
>> starter, I think these are needed, perhaps?
>> ...
> Sounds good to me. At least that would ...
> ...
> In addition to that we might want to consider ...

Yes, I specifically meant my list as "a starter", not wanting to
make an exhaustive list myself.
