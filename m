From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] wincred: fix get credential if username has "@"
Date: Wed, 18 Feb 2015 11:03:06 -0800
Message-ID: <xmqqlhjv2gb9.fsf@gitster.dls.corp.google.com>
References: <1424286123-12985-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aleksey Vasenev <margtu-fivt@ya.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 20:03:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9ty-00048Y-To
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbbBRTDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:03:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752653AbbBRTDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:03:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0077D382C7;
	Wed, 18 Feb 2015 14:03:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r5sP6cB/WMTncy78GB++Tn2xBUI=; b=fsWeIC
	z269uQ1kyqxsJbd3hY3iacUlkv+uzQaluJK2vliQawRvZ2cgo15ozgk756gmm93c
	aWNoH4ynfnDBTW72NMjlhfUJdRxKmES6/3L9k/xQEo6R8SABca6bkQccn/SQ65wd
	merMGCCGo9glVPQYwMptP3WdI7Fcua2mkhCic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJMG21JDqo1Y5fk6tszxl4ZgEAhdyXm4
	zSPuQeI6C3sD77iOueDXhlOf/8ZEzqGbKoeBoFesx+WtRBrEMGD6JPU1pLTwc9H+
	oyL/sfD8V2L6PXgfPZp3w41+NvQJeyQpvgDw+xsnRmR8jaekzYDN7JX04NQxTbc2
	1kmwPRNhQqU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3AE0382C6;
	Wed, 18 Feb 2015 14:03:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58BFD382C4;
	Wed, 18 Feb 2015 14:03:07 -0500 (EST)
In-Reply-To: <1424286123-12985-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 18 Feb 2015 11:01:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C612CCBC-B7A0-11E4-9EC3-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264048>

Sorry, please disregard these sent by mistake.
