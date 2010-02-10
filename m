From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
 line count
Date: Wed, 10 Feb 2010 11:47:28 -0800
Message-ID: <7v8wb098kv.fsf@alter.siamese.dyndns.org>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
 <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
 <7vwrykapfp.fsf@alter.siamese.dyndns.org>
 <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIXI-0006C5-7v
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab0BJTrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 14:47:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab0BJTrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 14:47:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB2A98FCB;
	Wed, 10 Feb 2010 14:47:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WHv+wrFYRYz0f0dJ+NZ9OgXMWiU=; b=a4GKOg
	JsJjh45UFQUhJEl/JULL04Xpmy7R475Ru9MnNwo/iSJgwXg1V/fKi5Qdx0YNBjS8
	lRHsNw2jKAyVuKdOpD+1OO/hsmLjFDemjwQOTuSb48P9gx+q7HPAM34SJQGZQEqB
	LOMTK0eBK4k11iCpYSk0Tt+dr9YhJdOGkhomU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vw7jyTKGOxH2qc5CuLdHMHCatEOHExIm
	vrK0LnCUjgUwewe0JzyrTiLKoQ4FLCbyD+fW07YJImObYzHM+VvuViLS8WdTJQ+D
	sDon2aRHPv04NqutVvMWoHY7rsaDWhFmINmy+mp1TGxpmeRvQ4Ej2aAt6RJifTU7
	taamd6xbGus=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83C7298FC4;
	Wed, 10 Feb 2010 14:47:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8CFC98FBF; Wed, 10 Feb
 2010 14:47:29 -0500 (EST)
In-Reply-To: <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 10 Feb 2010 14\:39\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2235363A-167D-11DF-B34C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139539>

Jay Soffian <jaysoffian@gmail.com> writes:

>> As to use of more than one -L option, especially when the start (or end
>> for that matter) is specified with an regexp, I am of two minds.
>
> Actually, I was not planning on supporting multiple -L options, but rather...

That is extremely sad.
