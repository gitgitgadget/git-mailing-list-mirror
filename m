From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
 non-copies
Date: Mon, 03 May 2010 18:34:08 -0700
Message-ID: <7v8w80sb5b.fsf@alter.siamese.dyndns.org>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
 <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
 <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
 <m2i36ca99e91005031555x4bb2df54yb47058d9f7d5342c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 04 03:37:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O974L-0004zV-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 03:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab0EDBeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 21:34:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0EDBeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 21:34:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D1BB0B1F;
	Mon,  3 May 2010 21:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oYQlEy76/pZ4PuTp/jIcbPS8QPg=; b=Lvi+Px
	MQaRJEDO6lgr0C0Fet2HwBs+sXCMQjrEcoY0a9Tj+FC2z4ZLnwrnuRQPi+w6yNri
	Ax3g5icWezMoKD+3ZrE6Nsnnj0yAj+XHGC1SmRgH1eSlq6z3byo1HN2kZXbwWU8a
	BWMTSC77S0IWzsD2g+I+3UBDP9ZBYxTglk5mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqPdJcSi4SbTofZJY3rYWZhuuJ34LKZH
	fxDlCLr2lmMp2jPjyBxaSGLfo6t9AlS6iD79cDsANCW/6h+8f2JHFXoKowOI+vU3
	snskFTYg7F/sR93qDe/Vn3pxCfj9DnHkOV6RAE0sbgWvOnCGtJs2GO8H5s/lgrH4
	a7rILU7On0E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 898C3B0B1E;
	Mon,  3 May 2010 21:34:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6FE4B0B1A; Mon,  3 May
 2010 21:34:09 -0400 (EDT)
In-Reply-To: <m2i36ca99e91005031555x4bb2df54yb47058d9f7d5342c@mail.gmail.com>
 (Bert Wesarg's message of "Tue\, 4 May 2010 00\:55\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25438EA4-571D-11DF-A291-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146277>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> ... do you have any other
> thoughts on adding a <path> extended header for non-renames and
> non-copies?

Other than "Why do we even need it?", no.  We actually have been careful
when designing the output format to make sure that necessary information
appears.

See also this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/3990/focus=4002

I wasn't too opposed to having a separate "Index: " line (or Anton's
"name") like CVS does, but the conclusion of the thread was that it is not
necessary.
