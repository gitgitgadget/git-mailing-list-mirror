From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 10:16:21 -0800
Message-ID: <7vehgtcnpm.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87sj5cvxnf.fsf_-_@lifelogs.com> <7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
 <87k3qoudxp.fsf@lifelogs.com> <7vvca7291z.fsf@alter.siamese.dyndns.org>
 <87lib3uats.fsf@lifelogs.com> <7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
 <871ucto4vj.fsf_-_@lifelogs.com> <7vvca5mmmt.fsf@alter.siamese.dyndns.org>
 <87vca5gvx6.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39Y7-000346-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab3BFSQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:16:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059Ab3BFSQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:16:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AABB857;
	Wed,  6 Feb 2013 13:16:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CeUCyziRf5nDAc/Dz+HkJ8swnqM=; b=cvlb2h
	WgGdWagS+02hoLA/aMT5VX8c2/J/YsK+G6HpBcd5GhkPaJzbHWpJDx9zRnupueMu
	w8/8nxJGEtUc/RQQ2UvMWPqyPf8mV5WPun/YRl69/B6VhyyjhxuVH8yDkCjPtfRa
	j+WY4gZOZ3F/SjpSWF7fnhljO/QH+AX6UjG80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ttf0Wm1YdzaqxNgsiha8Nv5tyehFAoao
	w5Pwrylue2fXc52QCCNfdnyw5O3eFG/BWA/XPuGyqs4fxJjQgUbRLlYKN4VUdR1a
	U5gvGv1XMWK3PjZS11RTTuVKwxhDv5gF9PC6C8wZcpeMORL9c7Wq9nYSTaFrvOmy
	k5OV6b1KI9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49C2B856;
	Wed,  6 Feb 2013 13:16:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4341AB855; Wed,  6 Feb 2013
 13:16:23 -0500 (EST)
In-Reply-To: <87vca5gvx6.fsf@lifelogs.com> (Ted Zlatanov's message of "Wed,
 06 Feb 2013 13:05:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 503232FE-7089-11E2-ADB2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215613>

Ted Zlatanov <tzz@lifelogs.com> writes:

> On Wed, 06 Feb 2013 08:29:30 -0800 Junio C Hamano <gitster@pobox.com> wrote: 
>
> JCH> Is it ever (as opposed to "not always") possible to omit braces?
>
> Oh yes!  Not that I recommend it, and I'm not even going to touch on
> Perl Golf :)
>
> JCH> It sounds as if we encourage the use of statement modifiers, which
> JCH> certainly is not what I want to see.
>
> Yup.  I think I captured that in the patch, but please feel free to
> revise it after applying or throw it back to me.

I'd suggest to just drop that "try to write without braces" entirely.

> JCH> Incidentally, your sentence is a good example of where use of
> JCH> statement modifiers is appropriate: $youmust is rarely true.
>
> I was trying to be funny, honestly.  But OK; reworded.

It wasn't a useful guidance, but it _was_ funny.  
