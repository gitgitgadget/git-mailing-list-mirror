From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] fix packed-refs races
Date: Mon, 06 May 2013 23:40:47 -0700
Message-ID: <7vobcnmgwg.fsf@alter.siamese.dyndns.org>
References: <20130503083847.GA16542@sigill.intra.peff.net>
	<20130507023610.GA22053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 08:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZba2-0003qi-VH
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab3EGGkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 02:40:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab3EGGku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 02:40:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAC6918BF8;
	Tue,  7 May 2013 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALC8MqGTCe/i1ehPWN1NY6PP+IE=; b=PaWlfI
	TBp5fHdtEEtzVtT8PkU9LMiskoI231dctVhDEK8bpynhSocXwK4Swmkp+MqHbdY3
	gBLV/TjL7SJHQa4mXVnQ1z5bXFGKraacNW4nij53/QDXfkDtzA+esVZUOetf6kql
	VirGON7lnIaAvfmobiJzklT7FUkTlwFCHtAz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=asSPDxd2dJY0BnyYT3ypVZAbg/3yA0v0
	LfDrLktn48U8irj2FzigHtrthcG1EXfCi96dUYHxZcR6FA21Pa7H2KCjzzl5vXbo
	VjVMbsbJWMYKJlxoBsHxesnHvugcFZz9bpWmgYGok9N+JX4RZu5TraPf59wmlPFm
	C3dXd0dHrQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E151B18BF6;
	Tue,  7 May 2013 06:40:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A86718BF4;
	Tue,  7 May 2013 06:40:49 +0000 (UTC)
In-Reply-To: <20130507023610.GA22053@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 May 2013 22:36:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E1191C8-B6E1-11E2-B86E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223556>

Thanks.

I queued this, and will push the result out on the side of 'pu'
closer to 'next'. Could you double check the conflict resolution?

I haven't got around to the peel-ref-cleanup yet.
