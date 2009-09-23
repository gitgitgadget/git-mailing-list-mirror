From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Update the style of 'git-describe'
 command.
Date: Tue, 22 Sep 2009 17:07:46 -0700
Message-ID: <7v3a6eo759.fsf@alter.siamese.dyndns.org>
References: <1253663286-5919-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqFOp-0001vN-3S
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 02:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbZIWAHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 20:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZIWAHu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 20:07:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZIWAHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 20:07:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9F43CA0A;
	Tue, 22 Sep 2009 20:07:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y7ktw+uqRRafNU1sFYJT0DO4OpU=; b=GNFfq3
	vcKlUlK08Uo9kGWWA9EO9/2QRFugBT0It3v2IYRwBr9vWPQ015/o4dAA6FQGB158
	E4yHmfHbPbnZJ4eRfyWft0n13bZcdtFShs+3N74tRh3oxUFU5fnS+bbB3Ak68W5/
	Z3NK/M/Ll5wypV1ddHjPIGb61Qfj7/izRZcYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wiSxSTLj0dzYA8C2VCmHKb4mDu6R1aKh
	h7zMChvqowqkQzwLZt7mKYeecMHjH3QszHj5jKNvsI7YWA9VqizpfMx45k8VkFXi
	dlT6gC+4pqO5KF4vPEvkyWoGs9vGnm7lYWuK3EOlpLPtiklSb/ve/bCxFMT/Kg3f
	KEqbR2KsuLM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD06B3CA07;
	Tue, 22 Sep 2009 20:07:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 350513CA06; Tue, 22 Sep
 2009 20:07:48 -0400 (EDT)
In-Reply-To: <1253663286-5919-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Tue\, 22 Sep 2009 19\:48\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21F84E80-A7D5-11DE-AC55-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128964>

Thiago Farina <tfransosi@gmail.com> writes:

>  $ git describe -h
> -usage: git-describe [options] <committish>*
> +usage: git describe [options] <commit-ish>*

I think the first half of this line is correct but the other half is not.

$ git grep --color -c -e committish -- Documentation/
Documentation/git-describe.txt:6
Documentation/git-fast-import.txt:8
Documentation/git-name-rev.txt:1
Documentation/git-shortlog.txt:1
Documentation/gitcli.txt:1
Documentation/howto/revert-branch-rebase.txt:1

$ git grep --color -c -e commit-ish -- Documentation/
Documentation/git-rebase.txt:1
Documentation/git.txt:2
