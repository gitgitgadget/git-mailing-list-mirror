From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 08:08:47 -0700
Message-ID: <7vhah0raps.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVcV-0006Fd-2K
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3FNPIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:08:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab3FNPIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:08:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CEDD25550;
	Fri, 14 Jun 2013 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4m5icYcDP9cKh+SpVGq6Ehf54Ro=; b=Dn/LN9
	f4fcZIhHMRcQcu5KpWSgIMqYMoISMIFdcFwM2/6NwodSRN4DhVRorbjY3OdJYmBN
	1vK6/Q4ipzUCC1SIxJQBN2bGHpnL0uhssB+Tt4HNluvU9u/8oKhgmNKO2BT6kEMr
	++txz+UdNuI/+mzPnCUD9m6s98sjXh5sm9iKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t2kofHfxnRpdkP3C/l/9IQ9q6vAU9QWx
	txpolqYUMTJGoTOo8hLX3y0xZ6zxcFUi4LZYvzCuTPG1/nfRIJZ5Mt+n7mA7WFWh
	vhDSBvsLfTHy8nnH2iH4v/nlsEQskoj1Q3kCtvsq7O7ErGh6ci82PK7cVj7DGf4i
	i8/RBB+ySuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01BB22554E;
	Fri, 14 Jun 2013 15:08:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72ADF25547;
	Fri, 14 Jun 2013 15:08:49 +0000 (UTC)
In-Reply-To: <1371196058-23948-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 13:17:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5147F64E-D504-11E2-8FD9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227879>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +			die "$(eval_gettext "Stray $dotest directory found.
> +Use \"git am --abort\" to remove it.")"

$dotest, or \$dotest?
