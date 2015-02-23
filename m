From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AW: git blame swallows up lines in case of mixed line endings
Date: Mon, 23 Feb 2015 12:27:51 -0800
Message-ID: <xmqqmw44s794.fsf@gitster.dls.corp.google.com>
References: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
	<54E88BFA.9050900@web.de>
	<xmqqwq38tql9.fsf@gitster.dls.corp.google.com>
	<71BF70CE41AEE741896AF3A5450D86F11F2D21EB@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'git\@vger.kernel.org'" <git@vger.kernel.org>
To: "Sokolov\, Konstantin \(ext\)" <konstantin.sokolov.ext@siemens.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzbs-0001QR-5R
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbbBWU17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:27:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752695AbbBWU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:27:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B377C3A9FC;
	Mon, 23 Feb 2015 15:27:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aOU1wZkJjOobUcBduUaYQSow3g8=; b=Gjhsrf
	LQxLd5e5CI8wt5XVXutZRI1yFvgRcOD+B4c1tD9g3UXBYIrRh+dVqoQzkX5Ppy5V
	xFIxreEBXThuit7bEdgYB90CQqsryViZX/x+/QI0u4YfrSgfr/xGDZ0KBzb+JEvV
	qySLchrFucCqFyoiKOBNq908/+ohdE1R1dS6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnG12yJVj8y2WzvUIVtfGD3fVkwDBG5a
	F6eFbhWf914+uU9KG+k6ash/xMTiaHqzZc0yZ9sgm2UL+dBdvSMrco/K7sl0hprX
	AbCSnXyXGJi2+UuKN8ocns97GTXpy0808wlDGpu7mQfuFsgXKUg5S8e8j89bqK7S
	WMyWxMm8zcE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 911593A9FB;
	Mon, 23 Feb 2015 15:27:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D7513A9F8;
	Mon, 23 Feb 2015 15:27:53 -0500 (EST)
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F2D21EB@DEFTHW99EH3MSX.ww902.siemens.net>
	(Konstantin Sokolov's message of "Mon, 23 Feb 2015 19:09:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71B10744-BB9A-11E4-81D7-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264297>

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
writes:

> Thank you for going into the matter. I was not aware of the textconv
> filter. This is definitely a decent solution. But what exactly do you
> mean by "Even though we have an option to mark <CR> alone as the end
> of line marker"?

s/have/do not have/; sorry for a false hope ;-)
