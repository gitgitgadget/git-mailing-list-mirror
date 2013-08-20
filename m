From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 12:07:18 -0700
Message-ID: <xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:07:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrH7-0007rf-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3HTTHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:07:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab3HTTHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:07:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D05E33A8BF;
	Tue, 20 Aug 2013 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yOGTsIlNG3UkrvJsx1//1fenvMM=; b=soAsI0
	RxsM5kaDcEskccfMUsJibqfxzLRLP9swDJ36hkJN+drSFKOVWAmucOJxE5SOb5ye
	5KWe5T9x50BcnR6DHFbG8ECzb579SyzMZZuAM6vzI7H6Hc/LRtxBG15P9gp0I2La
	6guproE9ZDvCXHPfxBqbQLaEk2zGGPB3dF/zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WWHkx4b8BRq2irL85+nasKv/DX9OhUEU
	rXZuuS/IGN7HWkvwprGRx6dXCrAD99rYkD7PaRUKM5Aw1JqBSS5XUAHkee4TjXL8
	WImf0brio9w8em8en9dFZmVMahe/zQHbfPYyGxQ8d+uk6nVncw1dNWmcNh0OP+BP
	tNLu/5TkNRs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2AD93A8BE;
	Tue, 20 Aug 2013 19:07:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A403A8B4;
	Tue, 20 Aug 2013 19:07:20 +0000 (UTC)
In-Reply-To: <5213B95D.3040409@windriver.com> (Paul Gortmaker's message of
	"Tue, 20 Aug 2013 14:45:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD57BBCA-09CB-11E3-AD68-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232633>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> OK, so given your feedback, how do you feel about a patch to the
> documentation that indicates to use "-v" in combination with the
> "--check" to get equivalent "patch --dry-run" behaviour?   If that
> had existed, I'd have not gone rummaging around in the source, so
> that should be good enough to help others avoid the same...

I do not think it is necessarily a good idea to assume that people
who are learning "git apply" know how GNU patch works.

But I do agree that the description of -v, --verbose has a lot of
room for improvement.

	Report progress to stderr. By default, only a message about the
	current patch being applied will be printed. This option will cause
	additional information to be reported.

It is totally unclear what "additional information" is reported at
all.

Thanks.
