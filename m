From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] git-p4: accommodate new move/delete type in p4
Date: Mon, 21 Feb 2011 15:32:50 -0800
Message-ID: <7vhbbxhskd.fsf@alter.siamese.dyndns.org>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
 <1298121481-7005-5-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:33:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfFf-0002Rs-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab1BUXdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:33:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab1BUXdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:33:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F24083FB6;
	Mon, 21 Feb 2011 18:34:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0mQP1Cy1FWdsgKTeuNhK0Scp/KU=; b=QqQTq11QwHyemdth7iNuxkI
	9omoJj3BomNeVAISbdsLdJnlTlTq92HWovOH4fxuNljHDAb5/LTSD32j4Ljna32X
	+Mppd54vYu2OHZ1YkFfhl4it7w1+Y+yAH/TJDPwqDSB57f+m14iz+Fh/BUnbPv25
	QsuCpwM3YDsAkhpV6gfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dQFVFXfCC2IM1oje0cq3EhWOLTSen75At9vVAJXaaEQt5XwtD
	mDAlYsxIyEX2rxMYT52bnvjSBfN9djZjM+y47X+1vboVYWGCX7cJrwKqdV7p5KXX
	SNDjbgzBWw9kMWB1tJEtFixLhmZnrKLDVmxYERA6pW9b/px+R4SAQH5OL8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFD373FB4;
	Mon, 21 Feb 2011 18:34:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 536813FB3; Mon, 21 Feb 2011
 18:34:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1449CB3A-3E13-11E0-8213-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167509>

Pete Wyckoff <pw@padd.com> writes:

> Change 562d53f (2010-11-21) recognized the new move/delete type
> for git-p4 sync, but it can also show up in an initial clone and
> labels output.  Instead of replicating this in three places,
> hoist the definition somewhere global.

I think the said commit is from January not November, though.
No need to resend---I'll fix the comment up in place.

Thanks.
