From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] difftool: Change prompt to display the number of files in the diff queue
Date: Mon, 16 Dec 2013 13:04:50 -0800
Message-ID: <xmqqbo0go6bx.fsf@gitster.dls.corp.google.com>
References: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
	<20131216200221.GA23689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 22:05:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsfLX-0006FJ-B1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 22:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab3LPVEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 16:04:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab3LPVEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 16:04:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D944E5B721;
	Mon, 16 Dec 2013 16:04:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=rBFtsE
	7D2ZQJDh+BM37fRuRP3J/aqGLgCy27yDQeJAJBcZrcIKz9eozxUcgg6DUzN11jrF
	ULZknAzoxE3SUcBpCPvTFSdLnUJ8KZVC/uDFvv7jBKAXH4hsCE+rfKW8YhlS58Dm
	Qp04RI9qBg/35LMcTh9L+uiFj6CmoiPPF0rv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AbuLctC8JWb386QSXGlLMs+g9FriQRl5
	De1Amgo6F0LOGJ/HZxH18ualPWe+7WETzbsovXzo0t/LhGhxDOI+rnpMBTZH1XIv
	ZpyoNaPAx1GR79FkFTqxlZlScgKBLhlE/cjTvjkHf88bAGJ+fLhz67qq3ybXDE6y
	ZJsc/9wMAsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C50B45B720;
	Mon, 16 Dec 2013 16:04:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 100ED5B71F;
	Mon, 16 Dec 2013 16:04:52 -0500 (EST)
In-Reply-To: <20131216200221.GA23689@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 16 Dec 2013 15:02:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B565E3AC-6695-11E3-9176-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239367>

Thanks.
