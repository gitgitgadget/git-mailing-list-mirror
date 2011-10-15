From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] t1402: Ignore a few cases that must fail due to DOS
 path expansion
Date: Sat, 15 Oct 2011 13:15:22 -0700
Message-ID: <7vobxhvrdl.fsf@alter.siamese.dyndns.org>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
 <1318632815-29945-3-git-send-email-patthoyts@users.sourceforge.net>
 <7vwrc6x1cp.fsf@alter.siamese.dyndns.org> <87k4862wmk.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCQX-0006u9-TO
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab1JOWJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:09:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab1JOWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 18:09:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF735B18;
	Sat, 15 Oct 2011 18:09:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Aqg+j0ZVZS4Y0OpygQpwtd6OOzs=; b=rJQddX4OTHKXQRLIK8m3
	3cOhE4BvnknlYV2nqxBra2IGMunuVdeZ+6dXANyWtSniIISuluPlIuxefDXgx8TO
	+JapqQzfwJUAPGac8+3zSalA+bUTSL8XqedlFLjj0b0O34kkgJbPr3TQPPOxxCM3
	yQYZxfgajnidbr8JbMk+ZMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HZ7XvI/NjhfzqAl/zXySOHg8YnvCoAwgql3S3kzGuo1Lcy
	bqzlnP4s3MtOuKAOEw6rEhJ/zy6FxrSWRLxARq8lBfok2wzbG5CCVHfvhZNn99m+
	7w9wTSoBsA7mJx6wF3BHoACke/a1JRMJsA882XfUxBQa+tKC4UGQ1F4ujKbF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C30D55B17;
	Sat, 15 Oct 2011 18:09:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 550165B16; Sat, 15 Oct 2011
 18:09:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 629C31E4-F77A-11E0-ABFE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183677>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>>
>>>  t/t1402-check-ref-format.sh |   15 +++++++++------
>>
>>Didn't we see a different patch that attempts to address the same issue
>>recently on the list from J6t, or is this a fix for a different problem?
>>
>
> You are correct - I'll leave this out of this series then. j6t's patch
> is an alternative fix for the same problem.

Thanks for checking.
