From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:12:26 -0700
Message-ID: <7v62cf8v2d.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue May 01 23:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKN8-0001si-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab2EAVMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:12:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab2EAVM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:12:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 786FC725C;
	Tue,  1 May 2012 17:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ENWWeDkWPNtvkEg/x79iX6nHmQ=; b=t6uPfc
	emMaT7XxK31OMgM0Ul17hln9l/BT0snVtmm6F1n13m/AzCV9VwSVld41xkoAxgo+
	WCCTxTfLI8pfzI7kqFqRHJWWNzmdx8rH1poleTbS1/cjsK2B3UnqWxcqzoDRbVfD
	baQTpaToFutvLo6EugAM9c3h0sQS9Yeh0xOz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VtMPT2KYpCniFr8Ve8Et4faVQI9vVZ6v
	sspFMJPYrrzI1Lq8Oty55ts0Imz2b3tVBIhoeYyvhttnOKKU0l5ZUviUQvUzF3mj
	aLER/revZ2g9P8LVIwEx/xl+7D+KDnzMdRg0szQ0oq76w/si3igS5U64CxMoZVpv
	XllS53I7bbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F475725B;
	Tue,  1 May 2012 17:12:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8DA8725A; Tue,  1 May 2012
 17:12:27 -0400 (EDT)
In-Reply-To: <86mx5rmx32.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Tue, 01 May 2012 14:05:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B2B45B8-93D2-11E1-BB9B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196753>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Rich> I want that if you and say, Sitaram commit conflicting changes to
> Rich> a shared branch, it's easy for me to recognize that the conflict
> Rich> exist and easy for me to resolve that conflict in my own
> Rich> repository.  I want the source code control system to keep track
> Rich> of those things, show them to me/us, and to track and show my
> Rich> resolution to you.  This stuff should all be automatic.  It
> Rich> shouldn't require explicit testing, manual pulling, nor explicit
> Rich> discussion between the three of us.  It shouldn't prohibit that
> Rich> either, but it shouldn't require it.
>
> You're asking a lot of an automated system.  I think you're trying to
> get a system to replace the communication you should be doing as a
> developer.

While what Merlyn says is always right ;-), you could automate things by
having your post-receive hook to notice that remotes/from-merlyn/master
location was updated, attempt an automerge, and then report a failure.

Not everybody wants such an automated system, so there is no such
complexity in the vanilla setting, but the important thing is that whoever
needs such a complexity could easily do so.
