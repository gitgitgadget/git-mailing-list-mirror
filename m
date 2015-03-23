From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] introduce capture_command to avoid deadlocks
Date: Sun, 22 Mar 2015 21:40:45 -0700
Message-ID: <xmqqa8z4ba2a.fsf@gitster.dls.corp.google.com>
References: <20150322095924.GA24651@peff.net>
	<20150322100724.GC11615@peff.net>
	<CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
	<xmqqwq28bq3e.fsf@gitster.dls.corp.google.com>
	<xmqqiodsbnyi.fsf@gitster.dls.corp.google.com>
	<20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 05:40:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZuAY-0000rr-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 05:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbCWEkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 00:40:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750959AbbCWEkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 00:40:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 885BD37146;
	Mon, 23 Mar 2015 00:40:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=QVNWsu
	lU2wWP3gHvW/sWJogyUX7RrpUjVgEWv6NNKaLM2551ZK5sHpRGKDtrf74P+uQ26F
	QzfOIdxoFMP3u5X2oGYLEYNnBRWmwCERv0CIajOM3PlodJYgblZIwiHZ3wM68P9L
	z2yTPhQe4iQEjrmjZHYenUeCfAxuoWsgzciUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W5hhF1H7uh/ww/KERaRE1bMGR5NTk0SJ
	y0QiKUGHzRmQ3udHymRDv0UUb9toJDHd0GCFMRq5IVQYWPBzB3PoPm4DU8Sw9h8M
	YZlhIKGdxOXRAbvxHYTvDc2fpWN+o0cBS8i4IqYnfJg+xOukwL9Iq1p/dRLBQv5y
	/4WwBpFs6aE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7934937145;
	Mon, 23 Mar 2015 00:40:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E87F337143;
	Mon, 23 Mar 2015 00:40:46 -0400 (EDT)
In-Reply-To: <20150323035302.GA30279@peff.net> (Jeff King's message of "Sun,
	22 Mar 2015 23:53:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6058B76-D116-11E4-8EF5-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266123>

Thanks; will queue.
