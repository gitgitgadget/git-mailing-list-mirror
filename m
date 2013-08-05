From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] howto: Eliminate all tabs
Date: Mon, 05 Aug 2013 08:32:33 -0700
Message-ID: <7vfvuonofi.fsf@alter.siamese.dyndns.org>
References: <20130716180158.GA7524@bottich>
	<cover.1375288760.git.halsmit@t-online.de>
	<4d37bfa3326469ab5b7cdbf0018f7aa671c2d74a.1375288760.git.halsmit@t-online.de>
	<20130731165425.GC11219@bottich>
	<7v8v0mvezw.fsf@alter.siamese.dyndns.org>
	<CAA01CsqW1FWm8ExK7hypHp1_Jm0-kc1REQeuPYjbzU=aUQ+L9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk Wallenstein <halsmit@t-online.de>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Ackermann <th.acker@arcor.de>, junio@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Mm0-0003HF-FA
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab3HEPcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:32:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab3HEPcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:32:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6EA36D8F;
	Mon,  5 Aug 2013 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8hnsIWSZMzekANQ1mBB8UkbEpS0=; b=gLDTde
	2a9Fm8ME9YXGFtFHQUK2Dqum+sOe6aMqB8vkhKYtxAxPhye3fzB7hK9id16D6lHX
	V8OLXu241kAkrmk8gBXeFIwhSWbHQqGOMm/UGn7oFTpsua6g0ZW2CiGXgei9zuFI
	5u44bnsEis8i32q8jJwCGzKjv4ylyW2s/13Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7JCRcZzG+MIZUJwfrL0JUYqUDgNExOF
	BBP3xVM/HUp9i5ecZco7h/Llotoka+U79vZ/pETTCEa5ffRux3PENlE0F6l3RlDx
	cpvyxfHZCVORNfdgTqV3Xe1vWo56lX1j2iGD59HPGZEjckrqLpVeBcY3FaA0UGsL
	5adE/PL3NPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2308D36D8E;
	Mon,  5 Aug 2013 15:32:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A3B836D8C;
	Mon,  5 Aug 2013 15:32:34 +0000 (UTC)
In-Reply-To: <CAA01CsqW1FWm8ExK7hypHp1_Jm0-kc1REQeuPYjbzU=aUQ+L9g@mail.gmail.com>
	(Piotr Krukowiecki's message of "Sat, 3 Aug 2013 21:50:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4025C072-FDE4-11E2-A3C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231656>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Isn't the howto documentation intended (mainly/also) for the users of git,
> not the developers?

And they have *.html version for that exact version, no?

We used not to bother running asciidoc to Documentation/howto, so
the *.txt versions had to be exposed to the end users because there
was no other variant. That is no longer true, and *.txt versions are
sources.
