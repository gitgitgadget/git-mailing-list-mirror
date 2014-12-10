From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/18] Optionally ignore specific fsck issues completely
Date: Wed, 10 Dec 2014 10:07:14 -0800
Message-ID: <xmqq8uifidkd.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<d278090ef5a49b887e329dc16aaeb7b6c69dcaac.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylfZ-0008Dg-Kq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbaLJSHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:07:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932490AbaLJSHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:07:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD7E02289D;
	Wed, 10 Dec 2014 13:07:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fY/gd2/kdSnFlB2OYc1Ta4vBEtQ=; b=NEP34J
	GzGaOLtXSYpc4G5a6oh7GJEwP4YlgX0WjV/OwmC4irAho0DVGVf79EaU+r/j175X
	l+uVFU1hFxcENTB3IjyjLyVJlHBvD2q6eCZWX2oB+kYWVYa2yQGdjOQLuljjnIwS
	046B1fJbfTRpPujC88Z6dS6PSdjw5nUf6nu+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vLnzKjJk2Sz2HI0+dit03jTiq09kqcAw
	tCwlykwrDM847Igf0hCrWbVtXU3P7Cq6odf/U13dOl5k4uGrey0jF16i88u+myNU
	EXZfOPPVSrUDsiF5mgYFICyKc9Ju/r10G03R2FPpNoWNtd66JwN6XhFe6MnvWGpr
	nB/jz6zvGv8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2EBC2289C;
	Wed, 10 Dec 2014 13:07:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 509642289A;
	Wed, 10 Dec 2014 13:07:15 -0500 (EST)
In-Reply-To: <d278090ef5a49b887e329dc16aaeb7b6c69dcaac.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:21 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F311002-8097-11E4-8574-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261231>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> An fsck issue in a legacy repository might be so common that one would
> like not to bother the user with mentioning it at all. With this change,
> that is possible by setting the respective error to "ignore".

Makes sense.
