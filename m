From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Fri, 11 Dec 2015 09:43:05 -0800
Message-ID: <xmqqmvtgg9ue.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<20151211001815.GB1581@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Dec 11 18:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Rir-0007oV-45
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 18:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbbLKRnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 12:43:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbbLKRnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 12:43:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 148C830895;
	Fri, 11 Dec 2015 12:43:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cWqm3b7EdBEKacMThUfxOzXU6I8=; b=rCFlTa
	W61Mrw3nNEOCeiSTJxhzF/rlqK9SLjlCFBeUAz/IhtZ4MBXSy4LacxDMmjbeoQNo
	lqhHaBS/bWFvZIjsgtJo4ZOuvibo91ThcXeuwQTilATBDOJSLUf2+YxhIL8vJ2VY
	lUifFhe08l+dgdfl4Pz6dpVxfBkO8DCCihC4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GoruaCM6pigsu/UbrDRSKmYyZWHCLUMZ
	B4FXXUp1VyRvnpfM8nxi+S00Mpu+vLGewYSC1/aYYErHsbUKRaBUc2UAbuCg7U0q
	Esu5NmkxbVhcvVzNfJmX9B3If6npKLrLMfAMuFdPV1OKMF80c9yJfX4zsKoxsuf9
	C/LmaPYr2jY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B81B30894;
	Fri, 11 Dec 2015 12:43:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69E4E30893;
	Fri, 11 Dec 2015 12:43:06 -0500 (EST)
In-Reply-To: <20151211001815.GB1581@serenity.lan> (John Keeping's message of
	"Fri, 11 Dec 2015 00:18:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2C576DE-A02E-11E5-B1DB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282263>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Dec 10, 2015 at 02:46:40PM -0800, Junio C Hamano wrote:
>> * jk/send-email-ssl-errors (2015-11-24) 1 commit
>>  - send-email: enable SSL level 1 debug output
>> 
>>  Improve error reporting when SMTP TLS fails.
>> 
>>  Waiting for a reroll.
>>  ($gmane/281693)
>
> It looks like this got lost in the noise:
>
> http://article.gmane.org/gmane.comp.version-control.git/281975

Indeed it was; thanks for a pointer.
