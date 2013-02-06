From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 11:37:06 -0800
Message-ID: <7vwqulb5el.fsf@alter.siamese.dyndns.org>
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
 <CANgJU+VbkQ+xa+_sSAu-3pMe+6gycHi9J4VR18M5YJt=pa9QUw@mail.gmail.com>
 <87ip65guj8.fsf@lifelogs.com>
 <CANgJU+X=Bb=ncqOxsd1hZDWsnFkt-bJw=Zbtuz8_KC0gO-dLaQ@mail.gmail.com>
 <87bobxgtmw.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3AoH-0004RD-RV
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab3BFThL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:37:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226Ab3BFThJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:37:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2156BABD;
	Wed,  6 Feb 2013 14:37:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKs+stVXDOLuvG5di5eWCLmREFE=; b=n5Z4fF
	wT0m2IU2cS8el3xUCRGzesdM8LXQW/tBEmx5t2amLoGtYZ6GhwBuz/GIrrNAnJMk
	fTdv6p2WBV28ZZaggipCMdlhW7iZusybduhPwrkA3NB2b//98Q5eSeHWLuOnWR2f
	flbKqJsT3m0TQlme6C+tuQhbDrmj7hlLiJmAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fu0YUmbqxo84hW8+Svkv7etuLKk2ET4N
	GW1DiEuQSTtvxncHzWVYFIikpiV3dMgll8+pF8KA1sWbm5jYiNqzJ7154E/5j6jW
	OjIQL3pWHV72X7vuZG+M8qFWaRnK0Iwo4rzxarzfy0c8AV9N93LAZAMS+oJ2y72d
	n5G3xElR7wo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D607DBABC;
	Wed,  6 Feb 2013 14:37:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 581A1BAB9; Wed,  6 Feb 2013
 14:37:08 -0500 (EST)
In-Reply-To: <87bobxgtmw.fsf@lifelogs.com> (Ted Zlatanov's message of "Wed,
 06 Feb 2013 13:54:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98177FC4-7094-11E2-9587-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215625>

Ted Zlatanov <tzz@lifelogs.com> writes:

> "Make your code readable and sensible, and don't try to be clever."
>
> But this is good C and shell advice too,...

Sounds sensible.
