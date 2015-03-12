From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 21:53:22 -0700
Message-ID: <xmqqbnjy4y0t.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
	<xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
	<CACsJy8D38Lx5zvpOGPvnYVNXh4EYbF+rLL8kwb9pwP7EqCqfxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 05:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVv7o-0005E6-A9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 05:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbbCLExb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 00:53:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752056AbbCLExa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 00:53:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB19409FE;
	Thu, 12 Mar 2015 00:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R2dCDYlW6tVpIM0FT9GwL2rGh4s=; b=DuP4c2
	w2q0uqArMzr0Xd9dzShhhUZsfaNhQp6/1LWioRMiq9fBGBCxRAYTcce06nK9AO63
	aUFDXV6VcvGhpOCTjL2UCNg0K0md0dwbLmXRlMZSHfWqd4b9i3r1zOA09thzdd4j
	j1kiefb8NN/mgknqjzt6DjaGOFC3z+r9DY0tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RWEkYFW4t/lbZznEef3DK9cEx6QMjNma
	YCHjQJuSR6V9s3fEekPch3hxaaM1mqtwYlFloCjlqINc4//RTwtf2GJ69fugojUx
	L3l3i0n9gXWYUk/4LvMH9cmT+4ozdui7bQB0HscpElltNVCOcaDfAs8yj36QRbv3
	E4wTWi9uUSo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7237409FD;
	Thu, 12 Mar 2015 00:53:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E0BE409FB;
	Thu, 12 Mar 2015 00:53:23 -0400 (EDT)
In-Reply-To: <CACsJy8D38Lx5zvpOGPvnYVNXh4EYbF+rLL8kwb9pwP7EqCqfxQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 12 Mar 2015 09:15:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B659CA58-C873-11E4-9BB4-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265352>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 11, 2015 at 11:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> ... We may want to acknowledge review efforts as well, by
>>> grepping Helped-by:, Reviewed-by:...
>>
>> Agreed. Something along the lines of
>>
>>     $ git shortlog --no-merges -s -n -t Helped-by -t Reviewed-by v2.3.0..
>
> A quick grep/uniq/sort gives this
>
>    1512     Acked-by
>     537     Reviewed-by
>     389     Reported-by
>     317     Helped-by
>     147     Tested-by
>     143     Suggested-by
>      97     Noticed-by
>      78     Improved-by
>      49     Thanks-to
>      40     Mentored-by
>      23     Requested-by
>      21     Acked-By
>      20     Inspired-by
>      18     Based-on-patch-by
>       9     Explained-by
>       9     Contributions-by
>
> It looks like people are quite creative. I think all these "*-by" (so
> -t supports wildcards) and Thanks-to: could be also considered as
> contribution.

I'd first suggest to employ "icase" to unify *-By and *-by.  Perhaps
we would want a recommended list somewhere in SubmittingPatches to
discourage people from getting too creative?

"Acked" and "Reviewed" would be part of the normal review process.

"Reported", "Requested", "Noticed", "Suggested", "Inspired", and
"Based-on-patch-by" are about where the motivation to make the
change came from.  They try to express modes of communication and
degree of involvement of the named person in the process of
germinating an idea, and the nature of the change (is it a bug or is
it an improvement?), but I wonder if we can standardize these into
just a few (or just one) by shedding the various nuances.  If the
difference these various phrases try to convey is so important, it
probably deserves to be in the log message proper (e.g. instead of
"Inspired-by", say "In his blog at $URL, ... expressed frustration
in doing ...; this will solve that issue in such and such way" in
the log, and use the standard trailer that designates where the idea
came from).

People named by these trailers are the ones that connect us to end
users by noticing and relaying their pain points, and by working
with us to improve Git.  We would want to credit them no less than
we do an author of a casual "here is a typofix in a comment" patch.

And everything else above looks "Helped-by" to me.  Again, the
different phrases try to convey what kind of help in polishing the
change was, but if that is worth expressing, it probably belongs to
the log message itself (e.g. instead of "Explained-by", say "The
above explanation was given by ... in $gmane/1369525" in the log
message and use "Helped-by").
