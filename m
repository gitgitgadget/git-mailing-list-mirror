From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 15:44:42 -0800
Message-ID: <xmqq4mfjff9x.fsf@gitster.mtv.corp.google.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
	<20151215233207.GA30294@sigill.intra.peff.net>
	<xmqqbn9rffo0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zH0-0001s1-4E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbbLOXoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:44:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933785AbbLOXop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:44:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BABC33BC2;
	Tue, 15 Dec 2015 18:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h47Ut1tjZdrOHPjmtdZhWx0LO08=; b=VON+Y0
	QCn0PFh1dO8zYkORT4hbs94AylcCf0gDNmdw96N2X3jMUQ4dLT4M1kcJomjh5zvr
	N5UiXrCai4yUzrKxSmTSYDR4z5NfXjBinV6LYCYPrPnxPh1kvGwCVlAYg7K1mv45
	jGytId8ZiZBQ792TRMMF7KAB1i3PtXrRgtCik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsIYNfpSEJ7GcUmNC6UY+l8zo+qWR3iC
	mctZfzqfNmwqug7mlrm9CcsdsEPg6ffVAVnzuqiwpG7O3gmWXxeLQ6wfdYm6hhy2
	peGnPDOd4bqcbNxYvlt0VKAe0fu2Baua4c/u+/RzhLxHVej2IGBVrkeF4C0Segxj
	Xb6Ar6/8MNw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 839B733BC0;
	Tue, 15 Dec 2015 18:44:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05F9733BBF;
	Tue, 15 Dec 2015 18:44:43 -0500 (EST)
In-Reply-To: <xmqqbn9rffo0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 15 Dec 2015 15:36:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D13214FA-A385-11E5-8937-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282512>

Junio C Hamano <gitster@pobox.com> writes:

> There already was strbuf_getline_crlf(), and I wanted a new name to
> be conservative.

When I re-read the series, I realize that the existing one had
exactly the same semantics as strbuf_gets(), so I think no risk
would come from reusing that name.  Let me try redoing the series
when I find time ;-)

Thanks.
