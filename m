From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: make tests more self-contained
Date: Wed, 21 Aug 2013 16:27:57 -0700
Message-ID: <xmqqfvu2sjya.fsf@gitster.dls.corp.google.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
	<1377112378-45511-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 01:28:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCHos-0004cU-35
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 01:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab3HUX2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 19:28:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037Ab3HUX2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 19:28:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D129F3B9A7;
	Wed, 21 Aug 2013 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MYpwmVlPRDYXIFbnLqCIBrqULVI=; b=gXAOna
	4AMb5F8nf0YcFd1KB46+Asgg8wCTJAhmtS+n39iLoaO85KMiUA4JmBjxuL9jpPrS
	kUW2/hG5IqRNloxlOePFGcXV89kPARSQxpsCOACTy389zfMARJ6uarCKOkdJKGkp
	9sg4JOHAn8fHleuWQzuh5r+oh0J9ijQpYnGbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFKVfW0q0BJw2r9BzpgE47Mc7xm7DFQy
	3hRa31pB7Qtsh+LsgH8zlyVTphnobvizktfEk62OFGxq2XhUR0m6eVo4w8tCRQdx
	/gqUtlPoDZhNPXhdsL5qN/OeCEmvmngQcpOm8BZECPWRysOvg/9bKtTUHiPhv9NF
	AttJNT1M4Og=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C88A93B9A6;
	Wed, 21 Aug 2013 23:27:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 302D53B9A5;
	Wed, 21 Aug 2013 23:27:59 +0000 (UTC)
In-Reply-To: <1377112378-45511-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 21 Aug 2013 15:12:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50CC78C6-0AB9-11E3-B129-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232751>

Eric Sunshine <sunshine@sunshineco.com> writes:

> As its very first action, t3404 installs (via set_fake_editor) a
> specialized $EDITOR which simplifies automated 'rebase -i' testing. Many
> tests rely upon this setting, thus tests which need a different editor
> must take extra care upon completion to restore $EDITOR in order to
> avoid breaking following tests. This places extra burden upon such tests
> and requires that they undesirably have extra knowledge about
> surrounding tests. Ease this burden by having each test install the
> $EDITOR it requires, rather than relying upon a global setting.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

Makes sense.  Thanks.
