From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v2] use strchrnul() in place of strchr() and strlen()
Date: Mon, 10 Mar 2014 08:36:46 -0700
Message-ID: <xmqq1tyarrox.fsf@gitster.dls.corp.google.com>
References: <BLU0-SMTP956BEABA437FB370F76953918A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rohit Mani <rohit.mani@outlook.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN2G6-0004PT-FD
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbaCJPgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:36:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbaCJPgt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 11:36:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F75573F0C;
	Mon, 10 Mar 2014 11:36:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nZwpOPPFaykTRCclwJpgqCy5m/g=; b=DE91wn
	BF2kCboxmiEF0oNp2YR30Pq+bU+wdRyb+T52V9HTeXfNl2vxZq0CsgiRFG8TJfS9
	72BZucpuGY9qIkCmDSZmXXMRKOsP6hV7PxZ7A1QABDkbkIYod30NBhdrJ/1AZrDO
	EvFyssEkv8mrrjPuM87bArrLv1Cp382N4llo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkZbbP1ivhR02zGVT8wgq/zzu/FI5lru
	3JeE++OLCnMvAM7xKp/YlGiHc+3q3XW1mEQsv0H5YCNpbHn4JbFV0y+yb1fPpYko
	YkIUgXb1rzcr0D/HPEPtlPx+YwRb6hk78SHSXUgbCQ4Ldk2K6oQ1yLKS9Z+rB5Sx
	TboSm5/NG+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8B573F0B;
	Mon, 10 Mar 2014 11:36:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7126D73F05;
	Mon, 10 Mar 2014 11:36:48 -0400 (EDT)
In-Reply-To: <BLU0-SMTP956BEABA437FB370F76953918A0@phx.gbl> (Rohit Mani's
	message of "Fri, 7 Mar 2014 22:48:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CB2889C2-A869-11E3-83FF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243768>

Rohit Mani <rohit.mani@outlook.com> writes:

> Avoid scanning strings twice, once with strchr() and then with
> strlen(), by using strchrnul().

Thanks. The patch looks good.
