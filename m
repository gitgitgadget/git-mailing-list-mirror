From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 14:58:07 -0800
Message-ID: <7v8vwm37nk.fsf@alter.siamese.dyndns.org>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
 <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
 <20110310192851.GB19257@sigill.intra.peff.net>
 <7vtyfa3ddm.fsf@alter.siamese.dyndns.org>
 <20110310214206.GA15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxooV-0001cE-JC
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1CJW6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:58:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1CJW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:58:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2204314C;
	Thu, 10 Mar 2011 17:59:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xz29MA/QQ51TgYOGtBjVtvPf8s8=; b=mIi3XB
	nzyBUQnziQjGeV3DDYLFsVUAMQmdYb36/Gw5N7qrViOLJKLdACL+GGQBVctgXOtQ
	iEnLNzYnrFzlpJc/zjHzJmn0QXYeP4F4MC98P370q5c2VUYlyJ8gSk8cM/MGcVKu
	Ghc7bHZHNEdCrGW8PsyIsgceHwSd4KxrjvAhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJLpX3GgmpjMR/Grgtl7nzJqIchGmiPe
	lkGUlOKTmUTy+QRczENqcxq5xh/8eeAYsyQqQtzAcUmYABozVTiJ+ufClh5FT4lw
	Imb2mUraLy4hRyxiQnAS/8OOOF5MY6lX91UXY+bANJrHLS+AOEm8X8ZaCHgiJKcO
	qS7EIzLMQyk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 709033148;
	Thu, 10 Mar 2011 17:59:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C77D3136; Thu, 10 Mar 2011
 17:59:38 -0500 (EST)
In-Reply-To: <20110310214206.GA15828@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Mar 2011 16:42:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19DEFA16-4B6A-11E0-86B2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168865>

Jeff King <peff@peff.net> writes:

> Yes, I don't want to see cleanly merged parts. And "--cc" already does
> what I want by not showing them.

Are you sure about that?

What "--cc" would show largely depends on what you have in your working
tree. If your two branches fixed the same bug with very different
approaches, you may resolve the conflict favouring what one side did while
discarding everything the other side did. The file in your work tree might
be the same as "git checkout --ours $that_path" after a mergy operation.
"diff --cc" won't show anything to you in such a case.

> So my thinking was more along the lines of:
>
>   1. Get "git diff HEAD file" and store its hunks.
>
>   2. Get "git diff --cc file" and stores its hunks.
>
>   3. For each hunk in (1), if it does not have an analagous hunk in (2),
>      mark it for staging without asking the user.
>
>   4. For the remaining hunks in (1), show the user the analagous --cc
>      hunk from (2), and mark the hunk from (1) for staging if requested.
>
>   5. Create the final patch from the marked hunks, apply it to
>      HEAD:file, and put that in the index.

Actually, the largest problem I see in the above approach is _when_ you
perform the first two steps, not the details of the later steps.

The user has complete freedom outside our control between the time the
mergy operation leaves conflicts in the index and the time "add -p" is
invoked (except obviously the user cannot do any "add" to register the
resolution for the whole file to the index, as there won't be any per-hunk
resolution recording left to do by "add -p").

And as I repeatedly said, grabbing "--cc file" must be done before the
user starts mucking with the file in the working tree for the approach to
be any useful.

>> [discussion of how this could be done right]
>
> That description makes sense to me, but is way overkill for my workflow.

Obviously I don't think so.  I'd rather consider what it does an absolute
minimum (not the part that it stores in an index extension, but the part
that the reference it uses to compare against the working tree file is a
original, mechanical merge result).  By the way, I just relized that an
index extension similar to PRSF might be a way to properly give index log
similar to the reflog you wanted to have the other day---every time you
"git add", you record the previous state of the index entry there, so that
it can be replayed in reverse.

> Which really I could do with:
>
>   for i in `git diff-files --name-only --diff-filter=U`; do
>     git diff --cc $i
>     echo 'OK?'

As you already know, I disagree the usefulness of this approach (see the
"Are you sure about that?" discussion), hence I doubt the usefulness of
"have it integrated into the "git add -p" loop".
