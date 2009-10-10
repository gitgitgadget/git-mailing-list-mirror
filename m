From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 (amend)] gitweb: Do not show 'patch' link for merge
 commits
Date: Fri, 09 Oct 2009 17:56:57 -0700
Message-ID: <7vhbu8f4me.fsf@alter.siamese.dyndns.org>
References: <20090930201953.22301.73887.stgit@localhost.localdomain>
 <200910091410.15904.jnareb@gmail.com> <200910091423.51286.jnareb@gmail.com>
 <200910091426.44976.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLf-0005GI-Ab
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbZJJA6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934740AbZJJA6P
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934737AbZJJA6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F99952C10;
	Fri,  9 Oct 2009 20:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ioi+L7MfOWfU82ApejS87Z1
	WxDvIasuImJ8sENYMEuQEAZYIb72OT2462bCLMfO5PGlQwVKeCIT8vj6DzEVFLA8
	3dghb0NjPfMRRbAPN1zL+z8tWlT7sqrN3tM8iAms566mqyY2MUmoSGRzXPUZfmEg
	rr3BTTObuY54mSdn98R0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dxGenK0FFIMnc5CPJxhoqd7pV6illh4mr5u+n/fMsPJpZoSio
	FcUrNYEgynGHURD9wjXEsbc14XbZ8G22BcdKXMXdfJN6uhJaIpEjWerDskEEQ9A8
	AZb6MD5oR9Ggtgtc7Vm91tkfVm7PujzOlMQHPfWbyJZP4sZ+Ep9vkx6CiU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C0B52C0F;
	Fri,  9 Oct 2009 20:57:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46EBD52C0E; Fri,  9 Oct
 2009 20:56:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D34D7560-B537-11DE-A745-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129863>

Thanks.
