From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] pull into unborn branch safety tree
Date: Thu, 20 Jun 2013 15:52:57 -0700
Message-ID: <7vli64pf7a.fsf@alter.siamese.dyndns.org>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<7v8v24vd0m.fsf@alter.siamese.dyndns.org>
	<20130620201957.GC31364@sigill.intra.peff.net>
	<7vmwqkqzhy.fsf@alter.siamese.dyndns.org>
	<20130620205533.GA8074@sigill.intra.peff.net>
	<7v7ghoqwwv.fsf@alter.siamese.dyndns.org>
	<20130620220328.GA3992@sigill.intra.peff.net>
	<20130620223550.GA21667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upniz-0004cE-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444Ab3FTWxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:53:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030380Ab3FTWxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:53:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6F6A2A5A9;
	Thu, 20 Jun 2013 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QnWYn7085vKRtxQB+I2Rn+NeOKw=; b=V2rTe4
	tJy4nZAtzUVhHVOjYNMQwgGgZKtn7zROxQtMxPMHAw7zxjADBCRfr9h3l0e1mYKz
	aJqHfC6UobWC8m0LW/z1Kq7qS6VPtrNAgIQuTXjEviXQj5qIebww21frFFVdaewz
	oS/sn3jhCaC+Jga3ko6miPUpmn5tW07Nv6Zp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=giqiGVmLUBPOBFSbuoTbTIkV625YDeGl
	7lyRMin0sXXsviJHf7xFT1ZR3GIK145nmyZCu4+YzoOCbeNwFti1ZwT+3VAVSC3r
	D12buXvY4XQCCQ/NausRA90+wvxRsTZOx6FMyvZkwce7vmHhAPU4fnhcPfqOakZ7
	seoMV5N+zro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA1412A5A8;
	Thu, 20 Jun 2013 22:52:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D8542A5A7;
	Thu, 20 Jun 2013 22:52:59 +0000 (UTC)
In-Reply-To: <20130620223550.GA21667@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Jun 2013 18:35:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 277C0042-D9FC-11E2-B4FA-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228554>

Thanks; both look obviously good.
