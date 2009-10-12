From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Mon, 12 Oct 2009 15:52:46 -0700
Message-ID: <7vmy3w9qdd.fsf@alter.siamese.dyndns.org>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
 <20091012051442.GB23007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxTyb-0003VN-LW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbZJLWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbZJLWxg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 18:53:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbZJLWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 18:53:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A192356F47;
	Mon, 12 Oct 2009 18:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7LzkTuf/nKYzlX8T3HXXYahVAg=; b=P/2TzZ
	8BzDzJUQOYLYMqk7nUk7F1KZdn+q5VQqidQpCY/yrChjMf5xWUP5mnrcFl7JF+8Z
	bioKNgwS8LnlG4R/ZJtIF1eX/qD8OFsp+HEgX2BFGfaOX7fvPII98glDLlLn3h2C
	yzXibJI2PhQ8owfjCqxColO9fc0AVmjFUtGfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XvJTFef792eHFOO0Jw3xczu8AyTsPyU0
	KAHof0Fi4ERQAW7OvqlZRToVG/JrdYyzDopeJMQIhU0131Ex/lvsv4/xD1Tbw488
	svMJgG7g6P0lFYUpkKDDMdH0aqGpzAp23xJcSq4xgkeUXRgBkw7oPZh7Js2xVEmK
	TCCElGK5KZ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F58256F46;
	Mon, 12 Oct 2009 18:52:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38E056F41; Mon, 12 Oct
 2009 18:52:47 -0400 (EDT)
In-Reply-To: <20091012051442.GB23007@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 12 Oct 2009 01\:14\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7DF0622-B781-11DE-81E0-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130089>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 11, 2009 at 08:18:17PM -0700, Junio C Hamano wrote:
>
>> * jk/1.7.0-status (2009-09-05) 5 commits.
>>  - docs: note that status configuration affects only long format
>>   (merged to 'next' on 2009-10-11 at 65c8513)
>>  + commit: support alternate status formats
>>  + status: add --porcelain output format
>>  + status: refactor format option parsing
>>  + status: refactor short-mode printing to its own function
>>  (this branch uses jc/1.7.0-status.)
>> 
>> Gives the --short output format to post 1.7.0 "git commit --dry-run" that
>> is similar to that of post 1.7.0 "git status".
>> 
>> * jc/1.7.0-status (2009-09-05) 4 commits.
>>   (merged to 'next' on 2009-10-11 at 9558627)
>>  + status: typo fix in usage
>>  + git status: not "commit --dry-run" anymore
>>  + git stat -s: short status output
>>  + git stat: the beginning of "status that is not a dry-run of commit"
>>  (this branch is used by jk/1.7.0-status.)
>> 
>> With this, "git status" is no longer "git commit --dry-run".
>
> Hmm. I thought you wanted to re-order some of these for to put the
> porcelain and short formats into v1.6.6, but leave the status switchover
> for v1.7.0.

We could build an alternate history between 3fa509d..46b77a6, revert the
merges 9558627 and 65c8513, and merge the alternate history.  But is the
short format support so solid that it deserves to be in 1.6.6 in the
current shape?
