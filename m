From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-reset man page
Date: Sat, 10 Nov 2012 12:02:12 -0800
Message-ID: <7v8va9p6pn.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
 <20121110155718.GA29321@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>, peff@peff.net
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:02:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXHG8-0004v0-Rg
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 21:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2KJUCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 15:02:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab2KJUCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 15:02:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D808C23;
	Sat, 10 Nov 2012 15:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=35gKlaRqpu4Z7nA/9Z20fhtT2xE=; b=tAuyBs
	CBdURwWx8ivHEXdCNl25QXmgoLpfg9+XBueZWri3H9zWeZniv68MzUGttTFuygI/
	keAzBBlYDoUqfrdTXEV09yjN9t6GgFQSYPPYggyqA/QTmimAmvDbHi21IjL9EXcH
	5yrB1Ecp9bDltHyFQ57uGIkzIAPG8GC5vbwl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yLZdbMvl3X1JXtpl+9l4MbrRTZPjKK5C
	wYnlimCnpoTC+q9bpPtUVA1C4UiViEglElH9jQREvNFFPc81iDnTEKb/l25bAoLk
	EEYgNAIZ4Q/hHFC6JueZxOhjo0rawZHRE2HKbVeo7CyxHvRLPz4ddXrT+ORFLXOB
	GYGI7bXzR3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2958C22;
	Sat, 10 Nov 2012 15:02:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 297F08C21; Sat, 10 Nov 2012
 15:02:13 -0500 (EST)
In-Reply-To: <20121110155718.GA29321@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Sat, 10 Nov 2012 16:57:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8545DA5C-2B71-11E2-A511-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209304>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> Maybe we should just add that <paths> is an shortcut for <pathspec>
> and fix places where paths and pathspec are mixed or <path> is used as
> <pathspec>.

We should unify uses of <paths> and <path> (the former should be
<path>... or something).

Some places you need to give exact path (iow, these places you
cannot use pathspec), while most other places pathspec
(i.e. matching pattern) is accepted.

The manual correctly updated will most likely to use both <path> and
<pathspec> appropriately.
