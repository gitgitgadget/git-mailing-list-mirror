From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config doc: improve exit code listing
Date: Tue, 26 Apr 2016 11:30:58 -0700
Message-ID: <xmqq8u00gr31.fsf@gitster.mtv.corp.google.com>
References: <20160426181058.7901-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: john@keeping.me.uk, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:31:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7lP-0006c7-II
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbcDZSbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:31:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753110AbcDZSbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:31:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A6CE15C85;
	Tue, 26 Apr 2016 14:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MDnSInSlrKae0Jm+ObZ3jLejz0A=; b=k8yKs3
	6VEQBdN26ipZHajUYUVkwIcdWU6XBioMu3InFyWBssAC6nDpQejaTAGqN3mJk75j
	wKxmWxVBocvPHFHUls/h3hkTKynGwKrtXOHhMOekeRfg41Qzg7XF6KdmFC5APqx1
	QQwAzdznzcZ47yS3fpAPNhcGFeOCHm7/4OfHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EsouGdRtOSKR7JT2SvLvwaPbJ/zK651e
	Nw3sE9YMGK1kbaK64BZ/kH6Oh9lv6sUcA3fIkA7Mje5Dov17pMuzKvli/Tm+2lCD
	TSCNAKnpMu84BcoZiW0BFJt7bPQOyfvUQ5dlgy9PN4kl4pKVnpnTSh9rT7dINsQl
	bnMp2FpNlMI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C96B615C82;
	Tue, 26 Apr 2016 14:31:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C32015C81;
	Tue, 26 Apr 2016 14:31:00 -0400 (EDT)
In-Reply-To: <20160426181058.7901-1-sbeller@google.com> (Stefan Beller's
	message of "Tue, 26 Apr 2016 11:10:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0636D7DE-0BDD-11E6-B907-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292644>

Stefan Beller <sbeller@google.com> writes:

> The possible reasons for exiting are now ordered by the exit code value.

Which makes sense.  Will queue.
