From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 12:39:05 -0800
Message-ID: <xmqqob4cefti.fsf@gitster.dls.corp.google.com>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
	<20131219190333.GE23496@pacific.linksys.moosehall>
	<xmqq38lofv8b.fsf@gitster.dls.corp.google.com>
	<20131219203635.GG23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkNG-0001ql-75
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab3LSUjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:39:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab3LSUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:39:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 697C35BD5D;
	Thu, 19 Dec 2013 15:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4cvzpyTIfp0kXhMWlA1nCdCF99A=; b=DgeTFk
	ZGfJqp1B+WmR2X8tgQtyF3tRT6mP/aoh1ctDNyGzVxWxrW07tjGs9caX+4XZnfwV
	dUvz4tuARo1kpv9R7uzDE2A5A5AifB69PMMTLzzUYeIrPWQFzrNORZtRXJUgNfqx
	XQtBelhSmlsUiuEK7Na4Za/XaPUIlvTaTRoOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VrZlEjVZfQFXelSOz0ZY1FhV67omBs3j
	+kl2fAlp0fjVpjl7Jg187/llaVWaEGWXb5qms3nfeNORSxIDVLb2aUU3KkmqH861
	2YRkFeVx0Ve9Q/CahZELuewkFBRgd/BnG4ctJeCKtxe5+LDl62cPZ2+BLpMYISmS
	UKvx877exZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C135BD5C;
	Thu, 19 Dec 2013 15:39:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F6D05BD5B;
	Thu, 19 Dec 2013 15:39:07 -0500 (EST)
In-Reply-To: <20131219203635.GG23496@pacific.linksys.moosehall> (Adam Spiers's
	message of "Thu, 19 Dec 2013 20:36:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B7F9BFE-68ED-11E3-A7D7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239543>

Adam Spiers <git@adamspiers.org> writes:

> Ah OK, that makes sense now, but not the most intuitive choice of name
> IMHO.  I would have gone for something like --all-commits, but I guess
> it's way too late to change now.

Besides, it is not --all-commits, is it?  We do cull irrelevant side
branches IIRC.
