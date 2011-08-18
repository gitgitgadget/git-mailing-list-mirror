From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Thu, 18 Aug 2011 15:34:49 -0700
Message-ID: <7vhb5e73hy.fsf@alter.siamese.dyndns.org>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
 <4E4D7DD3.2000701@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Aug 19 00:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBAu-0007eq-LF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1HRWew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab1HRWew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:34:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0A944FE;
	Thu, 18 Aug 2011 18:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AthRQhVhFkxI8Vs9IG9nM2+WOd8=; b=W3BiE9
	kJ+qYish+fPRY90AznvPmZJoA7UaqIiY2KnN+TDmHOVeBfDywMhsAdqg7IPPOJpX
	F733JuNZvB4OnqVU0LR/vk4GR5shQs7UGjmtKLN2cwOOWskyaGRpUO1vIoyhQzBc
	LkrFPlmDgeDBNLscyff9/v/XDxpVsk5Z8Gg7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TXSExzuylG79MEWXSoGejHE481S+xYkx
	WPd6AQ6MvRZLPwD5bq+R2MLet+vkl7FG/yFPEjMrlcyLLg6151N2Nlys2OGq9qDd
	jCgCjXMd7CmLm/O8nkaWyuKnBDROz+LvlMPYG9HnEEGbAW1TGQPzLB6lNxBcLI0e
	itWeht1cX5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A1D44FD;
	Thu, 18 Aug 2011 18:34:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C0444FC; Thu, 18 Aug 2011
 18:34:50 -0400 (EDT)
In-Reply-To: <4E4D7DD3.2000701@obry.net> (Pascal Obry's message of "Thu, 18
 Aug 2011 23:02:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 493D385A-C9EA-11E0-A311-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179648>

Pascal Obry <pascal@obry.net> writes:

> Junio,
>
>> * po/cygwin-backslash (2011-08-05) 2 commits
>>   - On Cygwin support both UNIX and DOS style path-names
>>   - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep
>>
>> I think a further refactoring (no, not my suggestion) was offered?
>
> I think the current patchset is fine. It is always possible to improve
> things but the current patch goes in the right direction. So to me it
> is ready as-is.

Not very assuring to hear that only from the original submitter, no?
