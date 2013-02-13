From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jn/shell-disable-interactive (Re: What's cooking in git.git (Feb
 2013, #05; Tue, 12))
Date: Tue, 12 Feb 2013 16:15:33 -0800
Message-ID: <7v1ucldq6y.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <20130213001213.GA15246@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:16:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Q12-0005G1-EF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab3BMAPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:15:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab3BMAPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:15:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3333B121;
	Tue, 12 Feb 2013 19:15:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DOx3PkIubEX+DvB94b1k0ZMztA4=; b=W7NSPz
	LgApoAwmLR2mH+02Jf9/jRT20QNsK8NQmPJ+NnwWqNoqBfU1CUzrw2aK2chQET2a
	kBnVmzCDskgc3NHrskDZH/FwXbD4qkATbWROJYhCp1+dRwRNSelc4wMPOyZPPQRo
	FnvnXjUTkUSR1d2XwbrGyQ43kV8XdJ1wua2b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOL/vLLPGkxCdGwbpWZpdLaWZFnZfLXE
	PAhqfRSTjY3CbhAInscJCDLKGJiNAe5X+8Be1u1KEcy/gn/hV80htZZobBIwuTHx
	d0Miz2SeJDbHA5fbcKG2Ta8/YtQOluFElsCw8ztS/gzhfTvgtUoNvIvC89Pr5f+l
	fKuGtZe9oH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88C6B120;
	Tue, 12 Feb 2013 19:15:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 360C4B11F; Tue, 12 Feb 2013
 19:15:35 -0500 (EST)
In-Reply-To: <20130213001213.GA15246@google.com> (Jonathan Nieder's message
 of "Tue, 12 Feb 2013 16:12:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CA29C14-7572-11E2-8123-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216230>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> * jn/shell-disable-interactive (2013-02-11) 2 commits
>>  - shell: pay attention to exit status from 'help' command
>>  - shell doc: emphasize purpose and security model
>>
>>  Will merge to 'next'.
>
> Please hold off on merging the second patch.  I'd like to reroll
> renaming the command to 'no-interactive-login' or some such, which
> would be less disruptive to existing setups and should be easier to
> explain.

Thanks; that sounds like a sensible and safer change.
