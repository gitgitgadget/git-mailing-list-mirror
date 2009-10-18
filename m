From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:31:54 -0700
Message-ID: <7v63aci8id.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEj-0005uX-OS
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbZJRXcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbZJRXcA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbZJRXb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:31:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 199DA7CC41;
	Sun, 18 Oct 2009 19:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VzkGVvu1gbRz1r6Pcn4X9xOeGmI=; b=lSX3EdcZDMsvETw/keruLnF
	5iTVMqR6wCRdlhbZvx0tKuOPCzS6OAFMA0oLKsieHw8BHj7jtdb/eHnEYfse6+lf
	p6HNRMxiTyCrmU7po3GljLDdUYFzMXtoxgT9nvzwOSdj3slPKtegar3W+rO3imqF
	6BjdwiLSODsu5lV0fIJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DS1fgFYTRlLUruEw0I9WjdqHr4vts3qOOqVBJrdlIels9Fvpv
	GJ8jqOTsZkBIjG5t5ld1gXPztGDNOATiHpE3sUJVNMUCmBvfpugJWcGlFCtDNp+m
	yC6sVBOPb7gDWAoD9E+moqYKvfcq3dsakzABuUVHtd1gsCg51iA9Sj26VI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDB4A7CC3E;
	Sun, 18 Oct 2009 19:31:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 944827CC3D; Sun, 18 Oct 2009
 19:31:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EA22EFE-BC3E-11DE-893E-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130622>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were 
> sensible, but I don't them in your tree. I didn't see much discussion 
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches 
> here that you may have discarded because the code was no good, and 
> if so I apologize for wasting your time, but I thought at least 
> some of them should be salvaged.
> ...
> From:	Jeff King <peff@peff.net>
> Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
> Date:	Wed, 23 Sep 2009 15:14:29 -0400
> Message-ID: <20090923191428.GA30104@coredump.intra.peff.net>
>
>     Bug. The script does a chdir() and then looks at the cvspsfile later. I
>     think "-A" would have the same problem. Here is a totally untested patch
>     to address the issue. Johannes, will this is_absolute_path actually work
>     on Windows? I think The Right Way would be to use
>     File::Spec::file_name_is_absolute, but I haven't checked whether that is
>     part of core perl and if so, which version it appeared in.

My understanding of this is that it is a typical "how about this" that is
still waiting for a follow-up discussion that will result in an eventual
solution.

> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re: Q: supplying large sets of path to git commands
> Date: Fri, 16 Oct 2009 15:08:07 -0700
> Message-ID: <7vtyxzrnzs.fsf@alter.siamese.dyndns.org>
>
>     Here is how one might implement it for diff/log family of commands that
>     use "setup_revisions()".
>
>     I didn't test it (of course) beyond running 
>
> 	./git diff --name-only HEAD | ./git diff --stdin-paths --stat -p

Ditto.
