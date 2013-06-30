From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: learn about --man-path
Date: Sun, 30 Jun 2013 15:59:32 -0700
Message-ID: <7vsizzi4rv.fsf@alter.siamese.dyndns.org>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
	<bc83f64cf17851022e0344b3eb693beda1bdd8b6.1371900318.git.john@keeping.me.uk>
	<20130630114106.GE2294@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Mon Jul 01 00:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtQaq-0007HW-0S
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 00:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769Ab3F3W7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 18:59:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab3F3W7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 18:59:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 029372CCA2;
	Sun, 30 Jun 2013 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=88jqX76+29Jc
	dG2ZyFoz734Ve2Q=; b=iYqg/oK6QUES3WV++IJTRUawGEz6LOa/KPAbABcqCvpF
	uOMtChUmDrNUrDpjkUtsi+O1n8wTPkeoWNtZLeGwsCTHkmwYNwV1uZgPwmcMHii7
	UBnxqBvr/COn4/rsVavYbh5vzBoXRdry7G8RxDodb7yegvkby2cM0cTdmRK0dXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kRNgKe
	B9qVTq0/OcSRvD/ei7oFkWn2Bo/5szZ2tip6MSGoPaf+m453zzGBuRmmSKOlOnP9
	qf9zttVUVumR2a8JkCDEc/XuqLGZW8wXAQ/ts2oA1nO9rM8Mf2WvkZE4ASpXr73e
	URxialxX2W8BDMztpVp5XUk1YKGu0NQHAUB9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE6CD2CCA1;
	Sun, 30 Jun 2013 22:59:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 828A12CCA0;
	Sun, 30 Jun 2013 22:59:34 +0000 (UTC)
In-Reply-To: <20130630114106.GE2294@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Sun, 30 Jun 2013 13:41:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB428420-E1D8-11E2-A56B-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229290>

SZEDER G=C3=A1bor <szeder@fzi.de> writes:

> Without the '-c' part it's "obviously correct" and together with patc=
h
> 1/2 is
>
> Acked-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Thanks, both.  Will queue.
