From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http.proxy: also mention https_proxy and all_proxy
Date: Sun, 04 Mar 2012 21:11:17 -0800
Message-ID: <7vk42z639m.fsf@alter.siamese.dyndns.org>
References: <20120303145053.GA29948@ecki>
 <20120303174252.GC28602@sigill.intra.peff.net> <20120304165043.GA4677@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Mar 05 06:11:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4QCj-0004gG-SF
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 06:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab2CEFLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 00:11:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab2CEFLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 00:11:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0085D79D8;
	Mon,  5 Mar 2012 00:11:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=sg3fGg
	f02fV2RfwzMS+zcf1f6q3Twx4kP9ViaRAxX+ozr3E0LQGuN87uNcEkflRd9mp7xu
	4p2zVc+Xss3QUSZA4k8jpzz3718MiT4hZS5pveiIKJZhv9pMCJsjlt+XX3+hGz2P
	pMNTr3BdkuD8j9aMtkCODjjkQ/6pnu2Z/oM4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IoUjmOj9fPYonExm0u3lmdSheaY1hA8d
	tV1frSlnxXix8AS3EvTV/hur+PpQ2qR5yYiBNQMd4AEz7fcs2MXRJ65ifLi7pCMP
	W8ktVlmUsP+zS9U9aku3mFZnoEWR1rSM2PcpxDlbBADqfLtMAeYxIe5If80x/VKf
	qttkKDvJCAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC0A279D7;
	Mon,  5 Mar 2012 00:11:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8177179D6; Mon,  5 Mar 2012
 00:11:18 -0500 (EST)
In-Reply-To: <20120304165043.GA4677@ecki> (Clemens Buchacher's message of
 "Sun, 4 Mar 2012 17:50:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3F58052-6681-11E1-A82E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192205>

Thanks; will queue.
