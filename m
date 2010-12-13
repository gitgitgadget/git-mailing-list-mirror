From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 13 Dec 2010 12:46:52 -0800
Message-ID: <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
 <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <loom.20101213T194818-377@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 21:47:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSFIa-0005iO-Bp
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 21:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab0LMUrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 15:47:02 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab0LMUrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 15:47:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 812FA27BC;
	Mon, 13 Dec 2010 15:47:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a41qJ04rknYdbO8vtRjpN5tt9cY=; b=mT09Bi
	jyp32gMljz1fhhLBWEd9rxltmV57w+l7BgjT1w67pYgsQE4fvUvt3kZHV36JdRBq
	jFyyZ04QMTpEt5d5OZaXcf+hv5btcjZEbmRK9BJaNCZVJY5YZpdjpEe5bm/M5OFL
	6O/AqoGBF2M+RuTUuibNq0LFk2A8hmlPmElNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvWLl4fqshx9xJuDD45txE2BGSNfJ0KT
	dZvEkdrd3b1K9KQGqd2oFXRB9auVO+mZ9I44/QWe7vevPHvzXrNBvky2NY55pVaL
	cNA8S7YLKNri9zoQ38xHJcVS16xvx8pqUpuYdBZdCpquJmCkh/T3+9535dSBuKds
	wxJ4chgp/X4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D9C127B9;
	Mon, 13 Dec 2010 15:47:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7DE7F27B5; Mon, 13 Dec 2010
 15:47:19 -0500 (EST)
In-Reply-To: <loom.20101213T194818-377@post.gmane.org> (Yaroslav Halchenko's
 message of "Mon\, 13 Dec 2010 19\:09\:04 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F21C3C2-06FA-11E0-973F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163592>

Yaroslav Halchenko <debian@onerussian.com> writes:

> git checkout dfsg
> git merge --no-commit -s theirs 0.2
> # after all I do not, and must not have my modifications
> git rm -rf non-free-1 ... # probably would be scripted
> git commit

The other day I was talking with Shawn Pearce and said that "-s theirs"
would make sense only if used with --no-commit.

But for such a use case, "git read-tree -m -u 0.2" would work just as
well, and discussion ended there ;-)
