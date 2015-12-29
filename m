From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] apply: fix adding new files on i-t-a entries
Date: Tue, 29 Dec 2015 09:40:53 -0800
Message-ID: <xmqqoad9i256.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-4-git-send-email-pclouds@gmail.com>
	<xmqqpoxr9szy.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Ad5uihFqVBR4rLA4at_fBDx-yRx1VP1d-uR+4Uug6M9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 18:41:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDyGj-0006xU-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 18:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbbL2RlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 12:41:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753600AbbL2Rkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 12:40:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E73A738C0B;
	Tue, 29 Dec 2015 12:40:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Si5CQ3Q0xcoCTEDq/W4P7+JgqjY=; b=ZGFfdR
	UPVj0oBzuq+VwsvslHX+odKKfmld2YUrVUlj40mCvoH+83idGbJ/ZDMQO3KU31FT
	GquEpkI/golE/+M4pnEjEgiED4eJbN17GMve6gPEIRL8UG9ebwL0ZDVdj2uuQLzn
	G9NnzwJKkX/Ug4536Fm5oAQqFeB3UjjYCPk5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yPtAfFCAXEEvHEMFA3d/cU8YBMXw7Z3z
	mH1JEkDE8y9s+6SwOYIk8lBa/48VI5S1Z3cJPIBqBqbdma+MHMbZuQ8cLjhaH0S2
	wT8VszWkG+AiWLXsP+s8mAgyzP9fHg3JKNBjs9riK2MYYKpNekxioC4trCvaxs5J
	Em/4Iy1MSXg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDFBD38C0A;
	Tue, 29 Dec 2015 12:40:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 617C138C08;
	Tue, 29 Dec 2015 12:40:54 -0500 (EST)
In-Reply-To: <CACsJy8Ad5uihFqVBR4rLA4at_fBDx-yRx1VP1d-uR+4Uug6M9g@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 29 Dec 2015 21:02:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F822282-AE53-11E5-BF8D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283135>

Duy Nguyen <pclouds@gmail.com> writes:

> Not enough energy to go through this. Will do later and post new
> proposed commit message.

I do not have as much issue with the log message as what the patch
does, actually; this change does not look like a good one, which is
a more serious problem.
