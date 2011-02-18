From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 12:00:19 -0800
Message-ID: <7vvd0hnmek.fsf@alter.siamese.dyndns.org>
References: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
 <4D5E907D.2090808@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Fri Feb 18 21:00:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqWVJ-0003tw-24
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 21:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436Ab1BRUAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 15:00:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab1BRUAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 15:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 691B037C6;
	Fri, 18 Feb 2011 15:01:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fE+5Ze3zj5WHC8eWuahJQdFqK88=; b=ZHhnq+
	xFhM/dERpITBwEssOisSBkxATm8O5Q7uPciloucXuOqoyqpHXA8mXOTTATriUnXT
	/o/yqwkel6pHFKbJwqG3fsPkI40qrmJnv7R9Pf6yjFlQRCJ3KJq02XnxsKSClIeP
	gbLthXrw4MSINHOg/8k9+FyEm8dB7X7G+HgYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXwFclNIeKMqKClm96vHnD4eCLM4Ws5c
	3sQc4lVvXAW6c8vQZs/nx7rb0OSoRjGHzXHE11WLBXXeL+oZMMN8K3cEBfC2lRAP
	GESfsMJeJWK1fRdwdfZ1E5H7fY4zkPRvLHFthBoG/5uSP3iKDTg3AQ4XQMKscwSq
	zR2hvLzgIhU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D03D37C5;
	Fri, 18 Feb 2011 15:01:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD38137C1; Fri, 18 Feb 2011
 15:01:29 -0500 (EST)
In-Reply-To: <4D5E907D.2090808@letterboxes.org> (Nick's message of "Fri\, 18
 Feb 2011 15\:30\:05 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2A7C86E-3B99-11E0-9654-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167227>

Nick <oinksocket@letterboxes.org> writes:

> On 18/02/11 14:06, Alexey Feldgendler wrote:
>> I think I've found a bug. Here is how to reproduce.
>
> It looks like one I found in 1.7.0.4 - for which Elijah Newren submitted some
> patches, although I don't happen to know what their current status is.
>
>   http://comments.gmane.org/gmane.comp.version-control.git/155147

Isn't v1.7.4-rc0~101 a polished version of that one?
