From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git rebase --onto
Date: Wed, 03 Feb 2010 17:12:41 -0800
Message-ID: <7vhbpx3it2.fsf@alter.siamese.dyndns.org>
References: <4B6865A9.60603@obry.net>
 <7v636f7biw.fsf@alter.siamese.dyndns.org> <4B686CAC.7020103@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Thu Feb 04 02:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqH9-0005Qs-UP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab0BDBMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:12:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab0BDBMu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:12:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DD9997B90;
	Wed,  3 Feb 2010 20:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bxsp6I8Yhvsciul2sroA17EjchU=; b=EpqHQj
	LYzY3jMP12ogOaNei5nI4tX4dITPQWBS9nYvbCBp6Vh5UtujWRJvuH4Engf8UIry
	ln9JhN/ztLBY+5REhyjJDCxiCsg/9JFJIx+HPfhjDmLAAM4LLR1H8uZTNEytkeIP
	GOhXSKlJNFEXSoiqMbkCgjWf6LrxqwPUI1l9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JaFuI+okDh0s/fha6ttwRb0VRT9KzH5j
	T5zkzuLQRSL3DKv/QDbavqGgLW3yGaYErY6Tbv0UJJ2DDDWpNuau/CogyhBQ1qSZ
	izQ9tHDPcODK1O9gc0yqPIHwCC2xsllpb7EQnvhEQ7sG9J4YS+Co3H9UDzZYF7eK
	UfHLJBVsPXU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C6797B8F;
	Wed,  3 Feb 2010 20:12:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7630397B8D; Wed,  3 Feb
 2010 20:12:43 -0500 (EST)
In-Reply-To: <4B686CAC.7020103@obry.net> (Pascal Obry's message of "Tue\, 02
 Feb 2010 19\:19\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 671D7AE4-112A-11DF-ABDD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138923>

Pascal Obry <pascal@obry.net> writes:

>> Possible user errors I can think of are:
>> ...
> I'm not on this case.
> ...
> I'm not in this case either.

Thenk there are some _other_ differences between your situation and what I
can construct from your problem description:

    It seems to me that:

       $ git co topic
       $ git rebase --onto master topic~2 topic

    Used to do the job and rebase the topic branch as expected....

which I tried myself before giving you a reply, and I didn't end up on a
detached HEAD.  But I cannot guess what that difference you are not
telling us is (and you probably don't know it either, I suspect).

Writing reproducible test case would be a great way to diagnose this.
