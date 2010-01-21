From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #06; Wed, 20)
Date: Wed, 20 Jan 2010 20:06:32 -0800
Message-ID: <7vvdeww187.fsf@alter.siamese.dyndns.org>
References: <7vljfsxos5.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001201706i4c7ffaecs55153c9220bc5992@mail.gmail.com>
 <201001210240.10522.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXoK5-00010L-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 05:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab0AUEGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 23:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499Ab0AUEGo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 23:06:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0AUEGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 23:06:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3298E92BBA;
	Wed, 20 Jan 2010 23:06:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zyJw5cHJWj7b0basP86ZllAFEsA=; b=i+T0zr
	pxek/LyYoXzdcUL7kqZNQq412bj+Y8oRukwfbJeACZK8SH8UGSZsuxr7vk8jnIDe
	WS9qQUrtT7prNAdFWYraybVtvNMpHSzUk5N8WQmToTPIIyeGbp69ICrwSJtNpRC9
	RJJt1DscUt62omOCiEOTVtKuQjR7QN0N3YjAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o5OdyRtrv+CwT18+rV/bHULvKjlvagfy
	i90KwmTW17Wf6+bCQ+diCZNY5MewwDxcDBDf1bS106AmiWvrcvPrV7eOqAUAHXm2
	mrwNVz2QPLCaGH8CYMlYMWm2oTbd5qUrhwrqectm/lUEewzlCUcY9ISD6pyNytzT
	lKBOgoxOGZE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F162B92BB8;
	Wed, 20 Jan 2010 23:06:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC2992BB6; Wed, 20 Jan
 2010 23:06:34 -0500 (EST)
In-Reply-To: <201001210240.10522.johan@herland.net> (Johan Herland's message
 of "Thu\, 21 Jan 2010 02\:40\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F38080A-0642-11DF-94C8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137627>

Johan Herland <johan@herland.net> writes:

> On Thursday 21 January 2010, Sverre Rabbelier wrote:
>> On Thu, Jan 21, 2010 at 01:52, Junio C Hamano <gitster@pobox.com> wrote:
>> > * jh/notes (2010-01-17) 23 commits
>> > [...]
>> > Updated with a re-roll.
>> 
>> Just checking, you reverted all from next (with exception of the first
>> three), and now re-queued it to pu, with the first three still in
>> next? Or did I mis-remember and did only the first three make it to
>> next in the first place?
>
> You misremembered. Only the three first were merged to 'next'. Junio was 
> about to merge the rest, but I asked him to hold until I had produced the 
> current iteration.

I've been meaning to merge the first three to 'master', as many people
have been running 'next' and new features tend to be exercised less by
those on 'master' than on 'next', and it would be beneficial to make
'master' at 1.7.0-rc0 as close to what we have had in 'next' for a long
time.

Worries?
