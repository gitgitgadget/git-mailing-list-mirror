From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Sat, 16 Oct 2010 21:43:27 -0700
Message-ID: <7vvd515t00.fsf@alter.siamese.dyndns.org>
References: <201010061823.47475.agruen@suse.de>
 <201010070103.17689.agruen@suse.de> <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
 <201010141439.43168.agruen@suse.de> <20101014161636.GB16500@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6B-0003NB-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936Ab0JQEnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 00:43:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0JQEnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 00:43:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 215B8DFC16;
	Sun, 17 Oct 2010 00:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=J9YSV8UE/JdmyFbs0DdpVOzq02c=; b=M7dlcyjCWTsEe8+T4Rgn+sf
	7q0RWJ7WODpLm70chxwAWdbp0mW7VYeGqCF7WJ7T//iQvnol8lteBo6qhYkzh3RF
	J6J3W1EM+62dTy6hmjPbIEF8/i+++iFv3YqWzfykDheDrtrfgGaqWm4LQ+VmJB0g
	5u05la4Z+RufmsYOf6uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=M8jCFHv0Fkx+ZkRC+FA8j1OWWZyUH53IhtsFQE8FNE+CP6b0m
	EwvHERwSjqr9iHtT+5ceRHa6R/GFkDbDTtLKeNb8f2n0AZekDadH1EZ5lqIOeoQJ
	GwhBazjaxgYum11Ii7Rai/ql9NzVCOKfo0R1rldXleqUBAC4F70yCDHqdE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E23D5DFC11;
	Sun, 17 Oct 2010 00:43:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CB7DDFC0F; Sun, 17 Oct
 2010 00:43:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1887FB28-D9A9-11DF-9F81-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159192>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...
> At some point, the reader starts to wonder what "it" is. :)   (2)
> already has this problem, since the extended header lines actually
> precede the traditional diff rather than following it.
>
> How about:
> 
> 	What the -p option produces is slightly different[...]
>
> 	1. It is preceded with a "git diff" header[...]
> 	2. Next comes one or more extended header lines[...]
> 	3. The from-file/to-file header that follows uses filenames
> 	of the form a/file1 and b/file2 (where "a/" and "b/" can be
> 	replaced with some other string or removed depending on
> 	options used):
>
> 		--- a/file1
> 		+++ b/file2
>
> 	This header is omitted if[...]
> 	4. TAB, LF, double quote, and [...]

Quite sensible point to raise, which I completely missed.  Thanks.
