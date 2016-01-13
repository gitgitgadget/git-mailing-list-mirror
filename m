From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix compile errors with MSys2
Date: Wed, 13 Jan 2016 11:31:10 -0800
Message-ID: <xmqq4mehnuo1.fsf@gitster.mtv.corp.google.com>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJR8X-00073t-Ju
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbcAMTbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:31:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755997AbcAMTbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:31:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA89F3A961;
	Wed, 13 Jan 2016 14:31:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EfuRRj6O4ZohgOrEAGH13xLhJRI=; b=lWPVZW
	4WXxKUnFg9a9hq0u71w+gsEouaajioR7C8ExKl7JxdYFvOpEbm9xDbwP9yk7w3B2
	26SOkM07dJL9iTt+hKzRDzzCpEa9bKX8AzGS5hH4pKV7lYAimdiWJYQD8UMqKnPz
	vaENaNSMdynX8mD+mN80m/SBTLyvxDQJOQmOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YMn0W1l/DJ8d7jzcxMfmCHAo8HHjtdzo
	/7gCB9CWLonYSXrXadzI8T6N9c+FJMBaJwfvLae/NW6xOcD3SdhDquXOtzKz128K
	vj9sVTctF/15ecrly9538gN443A+5t6wqnSCJl0PEduVokhLApaedo4F0awMrmMp
	5DDxpeipil0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A26CD3A960;
	Wed, 13 Jan 2016 14:31:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2602F3A95E;
	Wed, 13 Jan 2016 14:31:11 -0500 (EST)
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 13 Jan 2016 14:30:45 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33997A4A-BA2C-11E5-9C00-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283976>

It would really be nice to see the endgame of what this series
starts sometime not in too distant a future.  Many users in Windows
land would appreciate this effort, I am sure.

Thanks, will queue.
