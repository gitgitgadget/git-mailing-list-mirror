From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules or similar for exercise/exam management
Date: Thu, 18 Nov 2010 14:32:53 -0800
Message-ID: <7vsjyyb6ui.fsf@alter.siamese.dyndns.org>
References: <201011181109.08345.trast@student.ethz.ch>
 <4CE5988F.7050309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>, in-gitvger@baka.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 18 23:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJD2Y-0001Q4-7w
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602Ab0KRWdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 17:33:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab0KRWdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 17:33:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 920632660;
	Thu, 18 Nov 2010 17:33:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yGccHY/eE5eAIBj9Qqnr6SlZBMM=; b=CIManV
	jrZB9TmmEDOisjovqepwD9B6kVbYCxZNZecZuN1qZQ9CYggMGT6fEgtz/8zNLT+N
	GLYkzzwfNVUB29lRjtnmNBiZs2yYUcCHTaM+TiBygZtdmQ6ghph5gJDvEZZQF6O5
	cMi8WgkjtCO7gmeecqM6DeCpC9ti02u82lO40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wkFwHRh4rhhWIYKaF3j/dZ4LIthk4Yk3
	kgyonsgUVu3GjfQZBDm2W7z9ZW/Leo/ObvXEia9o4YGjGaf3moui1jSPrF2z3vyk
	3d3jxOLHz3CRM1zwzQNp/BOaWWTmE61x43MofkNLTTRYMO4lb68dNsArqUlyDGci
	naIdpsBI1Aw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53EDC265F;
	Thu, 18 Nov 2010 17:33:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EE54265E; Thu, 18 Nov 2010
 17:33:06 -0500 (EST)
In-Reply-To: <4CE5988F.7050309@web.de> (Jens Lehmann's message of "Thu\, 18
 Nov 2010 22\:20\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3AC7694-F363-11DF-99C5-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161715>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> 3) never need to be aware of repo boundaries or manipulate sub-repo
>
> I think that this requirement is the hardest for any solution I know
> of or can imagine, as you hit these boundaries sooner or later either
> when you want to commit, push and/or when you have to resolve merge
> conflicts.

Just a quick sanity check.  When this "requirement" makes sense, does the
whole thing need to be a superproject with bunch of submodules, and why?
