From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Wed, 20 Jan 2010 02:18:51 -0800
Message-ID: <7vockp3wqc.fsf@alter.siamese.dyndns.org>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXeQ-00034s-C4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab0ATKS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081Ab0ATKS6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:18:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab0ATKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:18:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75309923ED;
	Wed, 20 Jan 2010 05:18:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOV1gbDpTJsL0Bt9wHS8wdm2rBI=; b=oNEhrG
	skRcMHWw4cuex26C47tXS2bieCFgZD+8HTNQGYZWNN2d9JXzHcyJGPtRh81YilhZ
	Hzim5XpECfI4y97ccKbHAhK6ucIup7km+PFRkE1H9/+RnQXzsCEwZUeaKDpdrRvT
	WuMgLnbXqSqACoaZ+bvSjtUEuqN8CASK8xKdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRmu/iZv7IEcUsH85MfLpXLsvd7s/Bua
	+5SvqFXuJjmqXW6riJwjybcfWlzyA+vH4hsdSJ+BQvYzagQthLVdAIwSSw9RZMnD
	dd0Sa+e5UCIaAVi+fYJJbHg3SZRnXulVPMPRkW6bKcH5NT8up0qbZtgCvtSB2WiI
	m9PhUReQnQg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50FD6923EC;
	Wed, 20 Jan 2010 05:18:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAA0D923EB; Wed, 20 Jan
 2010 05:18:52 -0500 (EST)
In-Reply-To: <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Wed\, 20 Jan 2010 11\:48\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36E6A770-05AD-11DF-B6F7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137537>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Since local branch, tags and remote tracking branch namespaces are
> most often used, add shortcut notations for globbing those in
> manner similar to --glob option.
>
> With this, one can express the "what I have but origin doesn't?"
> as:
>
> 'git log --branches --not --remotes=origin'
>
> Original-idea-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---

Nice.
