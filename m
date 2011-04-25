From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Let's make our cycles shorter
Date: Mon, 25 Apr 2011 10:03:35 -0700
Message-ID: <7v1v0ql0uw.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <7vvcyyhq9q.fsf@alter.siamese.dyndns.org>
 <BANLkTinzXLK0dHYjBMpBgLqZ_7KNHeu3uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:03:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEPCR-0002ey-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 19:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758652Ab1DYRDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 13:03:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab1DYRDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 13:03:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 649DF498C;
	Mon, 25 Apr 2011 13:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8c1Kw+Q+8Xkpq9EmdwC12yMhU5o=; b=WvwDk2
	k9EAi25Rq3nU1SyIxLIJUdIXJ5xN472pu8oWB6YpcYlnLSREy3XidaFD/nTP/lcD
	906MwzBYCP/kI1MPC+fKV90VGMjoO4crBD70d1wCLnQA1FXC1No7k8A94xbCV3Rd
	bZ9TNVL2lhfaYqzyWaAzIwsXownAC6742SryA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jb+9PKj5AewPKmrhHzKWAYKdLoCDFKoR
	Yr4FVswavpTM01i6LLIH5beCpl1/EFcz9uhbMz6f5/lvcYCSlGUqOeYt1TftlWbl
	BUFA7v8PHbNcqYOtbg5gt8O3v9YnDVfYOPFnb8PsWxdPUovrZ+jlF8Rz8k20sdN4
	z48FLM+WWGQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41AE6498B;
	Mon, 25 Apr 2011 13:05:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 45A534989; Mon, 25 Apr 2011
 13:05:39 -0400 (EDT)
In-Reply-To: <BANLkTinzXLK0dHYjBMpBgLqZ_7KNHeu3uA@mail.gmail.com> (Sebastien
 Douche's message of "Mon, 25 Apr 2011 02:34:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41283002-6F5E-11E0-9745-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172032>

Sebastien Douche <sdouche@gmail.com> writes:

> On Fri, Apr 1, 2011 at 00:35, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> I was surprised to not read response, it's having sensitive impact on
> the project.

Hmm, what sensitive impact on which project do you have in mind?

> Junio, it's effective now?

The structure of clean-up, development, freeze and then release has always
been in effect in this project, but historically the duration of the
development stretch varied a lot from cycle to cycle.

I just spelled the structure out for the next cycle, and tried to give
some predictable bounds to that elastic development stretch, in order to
force myself to stick to a schedule in which we can make measurable
progress in reasonable amount of time.

It does not mean that we won't be tackling issues that will take more than
N weeks to perfect.  Either a topic gets polished enough in a single cycle
to graduate to 'master' before -rc0, or it keeps cooking in 'next' during
the feature freeze, and will attempt to be in the release after that.

I've tentatively set the following dates on my calendar, based on 9-week
cycle:

 - Today is the beginning of week #1 for this cycle.

 - The entire month of May 2011 will be the development stretch (lasting
   up to Week #5 that ends May 29th).

 - Aim to tag 1.7.6-rc0 on June 1st, 2011, -rc1 on 8th, -rc2 on 15th.

 - Either tag 1.7.6 final on 19th or have -rc3 on 22nd and final on 26th
   of June.

If you happen to use Google Calendar, you can paste:

    jfgbl2mrlipp4pb6ieih0qr3so@group.calendar.google.com

in the "Other calendars" box (where a gray "Add a friend's calendar"
appears), but you won't be missing much even if you don't (I only have
week numbers and the target tagging dates, nothing more interesting than
that).
