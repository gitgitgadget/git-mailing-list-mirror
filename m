From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 16:37:21 -0700
Message-ID: <xmqqd23y3r2m.fsf@gitster.dls.corp.google.com>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 00:37:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaYO0-0005Et-IT
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 00:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbCXXhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 19:37:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751842AbbCXXhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 19:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5A6B437E5;
	Tue, 24 Mar 2015 19:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aO5kxrO8Z3SKHjkpDLIvOtHU0uE=; b=aGCH+a
	ewX1H7n/fs0LVB0k6QMNNP0HkZMiBqYMuRM7BBzmNyXB4MnxZ1w/TVNnKEVTlRHY
	PoAe/ZrbbC2AO+4gaEBsHMRI4xFRfwB7+8HIPcELkcCKDO8gTTE4qx4jdQhyAGFp
	I7VCnQY2CRDdYquIPNlFG1lvSZ5BSXx3GqPoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E4ipug4ViKZcFuYIszIpeWSxlL7tCAB8
	pkgyX8h6/58uZkTXteNwVOZT5h4DrjKyW8olR8j8fpe3XxU7T6e/JbkLrgTIIj9D
	bqXI4t1N+EqZN+NBlKUX8NviBPSb2WXVr7TvoAbCX0uQpuMpabUAXFtQ6//i/uCp
	yBSWdAgkSHs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFC1C437E4;
	Tue, 24 Mar 2015 19:37:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 527B6437E3;
	Tue, 24 Mar 2015 19:37:22 -0400 (EDT)
In-Reply-To: <xmqqmw338khu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Mar 2015 14:35:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B80CB648-D27E-11E4-AED3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266238>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> This cycle is turning out to be a "shoot for product excellence"
> release.  About half of the commits that have been merged to the
> 'master' so far have also been merged to 'maint' and v2.3.4 has been
> tagged.

I've merged a few more topics to 'next' and hopefully will push the
result out in a few hours.

Some topics that are in 'next' but not in 'master' are high-impact
ones that I'd feel more comfortable if we cooked them there for a
bit more, and am planning to merge them (if there are no issues
discovered in the meantime, of course) after this cycle finishes,
but for others, I'm hoping to merge them to 'master' before we tag
the -rc0 preview release.

Please give them a good beating and report any regressions you find.

Thanks.
