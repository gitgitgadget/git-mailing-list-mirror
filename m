From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Wed, 03 Oct 2012 11:41:08 -0700
Message-ID: <7v391v5rgb.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
 <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
 <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com>
 <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com>
 <CABURp0rho3KvzHRNXj9EA9C2OnbTc_dcmiBiW6JZ-VHu4g2m0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:41:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJTss-00086P-9L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818Ab2JCSlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:41:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab2JCSlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:41:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA6F9903C;
	Wed,  3 Oct 2012 14:41:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=63qO5fCrSYeOjscDgGJq2HK02EE=; b=WcH33s
	DpDBMJ85WZpGFbgaRpC+G8TjOs/s4ExuUyoXeB52VCsvKzrPjoaJb/fIHt0j7ACZ
	9vACeaNvh+Eih9cfYiDSnTDjSOKu2sHWhEBDFFviRV6CQekiHToDFVeTg7vbffbm
	uaWgd9dWaVFfIN/G1W88R0zRlVcKV5eFWBKi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F5LWrtlIsO3S24qUiE5UhXv78gWMl8yc
	9+HAyCcJkm9c7xAwOdZrNyrmaRYcPtX0XDCJDnXxkWb2hQcSTljEyIU7YYPiOPTF
	z01EgTRfU+Pe4q4FFvwkqJ/F8by5bouuB5xD3nmRaKz2tsLIcsIOxeAr1YT8doix
	8Z8jpvcI2t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A802A903B;
	Wed,  3 Oct 2012 14:41:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AF0A903A; Wed,  3 Oct 2012
 14:41:09 -0400 (EDT)
In-Reply-To: <CABURp0rho3KvzHRNXj9EA9C2OnbTc_dcmiBiW6JZ-VHu4g2m0Q@mail.gmail.com> (Phil
 Hord's message of "Wed, 3 Oct 2012 12:23:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E654BFBC-0D89-11E2-9FC8-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206920>

Phil Hord <phil.hord@gmail.com> writes:

> I flagged this for followup in my MUA, but I failed to follow-up after
> the holidays. I apologize for that, and I really regret it because I
> liked where this was going.

I really regret to see you remembered it, actually.

>> 1) Newbie user clones/pulls a repository from somewhere. He hacks
>> around and then things go bad, and he decides to scratch away
>> everything he did to make sure things are like they're supposed to be.
>> He'd then type "git checkout --force --clean master". If he didn't
>> introduce new files, he would simply type "git checkout --force
>> master"
>
> I like this just fine.  I think we can explicitly say that HEAD is the
> implied default refspec, yes?  "git checkout --force --clean"

That depends on what the "hacks around" involved.  Where is he now,
what damage did he cause, and what can you depend on to take him to
a "clean" state, where the definition of "clean" happens to match
this hypothetical "Newbie user"?  Did he do "git checkout" of
another branch?  Did he commit?  Did he "reset" to other commit
while on the 'master' branch?  Is he still on "master" branch when
he says "git checkout --force --clean <master>"?  Can he say "git
checkout --force --clean master~4" and what does that even mean?  Is
he trying to go into the detached HEAD state, or is he somehow
trying to rewind master?
