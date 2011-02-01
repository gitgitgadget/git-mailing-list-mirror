From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Mon, 31 Jan 2011 17:15:16 -0800
Message-ID: <7v4o8o4kt7.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <m3d3ncag7r.fsf_-_@localhost.localdomain>
 <alpine.LFD.2.00.1101311728180.8580@xanadu.home>
 <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com>
 <alpine.LFD.2.00.1101311930280.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Budovski <abudovski@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:15:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4qE-0007Te-9c
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1BABP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:15:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693Ab1BABP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:15:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B438D4EFC;
	Mon, 31 Jan 2011 20:16:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t1UUgY7xPrNRJPEl+jUWhh/X918=; b=EF3aeL
	0jOU8/2xqqRQKX8gMjVkj0bfp0oJble0e7fyT4N8rNwthq+dbtUIcyc8HrmkjtjY
	zVi610Qcrxo5RictFCysyGzkAsFJfHKB8cKnIA4ZwWwigDFxU85FnA/xiDOJ9aRO
	5opc7wXJkDigPh1clW5IAPGqplKB1k1InhKl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNeh03yyxYkubvlkTOSVj9vzk2DLv+WL
	PIny6WJhvXM9jdmgFFzxtyTs5k7VdzZ7zrAuR6kgOt/ZoSFJl8ctOIDpeqqopt8q
	9jce73gtcRxF4Nnf9b/tN31iMrRmDg6Ae4es4ATA0Yn7i2VmS5Wj4KxMM0Me2han
	KQ6EiwpgK+s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 720E24EF4;
	Mon, 31 Jan 2011 20:16:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF9704EF1; Mon, 31 Jan 2011
 20:16:09 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1101311930280.8580@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 31 Jan 2011 19\:33\:16 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE097F52-2DA0-11E0-AB9B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165786>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 1 Feb 2011, Alex Budovski wrote:
> ...
>> The MySQL project (and its clones) also uses the t/ convention.
>
> OK, that makes for another one.
>
> Now what about those hundred counter-example projects _not_ using "t" 
> but something more descriptive?

I am fine with "tests/", by the way.
