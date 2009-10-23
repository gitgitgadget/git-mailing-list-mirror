From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 13:05:55 -0700
Message-ID: <7v1vktc1uk.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <4AE0190E.8020803@gmail.com>
 <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
 <4AE0DAB3.1030103@gmail.com>
 <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com>
 <fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com>
 <4AE0E542.8010501@gmail.com>
 <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com>
 <7vd44eaqc5.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QOy-0004D3-5v
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbZJWUGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbZJWUGI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:06:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZJWUGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6996646B1;
	Fri, 23 Oct 2009 16:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Khp2hMDJcTC8rLXZHdWsGmXxJRA=; b=oMc8uB
	alP8XuTzIcmJ8R4JHCirq/vFrga5W+adRgL73lPKFpZxp4EQ7WtrrQEohcTj2Wkz
	WAeFBJfZB7au2lTHvCkGUtjzkuQRByAA9nGpOC/cbBHwikXRz3IiKBPHAQHeGi2U
	4YOT2rC8BaX10sppQwSNFurw2K8nTbMy2Cwzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TF0n7qcPrE9sEu9jl6iTuWJ8NkSWy12L
	UyuVpAX7WZxzMlgYqLII+ClwdrWtgGj0sO9yw9ybbnnVzcuKLjDy0Odx7oXRtXQD
	yVGTawu7hbEKXZy0eEcFeEkOHgAyQq0Oy+zfH/B+eMYvnfJww7oEtC6PQI1/glAq
	3S9Yx4/XS8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 465E0646AE;
	Fri, 23 Oct 2009 16:06:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08579646AD; Fri, 23 Oct
 2009 16:05:56 -0400 (EDT)
In-Reply-To: <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 23 Oct 2009 14\:16\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7EAC104C-C00F-11DE-82C8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131123>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> This is my main concern, adding 'bash_completion' as a target to all:
> would be ok; why would 'make clean' break it? As long as you don't add
> "make -C contrib/completion clean' to the main clean target there's no
> problem?

"make clean" should remove it, because it is a normal build product,
if you make your "make all" build completion scripts.

The word _should_ is used in the RFC2119 sense: there may exist valid
reasons in particular circumstances to ignore a particular item, but the
full implications must be understood and carefully weighed before choosing
a different course.
