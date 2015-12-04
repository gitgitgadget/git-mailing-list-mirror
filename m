From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Fri, 04 Dec 2015 12:10:43 -0800
Message-ID: <xmqqh9jyrn3w.fsf@gitster.mtv.corp.google.com>
References: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4wgt-0005yD-4K
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 21:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbLDUKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 15:10:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752509AbbLDUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 15:10:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CC9B30174;
	Fri,  4 Dec 2015 15:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DLLNrHc+xxbjbGQUe+K1KLnNB4=; b=JKNYI4
	hqEJV24LrGzX9hsgMesAednfSfzfJlZD5WPRrU6QLWuRhBpRW/5Tu2mPlp6d5XwJ
	H7TtPyp7oss6KMqa7gjWuygRzNjJrsWS+BCO9bUkSSx/XvE6+awbkhlIQsqXTD5n
	v1mEq+5+hUyP0PxYP/i9MGNYvnzBBSggcpngw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hn9VVfyqb/Fz7mxVuriquv2OWu0rWign
	94iSYbaWf1r/xk+AguRCp2dNGSdNoDZyNf9D+T0CJQatvB4W6XNsf0j8AuVlmnE1
	YmQoOwj92R/BVILx0Y02Uo4vrH0NYIfVz2HcEZz0/4TxRkS6pODbdVPboNbpXYGK
	1dMSvFTyxkc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34C6830173;
	Fri,  4 Dec 2015 15:10:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A3CDA30170;
	Fri,  4 Dec 2015 15:10:44 -0500 (EST)
In-Reply-To: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
	(Victor Leschuk's message of "Wed, 11 Nov 2015 14:52:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19CD0C04-9AC3-11E5-9907-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281999>

This version seems to break t7811 when applied on top of 37023ba3
(Seventh batch for 2.7, 2015-10-26).

I'll eject it from 'pu' for today's integration.
