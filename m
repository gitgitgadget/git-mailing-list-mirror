From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Thu, 17 Oct 2013 13:40:40 -0700
Message-ID: <xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>
	<525FB287.7020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 22:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWuNF-0002LB-1n
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 22:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762505Ab3JQUkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 16:40:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757861Ab3JQUko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 16:40:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C294B0E0;
	Thu, 17 Oct 2013 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n7Q7hjKEz0OrHVy8aKf9E9MnbCg=; b=P4RS1k
	35lCYShODHn+C9QnqZiygtAnYwqgZS2oEKRUmHqs0miD7YyKxN5gXciV54sAw/Ch
	r8NfNfQqF9Nmf9gcdcPyL7JfLHZ9K2jqc9hS48ZwHO1rhuO7D9G+9Ousi+zMTnKp
	jynL/E3VCmfD7OYabLnuiIFKL0ZNyJJ0HjN/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQMihf7dfw+P4xncKibhcj0C2RegfVkr
	MX3eAWYieGZ4aK2BJgD5xg/j93hT3YcJAQnElP4lwd0TBTaZsScA2+FHiZO42dWL
	kfcneeXs5hMQBCQTbKm6UX0vG0lyUI6WwwmQCY6q8bLTERLBROTQ5qwPhannKBwx
	GfvtLeho3qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A54A34B0DF;
	Thu, 17 Oct 2013 20:40:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 163DB4B0DA;
	Thu, 17 Oct 2013 20:40:43 +0000 (UTC)
In-Reply-To: <525FB287.7020204@gmail.com> (Karsten Blees's message of "Thu, 17
	Oct 2013 11:48:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 645BF008-376C-11E3-B44D-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236317>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 16.10.2013 23:43, schrieb Junio C Hamano:
>> * kb/fast-hashmap (2013-09-25) 6 commits
>>  - fixup! diffcore-rename.c: simplify finding exact renames
>>  - diffcore-rename.c: use new hash map implementation
>>  - diffcore-rename.c: simplify finding exact renames
>>  - diffcore-rename.c: move code around to prepare for the next patch
>>  - buitin/describe.c: use new hash map implementation
>>  - add a hashtable implementation that supports O(1) removal
>> 
>
> I posted a much more complete v3 [1], but somehow missed Jonathan's fixup! commit.

Thanks; I'll replace the above with v3 and squash the fix-up in.
