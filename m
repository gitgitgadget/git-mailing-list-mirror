From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 15 Jan 2010 15:50:11 -0800
Message-ID: <7vska7rkr0.fsf@alter.siamese.dyndns.org>
References: <20100113232908.GA3299@machine.or.cz>
 <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net>
 <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net>
 <4B50F7DB.7020204@eaglescrag.net>
 <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog19@eaglescrag.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvwG-0008VZ-5K
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693Ab0AOXuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758646Ab0AOXu3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:50:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758445Ab0AOXuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:50:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD81E91A07;
	Fri, 15 Jan 2010 18:50:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHhEuS9u56/sLZtEjHLhjl2sCaw=; b=stmffq
	IewqhxgkGQdWL07TgmyuD5/kUgiNtyi/AXowPdZUMW4CtsLGhXkCHnWDR9rI9prE
	KPQmPcz2LlePQLj2U8L6wtn/9oRtSdmCFYtaa+4RGOIqZWxq920UiW9S3gmXXf7V
	4w+2ztD075TQbTZ4a5Mto4x5z/kYUlDd/R11Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEQ7RnUCa2AQCJdb5YZlGa1QJqviEuxT
	3+IXroAmQqtsEWlKgp+mc+vEHRkvH3qzwSBddyDHf1nZNNFnis9/E/I0fxOhjxPL
	lvzYlOIgXZm8Hebx/qovQ7xZBGGPb3mqhIMrbeozXTqiX6KWLw5rOPrTx2SjA8Dj
	aPbxvfGn6M4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5018991A05;
	Fri, 15 Jan 2010 18:50:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C920919FD; Fri, 15 Jan
 2010 18:50:13 -0500 (EST)
In-Reply-To: <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 16 Jan 2010 00\:21\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCBE7984-0230-11DF-B26F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137164>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Jan 16, 2010 at 00:18, J.H. <warthog19@eaglescrag.net> wrote:
>> Quick update - I think I've got the vast majority of the obvious and
>> simple to correct problems fixed at http://git.wiki.kernel.org anyone
>> want to run through and see if there's anything else that would be
>> considered a show stopper?
>
> I'd say it's pretty embarassing if our FAQ [0] is broken.

Many "<<GitLink(foobar}}" in the FAQ page do seem like result of
mechanical misconversion.

John, thanks for doing this.  If people fix things up manually, can they
expect their fixes will be kept from now on, iow, the changes will not be
overwritten by "Ok, I found a much better mechanical conversion tool and
updated with the latest snapshot from the original wiki" in the future?
