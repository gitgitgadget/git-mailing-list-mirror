From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/10] support pager.* for external commands
Date: Thu, 18 Aug 2011 15:56:09 -0700
Message-ID: <7v39gy72ie.fsf@alter.siamese.dyndns.org>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818220132.GB7799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBVY-0006xr-SJ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab1HRW4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:56:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab1HRW4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:56:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3D648BB;
	Thu, 18 Aug 2011 18:56:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IVjh3pOxzOQIZlZzmktLyeQ8gKA=; b=qCoxnC
	dVC9G7vD5lI21Qi80Z/ZpZqQIr9SLnD5cjiGVhLCfuT0wt4a+/ZvzSsk5FY3Qw9u
	QO4CeZyDRIGhONMSMsX2Tol2YMdh+YLTRCYMqp0sbSCL+btdeZtJY3tPMT9YVMlG
	cKW7B8UOfg8MR2DA+m/xRhHd1pHdmqNtrZK2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6mk188JxxD9LGTUeHoR951fjY0r1Qtz
	3rrE35BH8LALQUxj20zWTA8ZKAta7OYPrBN5PNRhNbAbgtnGrfZp4eVX5LH1toyq
	cALA26y1uqIq8WyaEKqy5kynU2nbnp4lVfjR+C10LY/zZKBmaHwOPo0YG/CuOLGz
	h9AwQBPv53o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C035548BA;
	Thu, 18 Aug 2011 18:56:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FD3D48B8; Thu, 18 Aug 2011
 18:56:11 -0400 (EDT)
In-Reply-To: <20110818220132.GB7799@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Aug 2011 15:01:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44607024-C9ED-11E0-9E88-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179654>

Jeff King <peff@peff.net> writes:

> Without this patch, any commands that are not builtin would
> not respect pager.* config. For example:
>
>   git config pager.stash false
>   git stash list
>
> would still use a pager.

Unlike the [11/10] patch, I can see why this is a good change.
Thanks.
