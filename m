From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Wed, 14 Mar 2012 13:34:39 -0700
Message-ID: <7vaa3iq5uo.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <4F5EF6EC.20008@viscovery.net> <7v4ntswe54.fsf@alter.siamese.dyndns.org>
 <4F603CA9.70906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 21:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7uuF-00026H-RL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 21:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab2CNUen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 16:34:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab2CNUel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 16:34:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F17A57AE5;
	Wed, 14 Mar 2012 16:34:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9P0JH3Y3w0NgxmeUgJXaM9a82vU=; b=tQEcfP
	RQCPznB+qISfk8kA0RswGjB4pjvgz3BWdqr598G161eu1maQlWPLzlrNLnkgU6pK
	4qKAy2MF8d4hF7IR1cO48FLdrjIODrNS3biEh9gqXQ4tklPrtCaASBKBZsCAYlkP
	NcRSRqP3vMlKhH782QWzgMuSijTRyc30C7Ot0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZJf5GUI7nD6TNwGuX5qNBAc2Yth/WI+
	fZgTY5IOInyo+tTtTwpz6tdiOiX83d01jpQTelnCxMpuLERp5f9adVoWtgiAD2qi
	0EagnaEycEUkkRGy1RcWj7+1SqHbiS/jbvcMKR0BnFcTfpbMZ8l3FKSPtXlV6FRH
	kGHtYLbfutc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E85EF7AE4;
	Wed, 14 Mar 2012 16:34:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C3847AE3; Wed, 14 Mar 2012
 16:34:40 -0400 (EDT)
In-Reply-To: <4F603CA9.70906@viscovery.net> (Johannes Sixt's message of "Wed,
 14 Mar 2012 07:37:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FD47896-6E15-11E1-94E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193159>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/13/2012 19:26, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> I can buy that.
>> 
>> Assuming "that" refers to my "hold ... for several weeks", let me stop
>> reading right here.  We can talk about the rest of your message in several
>> weeks.
>
> No, "that" refers to "make loud noises (including "we will never get used
> to this updated output, it is horrible!"), and then eventually get used to
> it as if nothing happened". Nevertheless,...

I understand that.  But ask yourself honestly and tell me (in several
weeks) why you do not think that your "would like to opt-out" part falls
into exactly the same "loud noises immediately after seeing a change"
category.
