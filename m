From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document 'git bisect fix'.
Date: Wed, 16 Mar 2011 13:35:01 -0700
Message-ID: <7vmxku7qiy.fsf@alter.siamese.dyndns.org>
References: <20110311165802.GA3508@intel.com>
 <4D7A64670200007800035F4C@vpn.id2.novell.com>
 <AANLkTikG8wa1Em0bEUddbYpYs2TzFFTDb95qWFJ3xSbv@mail.gmail.com>
 <4D7DE39302000078000362E6@vpn.id2.novell.com>
 <20110314095534.GB18058@elte.hu>
 <20110314104131.GG6275@bubble.grove.modra.org>
 <20110314122342.GA26825@elte.hu> <20110314131623.119020@gmx.net>
 <20110314210001.GE4586@gmx.de>
 <AANLkTimAaL-C_oH9X3QFUc+JOaSi7xVe93KYJuL0VEyR@mail.gmail.com>
 <4D80A33B.8020006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxVG-00012l-PL
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab1CPUfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:35:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1CPUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:35:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49F774B2A;
	Wed, 16 Mar 2011 16:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NFGKOmzZwtqmyXfvupJjrdvyaWw=; b=SlS+RS
	e84hIFRgPvwkigxOvQtvZ3rUzPrMaDXiGi7Bn/NBfr2NzC8hI/ElT6E9zIZy1xMi
	yRV7KDMEFeZAfCdbVfz7QgSXc4CkaxZCYOAgfeJ2UNLohF6L8G0cX+JDSGyNnYAK
	HbHvutAQDexOYvqBn6obDnjzarvfxn+81ij8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tazey1+5Lvo/+g7XGGiJOjdXEFwLnA9F
	0QbZ9yL2z22JT0bGqtCwRuC7jz5wbSpW0gH0RqkZMEzdjPNNnU0ojGdegU2RuA2f
	rpYx8McJp0I3iygiW3DdpCHgsPAlMqqGBxXZ49uXLPyG9ww3SC4W5fil7w9II/0b
	WHmywF+i9dA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 845444B1C;
	Wed, 16 Mar 2011 16:36:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B70664B10; Wed, 16 Mar 2011
 16:36:36 -0400 (EDT)
In-Reply-To: <4D80A33B.8020006@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 16 Mar 2011 12:47:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EE971A6-500D-11E0-B4D6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169189>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Christian Couder venit, vidit, dixit 16.03.2011 10:52:
> ...
>> It's already possible to deal with this problem by creating a new
>> branch where the bug is fixed,...
>
> I'd say the replace method is perfect for transporting an existing fix
> "back in time" when the range of non-bisectable commits is limited. But
> since you have to replace the right (most recent) commit in that range
> it is less convenient when you have a fix due to a changed/exotic build
> environment or such which you do not want in your mainline.

I totally agree with Michael.  If somebody has _already_ used "replace" to
make an alternate history in which nobody made any mistake by masking each
and every bug fixed in the past, your bisect would be easier, but that is
nothing more than a theoretical daydreaming. Who in the right mind would
do that?

If you need fixes applied for unrelated bug to even trigger the bug you
are chasing, "replace" is not a practical option. You might even be the
first to notice that these "known fixes" mattered in the part of the
history you happen to be bisecting, and nobody sane would have prepared
such "replace" in the past just in case.

Treat "replace" as nothing more than a reimplementation of "grafts" done
right (i.e. can be transferred using the usual git transfer protocols); I
don't want to see its use advocated for applications it is not suited.  It
just confuses people.
