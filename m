From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 10:14:16 -0800
Message-ID: <7vip65cnt3.fsf@alter.siamese.dyndns.org>
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
 <CANgJU+V5bhdpN_kWxQPEJgx24LXLtQJWRbnHwkSgm9zFwzm+fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39W6-0001Im-4R
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab3BFSOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:14:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab3BFSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:14:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F50B738;
	Wed,  6 Feb 2013 13:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdQ/mAmiP53XlUq9tGw0642GuIw=; b=Jniuha
	fHIUKuD5JtnDsTqD48ds6SohHi00HXRX3wYn+aHuYb0rOIarhqvC4GXPc6QByqnE
	F9QO9yznNVGCerj+gGvh0zrWtLKrsPSepjZET9LFCDzPgKOS7ravlYWBD05B+NA/
	K4Gpfjgtz+MNeXKl4eTnUA89M99VB2PHjg6Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhq5Lxyn8Aj9F2g+s/DuN+6LWup/Jt8O
	faG4pnd6cKmunQf2g3VDCBR6iCUWP3lz5zUssnGPODVFzFNLTuvIUhMW/wGhobYW
	WTgcCKiJobcRdVIMMZCzPjFtdEsBtj89q3al/OHP9SxknAwU5LGbRVD5eh5SLamy
	KcURNCRb1gE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4CCB737;
	Wed,  6 Feb 2013 13:14:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C671B733; Wed,  6 Feb 2013
 13:14:17 -0500 (EST)
In-Reply-To: <CANgJU+V5bhdpN_kWxQPEJgx24LXLtQJWRbnHwkSgm9zFwzm+fA@mail.gmail.com>
 (demerphq@gmail.com's message of "Wed, 6 Feb 2013 18:45:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 054FDE44-7089-11E2-B0BC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215612>

demerphq <demerphq@gmail.com> writes:

> As you mention below statement modifiers have their place. For instance
>
>   next if $whatever;
>
> Is considered preferable to
>
> if ($whatever) {
>   next;
> }
>
> Similarly
>
> open my $fh, ">", $filename
>    or die "Failed to open '$filename': $!";
>
> Is considered preferable by most Perl programmers to:
>
> my $fh;
> if ( not open $fh, ">", $filename ) {
>   die "Failed to open '$filename': $!";
> }

Yeah, and that is for the same reason.  When you are trying to get a
birds-eye view of the codeflow, the former makes it clear that "we
do something, and then we open, and then we ...", without letting
the error handling (which also is rare case) distract us.

> "unless" often leads to maintenance errors as the expression gets more
> complicated over time,...

That might also be true, but my comment was not an endorsement for
(or suggestion against) use of unless.  I was commenting on
statement modifiers, which some people tend to overuse (or abuse)
and make the resulting code harder to follow.
