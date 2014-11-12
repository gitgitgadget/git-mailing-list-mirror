From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Wed, 12 Nov 2014 10:00:29 -0800
Message-ID: <xmqqsiho47uq.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqvbmqg81g.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101305510.13845@s15462909.onlinehome-server.info>
	<xmqqwq739hau.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121209330.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XocDj-0008TJ-EW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 19:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbaKLSAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 13:00:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752993AbaKLSAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 13:00:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2F221C7C4;
	Wed, 12 Nov 2014 13:00:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lqcg1UU7k2N1rrRixoVZIWby8Io=; b=iAGU2TLoAaFubzz3brkF
	JmD/HUUnK8kGE+W4TWwy8APXE6zGSsRoVF2+T3NbMZPGrcIyEIBssxd8JEFoyWpM
	ZF4IZqpGVeZOMTjJKQOn5c7dPfCkZNVFTcp1qRXJU0XxCKnKRfoWbbiqEiXHtmUJ
	Il5uFbBT8AVWJaM0QcxXmFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RROPkj00s6EqGaywwVo3isQzFEBL3UgZFhEVqfmTW/KF4V
	YQ/6NdlkAIodytzjyR0/+qeZIu2QzhMfT97pRxCG98hGM5Lp6pa7DVmV7TCBcyEA
	eEVyau64AToscptO7l8PkScCKPhbFQKt0dQY633zPOcwdedv2ldMc3M2/dFfg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85DF61C7C3;
	Wed, 12 Nov 2014 13:00:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15E521C79F;
	Wed, 12 Nov 2014 13:00:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAAD7E8C-6A95-11E4-9452-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, here is my explanation: at the time I wanted to disprove that
> updateInstead could make sense, I wanted to offer a milder version of
> updating the current branch that left the working directory alone:
> detachInstead.
>
> Now, I never used it myself, but I use updateInstead extensively.

Sounds like updateInstead turned out to be useful enough to make
a "possibly more cautious" detachInstead unnecessary?  It probably
makes sense not to add it in that case, I would think.
