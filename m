From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test for correct behaviour on %B(1) and %B(-1)
Date: Mon, 05 Oct 2009 12:08:27 -0700
Message-ID: <7vws39acb8.fsf@alter.siamese.dyndns.org>
References: <7vmy4mo85b.fsf@alter.siamese.dyndns.org>
 <1253711564-17876-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Musxe-0004vg-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbZJETJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZJETJU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:09:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbZJETJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:09:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E78B34D8F3;
	Mon,  5 Oct 2009 15:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2OQbIHTlUtaGCOmTbo5gw4UCwbg=; b=vnIxMuEx4QfCX7wKD6fXlU4
	7a0WsJ3we8H2tElLX4nsLXZYu4pIY4eryeEo2Sn6ZoDoG7GMtuD+WvJBv923IWI8
	dRpmdcIvF8R/5bW/3oH7FL1VqdX/vHZPJLrPcp/TKy5vVRV8GI5VBWX/8gTz3zLQ
	mBJR0ldsYJUg5wZQfyEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yOVoFcv5Z9kiLb4O2QwLGR438WGIe4tPg5DRjthn8j7oNuJGN
	pPEW3QoF57EG2W7ODzfu9IqyOgQo5drJxdYWmEkSDmIRhcswhs+F88Igfu7nkM88
	sFj72cw+L8I2p47TmReVUj6hE/gzGH1pQ1cVP7/ZWAU4Gy6gkDhjDQwwsI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C92174D8F2;
	Mon,  5 Oct 2009 15:08:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48D304D8F1; Mon,  5 Oct
 2009 15:08:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 78F8A84E-B1E2-11DE-967C-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129576>

Johannes Gilger <heipei@hackvalue.de> writes:

> seeing as the %B-patch is in your pu you seem to be almost happy with it.

Being in 'pu' does not mean that much; it just means that I do not want to
lose the patch and nothing more.  I'll squash the test in anyway.

We may want to build on this further to cover Dscho's line-wrap but that
is independent of this addition.

Thanks.
