From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating clone
Date: Thu, 22 Oct 2015 11:33:51 -0700
Message-ID: <xmqq4mhisqgg.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
	<5628EBAF.1030205@cetitec.com>
	<xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
	<562911AD.50004@cetitec.com>
	<xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
	<56292612.3020609@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:34:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpKgZ-00022J-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 20:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887AbbJVSdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 14:33:55 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757520AbbJVSdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 14:33:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 459BE240D6;
	Thu, 22 Oct 2015 14:33:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XtugGJL/KqdaIfU8UA/xPqu4C2s=; b=rrktBR
	7ysZJ6gWhUDafDRIB6R9rNjGzWVnORZHeETxHlS87FrnSNGjQLVUequ9jBRfbq3O
	qrLtM1e2rKjyyoFhJfSLt9B7D+3pMv8iLNHfgjEEVIckwy1+hn9XY6NAxzh2FBXa
	0zkdP//zFv/vvM4cPbPWYkjC9oPza1F3q+MA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLtzkDe4/pSl/iiO6qVJtjN+TtLMsyNE
	632ORPWkfDRaYQAJyZu/EH3apBxPYrbS5rTGe6/Yh5S9uCfyokTcJSnrF4eePtAt
	NG3B20OiOQ9ZLMPT5uB7GINhjd4sKjMzcNNIoZm37xTXWT3uLUnbGNzEijefBVIG
	ClNX3LR29rc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CBE5240D5;
	Thu, 22 Oct 2015 14:33:53 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFDC8240D4;
	Thu, 22 Oct 2015 14:33:52 -0400 (EDT)
In-Reply-To: <56292612.3020609@cetitec.com> (Alexander Riesen's message of
	"Thu, 22 Oct 2015 20:08:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71D8923C-78EB-11E5-8EC5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280069>

Alexander Riesen <alexander.riesen@cetitec.com> writes:

> Incidentally, what does "---" mean in the documentation hunk?

Heh, good eyes.  I was hoping that it would turn into an em-dash,
but it seems I just get three dashes instead.
