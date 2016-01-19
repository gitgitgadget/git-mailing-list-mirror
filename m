From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Tue, 19 Jan 2016 15:17:11 -0800
Message-ID: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
References: <1452901035-1802-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfWY-0008T4-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbcASXRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:17:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933156AbcASXRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:17:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0297D3D7E2;
	Tue, 19 Jan 2016 18:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SqRWcIUADyUmA2jt0VAIxrCPTF4=; b=jSmJBf
	IezqAXhqCgdngZ494lryWVhrMEWYXy3VmYwmFuHekvERF3HfaHHzA/Z2spQqi8Vv
	L0QBZZerflz1cNmyfojlDfI9FOrRWkIAmTzbUxBAPbpA0TdcM8ghPkjGoZE0i/zg
	o/YuJaUHWqyKZw5nk8lRaTlc+m7UwNpwnfp4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQSiEftVFhsEx2WMOaDzuYUGPeuAiyHw
	fvOulcuievZiBnjMbJ7rfIZlfxMcZkMKUM7XlQZUPq83v+bf4pOlFPepUrMCYifk
	ZxlC1IoQkBIwEZMzkpU1uiutRwE2oDXbZUo4lgsLw8B6VLjKX4lc1IlMNl8a5wRM
	3cpY5TBs9iw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDB603D7E1;
	Tue, 19 Jan 2016 18:17:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 722FD3D7E0;
	Tue, 19 Jan 2016 18:17:12 -0500 (EST)
In-Reply-To: <1452901035-1802-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 15 Jan 2016 15:37:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5404E6C-BF02-11E5-97FA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284394>

I've queued these with a bit of tweak in their log message.

Thanks.
