From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [Patch v3 0/8] Create single PDF for all HTML files
Date: Wed, 17 Oct 2012 13:24:59 -0700
Message-ID: <7vipa8onhg.fsf@alter.siamese.dyndns.org>
References: <2064042984.134573.1350493458315.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net,
	git@drmicha.warpmail.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 22:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOaB6-0007Ic-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 22:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab2JQUZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 16:25:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab2JQUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 16:25:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42047841E;
	Wed, 17 Oct 2012 16:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jX3tjpMChdG3kFBj/QGYuXgFKyo=; b=ExD06G
	NhDX6Lx5cmthP9ZEJECWnS8AmQyOeIiFTLIlS1Fx0J/9hEnr6kB1w4evShT+/lPg
	cKzIAGMlhB3VLewJvSJiYqcxOy6BZHHLjX95+suddBEez+QIZomSGa+CVX/xUXEr
	sQsu665p5mijI6ZWQu91BxcRSu8xuHKrssVow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M1XmQz4CRIyIaLk1tL5hFkAAQBArGPlI
	D9CBU/ywLVeD8O8HzrSx0MD0e4hA4g47YsGLqFTe4hc5NvJhv9RqFwHOMWbs1n0Q
	sIe7YsRxAxAXFSntw+U1OcVfxgZgFppVKleDf54TmWMA+NhZVI0MH9Je5f3VW69V
	SQ5B/Nl7vDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3078C841D;
	Wed, 17 Oct 2012 16:25:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510EB841A; Wed, 17 Oct 2012
 16:25:01 -0400 (EDT)
In-Reply-To: <2064042984.134573.1350493458315.JavaMail.ngmail@webmail22.arcor-online.net>
 (Thomas Ackermann's message of "Wed, 17 Oct 2012 19:04:18 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA404ED6-1898-11E2-8514-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207939>

Thomas Ackermann <th.acker66@arcor.de> writes:

> BTW1: As only the changes in the doc files where cherry-picked, currently on pu howto-index.sh
> will create invalid links in howto-index.html because it scans all .txt-files in ./howto for 
> 'Content-type: text/asciidoc' and if found, creates a reference to a html file. But these are not created
> for the new asciidoc files. So the changes in Documentation/Makefile which create html for the new  
> files should be merged also.

Ah, I didn't notice that.

That means that for the patch [6/8], which adds content-type to the
text files, to be complete, it needs to update Makefile to produce
html files from them.

Thanks.

> BTW2: The 'pretty-print shell script in update-hook-example.txt'
> part of my changes was left out from the merge to pu ...

Do you mean e2399e9 (Documentation/howto: convert plain text files
to asciidoc, 2012-10-16), or something else?
