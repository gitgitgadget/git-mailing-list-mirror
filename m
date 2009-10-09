From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: die instead of fprintf/exit in -i error
Date: Thu, 08 Oct 2009 23:53:12 -0700
Message-ID: <7v1vld5a93.fsf@alter.siamese.dyndns.org>
References: <4ACE4C72.4050400@gmail.com>
 <1255053215-14059-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bebarino@gmail.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9P3-0007Wp-85
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980AbZJIGyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbZJIGyE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:54:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699AbZJIGyC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:54:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B366870481;
	Fri,  9 Oct 2009 02:53:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NyNLhNFi+2i1WDQN/f1Fuw/cKf4=; b=GqLhPGWIW8Y7c96cKqrHMD/
	PbwqjK19q1UpqQCpkW2zh1aG8XkB7838lWjYwbzD9hyfqrJtive9ktsuRtlhUEEJ
	F42R9SnxIdvr0dlbEtsDbDcDcuGkUs4useMPQ4sMDXzCMyz3onMFBkp5CDmtUezk
	oIBVf1FwCXC7TT9GYB18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nSuTUlTvh5VVlvt5PChQa6Pc3+mdxfYSBppaftQBE8M9HL9v/
	t0ODoWgL6VYQuxWs48qu7fUNdFuWTtFb8Nir9wmy89T3/e2L0FJXb7o7JD0u/LtJ
	Dgs+MDlx29OYTNa1Zn+xe/OP/ll6+0/4m6VECq0W/qr2CPZnA9DcOUhe9c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8854C70480;
	Fri,  9 Oct 2009 02:53:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 690737047F; Fri,  9 Oct 2009
 02:53:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D0EBD8C-B4A0-11DE-8D60-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129747>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> This is the alternate solution to this bug as proposed earlier today.
> I don't have a preference either way for which solution is better or
> more inline with the 'git way,' so please choose the most appropriate.

I think die() is better for consistency reasons if nothing else.

Thanks.
