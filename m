From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Mention of 1.7.0 transition plans in Release Notes to
 1.6.6
Date: Sun, 29 Nov 2009 00:44:26 -0800
Message-ID: <7v1vjhd8k5.fsf@alter.siamese.dyndns.org>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
 <20091129122448.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 09:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEfOn-0000Lj-Nq
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 09:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbZK2Ioc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 03:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZK2Ioc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 03:44:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZK2Iob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 03:44:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8932DA263A;
	Sun, 29 Nov 2009 03:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvnYLya9jJBRT5tM6bEjOeXk1wI=; b=J9Z8Qq
	cgjxTWv14ccVn70Go42X4kBCvchc99qApccr/1hW4rjn/qbogUu9rPqyy9xrQcoE
	JwcUsYxuVJX1MVYYGUZr4J8NzrzOky07YKqq1xwFhmKR4poRJ1TIIUKTW6PZgZ16
	/xsMB9ndRJj22thd3x4ynfD/mWlc5S/2Pjbns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iX/bDS0V6cI5jFSk51v772KOoyi823uY
	e+XCoz/I+P0kazkjbFPJ9rIkXYA3tXfHRsAqxMQI4P4El/RLCTKpgAEbwV0dUasR
	cDugH/D6jkvbgmRjm0x9WQvFAAic4oENJ2c75/IvrcGp2gvlCq7rOlAnA4XF/EgQ
	dISK0vgyJ2U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A40FA2637;
	Sun, 29 Nov 2009 03:44:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4BD1A2630; Sun, 29 Nov 2009
 03:44:27 -0500 (EST)
In-Reply-To: <20091129122448.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun\, 29 Nov 2009 12\:24\:48 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A95AF3E-DCC3-11DE-AA7D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134003>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Subject: prepare send-email for smoother change of --chain-reply-to default
>
> Give a warning message when send-email uses chain-reply-to to thread the
> messages because of the current default, not because the user explicitly
> asked to, either from the command line or from the configuration.
>
> This way, by the time 1.7.0 switches the default, everybody will be ready.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---

Looks good.
