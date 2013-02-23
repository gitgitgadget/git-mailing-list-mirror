From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggested improvements to the git-p4 documentation
 (branch-related)
Date: Fri, 22 Feb 2013 16:42:16 -0800
Message-ID: <7va9qvc13r.fsf@alter.siamese.dyndns.org>
References: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
 <20130105212517.GA30315@padd.com>
 <CAFXk4bp0MBNxOD7w1zn7peN-ufWmV=DthMdHmjmj+Sci4MGneg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>, Olivier Delalleau <shish@keba.be>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U93CP-0006ZS-8D
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 01:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758784Ab3BWAmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 19:42:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758025Ab3BWAmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 19:42:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59888B5E0;
	Fri, 22 Feb 2013 19:42:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RDT4L2C1yXmMAUh3EAHW7d9k+yQ=; b=peUP4g
	0MBCdAwYDhW0a7WudTOcb0yOpvDA0Gw4kRWpJt5WziNGCzyS3thiBmiXenLU6JJB
	r7O/KLTV2hdC2oFgoheHgJFKAIxmMNuP74mEY0Ctv9mjlVvQhs4wHhmCinLJgvqr
	OKCyg6KKcrUzxn4lYSaL0rWaAG0BawObxhUp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dk1BIMpG262TOq+mZZuK9Y5/Eeoi8GT/
	NZqU1QcKLR1lYqeWxQJMOFtOOMXfU5Yib2N+6nr3a+9IFOLJ2SZ7DTNFKe03UIoD
	DDOuk9XnWca/fDGOp2CW8Ddcx+9buWZdSThjpx6l02SmrXIDJq63vPW1lVlbzcO0
	yZKDu0sprAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E285B5DE;
	Fri, 22 Feb 2013 19:42:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFA08B5DC; Fri, 22 Feb 2013
 19:42:17 -0500 (EST)
In-Reply-To: <CAFXk4bp0MBNxOD7w1zn7peN-ufWmV=DthMdHmjmj+Sci4MGneg@mail.gmail.com> (Olivier
 Delalleau's message of "Sun, 6 Jan 2013 21:00:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFEDF64C-7D51-11E2-83DE-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216886>

Olivier Delalleau <shish@keba.be> writes:

> 2013/1/5 Pete Wyckoff <pw@padd.com>:
>> shish@keba.be wrote on Thu, 03 Jan 2013 15:58 -0500:
> ...
>> Please do feel welcome to to rearrange or expand the
>> documentation so it makes more sense, if you are so inspired.
>
> I'm afraid I'm not familiar enough with git documentation to dig into
> it myself, but anyway that's about what I had for now. I'll send more
> comments to the mailing list if I have more suggestions in the future.
>
> Thanks for a great tool! :)

Did anything come out of this thread?  If neither of you two are
inclined to conclude the discussion with a final patch, I'd
appreciate anybody else who does the honors ;-)

We'll be in deep pre-release freeze for a few weeks, so there is no
need to rush.

Thanks.
