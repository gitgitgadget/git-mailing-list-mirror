From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Mon, 17 Jun 2013 10:54:49 -0700
Message-ID: <7vy5a8ei6u.fsf@alter.siamese.dyndns.org>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
	<1371300192-6222-2-git-send-email-artagnon@gmail.com>
	<7v38shjw01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoddt-0007tJ-W6
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab3FQRy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab3FQRyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC84B280E1;
	Mon, 17 Jun 2013 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Pn8YWYPt6Ao+OFyVJwvlbC99ocs=; b=Vtc2Wr07pfdEjVBmmoAd
	erQSfrSXUPJxxNnltmLhNRZWAQldfAwJwHwaRY258HYi/Xm4nFzsWefPqgqVAJWY
	dC+YYfTFHVtor5VBd/FOX8x3QwB9akwDyIw7id2qioFVaaeMEMhY6XZsFlVhYPf5
	KNCTk7CuTsUNWPl7pZErJiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Aes+ckO8sTXR69HcopMngLFDcr5oGFgNmTz9RBsuPdPTiN
	mBpWW5c9DPZ9kz9hiC5ipYlIOr3bmD3i3VKiy93xRnbnLDDDG9vzSOfPM5uFVwO8
	j9d3kXHzmxs9hiR2yDiz4Vzvf+b1VyfKO3LQWnIg/bWJ3xxYcUuCaKzyNoZvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CED5D280E0;
	Mon, 17 Jun 2013 17:54:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 451F9280DC;
	Mon, 17 Jun 2013 17:54:51 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0239A46A-D777-11E2-8088-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228090>

Junio C Hamano <gitster@pobox.com> writes:

> Will replace what has been queued on 'pu'.

... after fixing an indentation error, that is.
