From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Wed, 03 Oct 2012 12:03:04 -0700
Message-ID: <7vhaqb4bvb.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
 <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
 <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com>
 <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com>
 <CABURp0rho3KvzHRNXj9EA9C2OnbTc_dcmiBiW6JZ-VHu4g2m0Q@mail.gmail.com>
 <7v391v5rgb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIK-0001DP-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab2JCTDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:03:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab2JCTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:03:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D113797E8;
	Wed,  3 Oct 2012 15:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2/rqZsT2JzcpuowNawePV0FA104=; b=Ce/ZJY
	fJu/oerapN/iVwelh9LeBlT+SYPj74bK4DlppaNCjYO8fQ4rv7odpYbCOmJ6fpzs
	/9yt/XXXXeQ8R0tTWNzxaAiNyTGBx/7QcS2n/FAiUh1ClWA19/HV/Vd43Cpblrjf
	XUTDlqOqPo4TPlU4sIE3IiRE5XVIoyh2q6ZIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oC3ugWyhf/D6f9JGJ2fqsTiFx8GmvbPt
	LZnuQNaxfKBq4rL17Yakvuf9gIvIbRKouTO5QuxZFqMsprTOvn7qkKnsss+pzUCg
	FqhB/WLrLKmUODnQp10jS27lcsW4GfVeGElL5mRzFuelNMxvQRvH1sDZPdXUlwTC
	vUCe7kM/EPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF8EB97E7;
	Wed,  3 Oct 2012 15:03:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C8E597E4; Wed,  3 Oct 2012
 15:03:06 -0400 (EDT)
In-Reply-To: <7v391v5rgb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Oct 2012 11:41:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6C56C0E-0D8C-11E2-89DE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206924>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> I flagged this for followup in my MUA, but I failed to follow-up after
>> the holidays. I apologize for that, and I really regret it because I
>> liked where this was going.
>
> I really regret to see you remembered it, actually.

Having said that, I am glad that you brought the old discussion
thread to our attention.  In

    http://thread.gmane.org/gmane.comp.version-control.git/185825/focus=185863,

I said that "git reset --keep" started out as an ugly workaround for
the lack of "git checkout -B $current_branch".  Now we have it, so
we can afford to make "reset --keep" less prominently advertised in
our tool set.  As I already said back then, "reset --soft" also has
outlived its usefulness when "commit --amend" came, so that leaves
only these modes of "reset":

        reset --hard [$commit]
	reset [$commit]
        reset --merge

I am not sure if it makes sense to give a commit different from HEAD
to "reset --merge", and to a lessor degree, "reset --mixed" to flip
the HEAD to another commit while retaining the working tree contents
does not make much sense, either, in a common workflow.

It _might_ be possible to merge the --mixed and --merge if we think
things through to reduce the often-used options even further, but I
haven't done so, and I suspect nobody has (yet).
