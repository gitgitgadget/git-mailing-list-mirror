From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/31] rebase -i: support --stat
Date: Tue, 28 Dec 2010 15:36:46 -0800
Message-ID: <7vpqsltqpd.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com>
 <alpine.DEB.1.00.1012281858300.1794@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 29 00:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXj6N-00004q-Nj
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 00:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0L1XhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 18:37:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0L1XhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 18:37:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 948CC3112;
	Tue, 28 Dec 2010 18:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dB8Zi+I7rXg9R++8tTNW2b7opEg=; b=pxX3EZ
	sw+wURAsPFZOkBsrVNcOJNkKtzHHgEjXTeKjdl0WfIy3a3jzvK9y7K9tJSEtzYNq
	nM3i65auK/qQ+fMIQQiR/NlBPam79d2kqC0kBFvsi7oElTeqBFBk0dnIkzExNZYN
	Ic5l9Kk7B6q3U3DDUcFNqbn74IZPEF1+SvnUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kT9W28CSjo+brxcfo26APlnERBrxSkpx
	7bFSIKnU+KC1UmAQrIdk++yRQyGrHJcwajfzklr6rhZSRAYu+JVNCrYeF1X0aP3v
	b24ocfxXEU5jq4DgZjVxVTcS1x4fv8LrWhBr73x0cwdPKSvgGf4/DsEakwK/GPDB
	mEGNcf3gblc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E87F3111;
	Tue, 28 Dec 2010 18:37:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 19ACE3110; Tue, 28 Dec 2010
 18:37:20 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1012281858300.1794@bonsai2> (Johannes
 Schindelin's message of "Tue\, 28 Dec 2010 18\:59\:46 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E7F4A70-12DB-11E0-8251-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164296>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 28 Dec 2010, Martin von Zweigbergk wrote:
>
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 229e8d2..0fc580a 100755
>
> Hmpf... After a rebasing merge to junio/next:

The series applied cleanly near the tip of my 'master'.  I've been
preparing to push out 1.7.4-rc0 so the commit I applied the series was
probably a few commits ahead of the public 'master', but I don't think
there is anything that may conflict with or may be required for this
series to make any difference.

Please check tonight's 'pu' where the series is parked.

Thanks.
