From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using git-replace to edit a commit message?
Date: Sun, 22 May 2011 19:11:41 -0700
Message-ID: <7vpqnaw4gy.fsf@alter.siamese.dyndns.org>
References: <loom.20110523T001117-737@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Smith <unknown_kev_cat@hotmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 04:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOKcc-0008W0-7X
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 04:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab1EWCLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 22:11:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab1EWCLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 22:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B19E5575;
	Sun, 22 May 2011 22:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WjOaCe0FnQ4gzMLBisW6kbCqYM8=; b=BnkVSB
	KuLl8K2JiGw3gm5eEaKP6FUNBY9OJZg8i6k3fcAo8b5xviI1vcHV1q9aMDWHA2Gw
	MSp9/EUEgj1qGPRxNklGIsdPV9Es9dwk1kfVd3DL5Uuj22AEjk1t4aZcJmV9SJGQ
	8+hVAavmJ+lYm8wPWtaFpoGx/kkop4g6OCo4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=knKYqi1KnhUcrOaFs+/ta+BEHcrYg7fW
	bCyMDhTXiOfEtSlWZ84RgbQVTtVbRjh1H2IR/IkwQPC41YeIxc5u/1sUMAC78y/a
	TYBVIc8c7LlB+9PUCAjs4Dh0cA8yCa0IIertKcNdda9b80mzdS/2eTja7eVMxBPg
	j5fPW+wc+OY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7866D5574;
	Sun, 22 May 2011 22:13:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A4ED65573; Sun, 22 May 2011
 22:13:51 -0400 (EDT)
In-Reply-To: <loom.20110523T001117-737@post.gmane.org> (Joe Smith's message
 of "Sun, 22 May 2011 22:11:39 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F023120-84E2-11E0-AFF5-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174219>

Joe Smith <unknown_kev_cat@hotmail.com> writes:

> Is there some reason that will not work? If it would work, is there
> some reason nobody ever seems to suggest it?

It would; I think the real reason is because it is not worth the trouble
for asking everybody to trust your replace refs and install them in their
repository and pay the runtime cost. Most people just move on once their
mistakes are public.
