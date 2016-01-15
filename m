From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix compile warnings with MSys2's compiler
Date: Fri, 15 Jan 2016 15:09:21 -0800
Message-ID: <xmqqh9iefnj2.fsf@gitster.mtv.corp.google.com>
References: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:10:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDVI-0002mW-G5
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbcAOXJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:09:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbcAOXJY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:09:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BC0F3C23B;
	Fri, 15 Jan 2016 18:09:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6zwLfPFj7voSuQ7EzqFi0HzCsgQ=; b=UyE3NB
	k21v0clcoYCKJ9sW5C79qinB0aRtfaPGSf95jX9sAt/VmO4PupYI6WvWSEZ6N4IN
	TzBbcGAlh8lxNdVQteWFjHvivQzCEmUyIVBa4dDKqPqF0AnR2CmY84nNrOwMZtGp
	xC5Zl4w14Aknj85zBwRVKTEG03Sg7ZC/ATnD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t56NzaNep8HKz6bpsAwhZ5vdeaMdYDbo
	XpAFcnvlAgq4ItZGiiPeH2DderFGErn4Hex4H9TkEe+7jjenvJ0PWkEcgwL/0GUz
	8yv4/eExZIZ1ThcpYuJxnvFwkXQ1XteB6CPt6SOuP3H40dlgReYaVO35PUqb3Ji1
	nMtOQNik5pg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FBDF3C239;
	Fri, 15 Jan 2016 18:09:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE8163C236;
	Fri, 15 Jan 2016 18:09:22 -0500 (EST)
In-Reply-To: <cover.1452864241.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Fri, 15 Jan 2016 14:24:19 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03AEA762-BBDD-11E5-8021-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284229>

Thanks, queued.

The last one does look ugly as you said; I do not think of a better
alternative to offer, though X-<.
