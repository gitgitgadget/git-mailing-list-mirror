From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page (web version)
Date: Tue, 19 Nov 2013 20:43:53 -0800
Message-ID: <xmqqwqk37kdy.fsf@gitster.dls.corp.google.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 20 05:44:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vizdx-0000KC-I6
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 05:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab3KTEn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 23:43:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab3KTEn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 23:43:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D1C654216;
	Tue, 19 Nov 2013 23:43:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g0/ovB51A65m9voG3jqM6s47Etw=; b=d/JGFp
	89VFLrI9jCihVYE89nKHBbdJJLDI4nZPn6HYGe4ajg/tcTNNUGsE/xvdiHNGFRnW
	ISE+w6BNtvzffjNFjp4IacWatmfriOYNqKw4HerfxRKE9Xrezlb+7l3nMT0V4o0c
	vxHsx2V/zOdZoyGfRmbb9Rn8HKoeqSEKbkqXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOLn+QKbzxos8Gvi8Xcpw98E7yMZod82
	QllUzFGI72mj7U+hBMQWEkRQnhiYUTW9J8XqH8lSz3O2NjVf8PNlhio1wO/zRYSb
	KqdvMNsaBz4RI8pyGKNSi/P/Zq1cFKtq/pTSStui0nGGXe5RpXfCITMKuMhBqAn6
	3u0hdg8n7V8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7CF54215;
	Tue, 19 Nov 2013 23:43:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F54454214;
	Tue, 19 Nov 2013 23:43:55 -0500 (EST)
In-Reply-To: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Tue, 19 Nov 2013 19:14:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5CBF9C7C-519E-11E3-9C73-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238067>

"Jason St. John" <jstjohn@purdue.edu> writes:

> Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
>     listing blocks

That looks funnily formatted, out of place and redundant.

> Without these blank lines, AsciiDoc thinks the opening "-----" is a
> section heading and typesets the word "to" as such, which causes
> cascading formatting/typesetting issues until the end of the document.

>
> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---
> You can see the carnage here:
> http://git-scm.com/docs/git-rebase#_bugs
>
> This fixes GitHub issue github/gitscm-next#281

Hmph. https://git-htmldocs.googlecode.com/git/git.html has HTML
documentation pages I preformat, but as far as I can see, the bugs
section of git-rebase(1) does not have such a "carnage".

Perhaps git-scm.com uses some buggy formatter?
