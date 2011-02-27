From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] git-add: make -A description clearer vs. -u
Date: Sun, 27 Feb 2011 15:35:28 -0800
Message-ID: <7vy651t5j3.fsf@alter.siamese.dyndns.org>
References: <4D68D630.9000608@drmicha.warpmail.net>
 <059f131e50675ac53d5d304a51530984e1b7b8a8.1298821535.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 00:35:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptq9W-00035O-0W
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 00:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab1B0Xfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 18:35:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1B0Xfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 18:35:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FA5E4489;
	Sun, 27 Feb 2011 18:36:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bJAdv9T53pa+SvFqG6d+Z1qoVc=; b=GouVuT
	0w+zS6XcPZxhvvK7t7tHjVOMN6glom/ql8lLa0lEP/u8UruENiMYNZXzsYCIHaN8
	cn+KPSjApRk/7fCXzgObgeWEuDJv41xU2kxul+1Of3qfHY9zJ+Jbo5GF4t8jKkEw
	wAYSyElgyy+LuCOhYHphNacOd5VCdj7dWMJrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpTAObILhqKvNo1r4jQmLxdjZaUi0WZC
	C8LSlFrgHsHZjf5rQxZMlVYCmkynTOsPiyLM883RmuqvovdJUqZt+Gy7yjrAiIka
	dForWOAdxCKGHkvIWX2OOMaqPFDy5Ru8QSnPr0i047j3DPUFbSpTadazQzE9axha
	j2OHZtMVz1Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C3DF4488;
	Sun, 27 Feb 2011 18:36:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 12D044487; Sun, 27 Feb 2011
 18:36:46 -0500 (EST)
In-Reply-To: <059f131e50675ac53d5d304a51530984e1b7b8a8.1298821535.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sun\, 27 Feb 2011 16\:50\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73A93C3A-42CA-11E0-95BD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168061>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, it sounds as if "notice removal of files" distinguishes "-A"
> from "-u", and there is no mention of the worktree.
>
> But both notice the removal, and only "-A" adds changes from untracked
> files. Say so.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks; I think the new wording is an improvement over the existing
message.  Applied.
