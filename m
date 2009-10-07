From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: add dirstat and friends to diff options
Date: Wed, 07 Oct 2009 12:45:57 -0700
Message-ID: <7vtyybt2bu.fsf@alter.siamese.dyndns.org>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
 <1254905331-29516-2-git-send-email-bebarino@gmail.com>
 <1254905331-29516-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 21:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcVh-0003VM-W7
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 21:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759936AbZJGTqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759934AbZJGTqu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 15:46:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759931AbZJGTqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 15:46:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36AF06E6EE;
	Wed,  7 Oct 2009 15:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rBjWe63j9jZML3190LMZvvM5ZLk=; b=IcHukP
	RyGzbbOFFdhBTpymCgnJ2C9vTgLnnm9cnRB3UeAvj7Jcb3lHTHe5fAfHkZ4k0Cug
	i/tNiYjvjE4Qqp/TGAIbqmAtaTRk1urMBeELMkz47eVtO8b4X1GsW8jbwCFP0Isc
	UWt1sBCGB7mUSZWGvB6MVcgB7zp7p3aSETFt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCzTPjXVlqZKh/bah93O0PCBTCWJozwC
	D0xhnGOo03GNCfB9U04zQjr1VbXXjfuCktVOF+0PdM8yMsAyc7pjT5ZN083VtocF
	VOIxpKSdLazEZFTlx8lUo+nmUl3etYQ91iZ38n2NfFzKIksZMsBlV1PEKKFPPxLu
	yW5AnuG9VjQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0ECD86E6E1;
	Wed,  7 Oct 2009 15:46:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80AE56E6DB; Wed,  7 Oct 2009
 15:45:59 -0400 (EDT)
In-Reply-To: <1254905331-29516-3-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Wed\,  7 Oct 2009 01\:48\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CD2336C-B37A-11DE-BE61-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129653>

Stephen Boyd <bebarino@gmail.com> writes:

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

No objection from me, but I am not a completion expert ;-)
