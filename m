From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #06; Sat, 24)
Date: Mon, 26 Jan 2009 09:47:02 -0800
Message-ID: <7vy6wy6ju1.fsf@gitster.siamese.dyndns.org>
References: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
 <497D6BA7.4070409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVaq-0003qQ-Kg
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbZAZRrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbZAZRrL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:47:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbZAZRrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:47:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A8CB1D57A;
	Mon, 26 Jan 2009 12:47:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E8E271CE64; Mon,
 26 Jan 2009 12:47:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A83018E-EBD1-11DD-BB53-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107240>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> * sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
>>  - Windows: Revert to default paths and convert them by
>>    RUNTIME_PREFIX
>>  - Compute prefix at runtime if RUNTIME_PREFIX is set
>>  - Modify setup_path() to only add git_exec_path() to PATH
>>  - Add calls to git_extract_argv0_path() in programs that call
>>    git_config_*
>>  - git_extract_argv0_path(): Move check for valid argv0 from caller
>>    to callee
>>  - Refactor git_set_argv0_path() to git_extract_argv0_path()
>>  - Move computation of absolute paths from Makefile to runtime (in
>>    preparation for RUNTIME_PREFIX)
>> 
>> We should move this to 'next' soon with J6t's blessing.
>
> I've been using this series for a few days now without problems:
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.  I take that as not just "have been using this and no breakage
observed" but also "of course the patches themselves make sense to me".
