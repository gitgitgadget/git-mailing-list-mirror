From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] unpack-trees: print "Aborting" to stderr
Date: Wed, 21 Sep 2011 15:02:58 -0700
Message-ID: <7v7h511rl9.fsf@alter.siamese.dyndns.org>
References: <4E7996AA.4040909@drmicha.warpmail.net>
 <8b522de3711f339eea264dd7d8e44682af6c4865.1316590874.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 22 00:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Uso-000445-5P
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 00:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab1IUWDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 18:03:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab1IUWDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 18:03:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF165F31;
	Wed, 21 Sep 2011 18:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xw9eENzHVL6LW4nNzc8iJ31WQy4=; b=n+JrN8
	8ttFfPGV5b3yyxM1vf4UqvMsKf2UoobfGXS9q6V+kqDD5x8joAypkF6bOhZEvOpf
	jpjn2dqwJ437wVftqZd9ni8fsQG8WJ7z0DTfR7VUZYZ5XUpGLMMzDdmZZffHCvRU
	0sNMNRIolXvOLMq3+1hXBpM1wYt+9HT2WSIN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATISt/BxdOJD1wympOhlYVqn+olbMJLE
	CX7Tcan51JuuouIW/OjHrfkcMTyg0zSWt46pPSBuvZl8SBeeqNIIJJOSbhY9Na2B
	HML1fHsQKLYC1DK3mkxRCeU6zZLNYG2shGufLfTt1ef7IyxGhMc9sXJMdzZl3wgh
	4NUaWZscCGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32FD55F2E;
	Wed, 21 Sep 2011 18:03:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B90255F2A; Wed, 21 Sep 2011
 18:02:59 -0400 (EDT)
In-Reply-To: <8b522de3711f339eea264dd7d8e44682af6c4865.1316590874.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 21 Sep 2011 09:48:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78239222-E49D-11E0-B187-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181865>

Forgot to update a test or two that this breaks?
