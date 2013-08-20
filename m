From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 14:44:35 -0700
Message-ID: <xmqqppt8ujek.fsf@gitster.dls.corp.google.com>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
	<xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
	<20130820151554.6afbcb7f@gandalf.local.home>
	<7v7gfgkuyo.fsf@alter.siamese.dyndns.org>
	<20130820155433.217abb3e@gandalf.local.home>
	<5213CF53.5010306@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtjH-0007VK-9b
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab3HTVoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:44:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab3HTVoi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:44:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E313A54C;
	Tue, 20 Aug 2013 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25L6qIHrVLl5IsyvkmMCWRH4TMk=; b=pp76Z0
	m5bUyKAlW57zHcwuzJPaqeOoT9RPOLB6JGMNcuHspgl2NjGiWPFW3Pbiju2H0ZW+
	WITWyiwcklwBdbFl+Uji61Ndy8vW0uERnRG+/MRnyK1LGw/faxlJfBDShri4IGsy
	Qn2NBfVjCGZ8Hc1OC/yqjSQ5YlhhaVPL2wEEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V5U+mHZQuIBrVt2MpHaogPtbeGVIMMqq
	d6m99vnoiFhMf1y7VuKCnZDXsWAWj5MoTJ5G2LIer5+rhDc5RLT13DZ9MSvAzNT5
	9gdsI0PG4RbLMTH//TnuyHaEhis4C2C579zrmfotm4yAMLJgZT8W3FjI2zqLm7q5
	ZhuI96ppcVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46BCC3A54B;
	Tue, 20 Aug 2013 21:44:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97D3C3A548;
	Tue, 20 Aug 2013 21:44:37 +0000 (UTC)
In-Reply-To: <5213CF53.5010306@windriver.com> (Paul Gortmaker's message of
	"Tue, 20 Aug 2013 16:19:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5F5B66E-09E1-11E3-9280-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232652>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

>> Looks good to me. Paul, what do you think?
>
> Yep, I'll write something up tomorrow which loosely matches the above.

Thanks.
