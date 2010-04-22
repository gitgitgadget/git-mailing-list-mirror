From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Thu, 22 Apr 2010 14:15:32 -0700
Message-ID: <7vwrvz2npn.fsf@alter.siamese.dyndns.org>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004191243.24209.jnareb@gmail.com> <20100419115113.GC3563@machine.or.cz>
 <201004202014.19477.jnareb@gmail.com>
 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
 <20100422202501.GJ10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:16:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53km-0005yH-7k
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758832Ab0DVVP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 17:15:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816Ab0DVVPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 17:15:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07FB4AC6E5;
	Thu, 22 Apr 2010 17:15:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eFM2TuqUk16Gs3jviMu+7AqGW/I=; b=pPM8U7
	vZ15GhK4fsLiA4WwM8BMcLvLdds98DCnhlzTh9hVRI+ratwoR5wGWQpntGRrKOhg
	arDVr/xKX0GdrmC/rvfG3ZpTq8OvhsJZYjUo5MLxmmLOyb5Fg77+7S9t/i3AmHeo
	1CAE5HJ3lutamP53hKlgqJU5n8vMwmRYd52sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SPdzw4E+je3gEi6KjWlmjM1s65J+hLR/
	5I/97HxjQmLSPZqkIxXxk6wXj3A0wFafgswiVVefoUqpq8uaIzrHoiwg11ZwH/3u
	e6v1w39RwM3Q/wZ8VHceigjDngnN3ui/n9i0TRJl5l0x0Njsbpmk+l6ihpXzDJaA
	AdiIfT+GkWw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CBEAC6DF;
	Thu, 22 Apr 2010 17:15:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2AFAC6CA; Thu, 22 Apr
 2010 17:15:33 -0400 (EDT)
In-Reply-To: <20100422202501.GJ10939@machine.or.cz> (Petr Baudis's message of
 "Thu\, 22 Apr 2010 22\:25\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36847FD8-4E54-11DF-9F93-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145564>

Petr Baudis <pasky@suse.cz> writes:

>> d) Usage of the client:
>> 
>> This client can be used in 2 ways.
>> 
>> * Install a local version using instaweb - The gitweb will be only
>> accessible by you. You can browse through the git repository using
>> read modules and simultaneously work on them using write modules.
>> * Install on intranet - A company when installs this gitweb along with
>> some other login and account managing scripts will be able to order
>> their employees to login and ask them to work on the code with out the
>> security risk of providing ssh access to the git repository host. The
>> authentication support can be implemented as an optional part of my
>> proposal.
>> * Install on web - Just like normal gitweb, or enable write modules to
>> look like gist.github.com
>
> Note that for the latter two, operation mode without working copy is
> essential; I have not seen you address it anywhere.

What do you mean by "without working copy"?  Is the proposal about having
a working copy _per_ client on the server side, and the file editor and
goodies listed in the "Wrote modules" list operate on these files?

Perhaps you meant to say "without working copy on the client side", and if
that is the case I think we are on the same wavelength.  That is exactly
why I earlier said that I imagine that the "Gitweb client write support"
would be based on something more standard like DeltaV, instead of rolling
a custom hack that is not compatible with anybody else.
