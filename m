From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Wed, 19 Sep 2007 21:05:46 -0700
Message-ID: <7vbqbym15x.fsf@gitster.siamese.dyndns.org>
References: <20070919202615.GK3076@jukie.net>
	<20070920025225.GA12076@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 06:06:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYDIe-0003Vz-Aw
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 06:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbXITEFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 00:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbXITEFw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 00:05:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXITEFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 00:05:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BB36136CE9;
	Thu, 20 Sep 2007 00:06:10 -0400 (EDT)
In-Reply-To: <20070920025225.GA12076@jukie.net> (Bart Trojanowski's message of
	"Wed, 19 Sep 2007 22:52:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58750>

> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 7cd0e89..f7a4891 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -29,6 +29,7 @@ SYNOPSIS
>  	     [ \--(author|committer|grep)=<pattern> ]
>  	     [ \--regexp-ignore-case | \-i ]
>  	     [ \--extended-regexp | \-E ]
> +	     [ \--invert-match ]
>  	     [ \--date={local|relative|default|iso|rfc|short} ]
>  	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
>  	     [ \--pretty | \--header ]
> @@ -238,6 +239,11 @@ limiting may be applied.
>  	Consider the limiting patterns to be extended regular expressions
>  	instead of the default basic regular expressions.
>  
> +--invert-match::
> +
> +	Show those parts of history that do not match any of the regular
> +        expression patterns.
> +

Tabs and spaces?

I am afraid people may not understand what "any of the regular
expression patterns" means.  How about being a bit more
explicit, like this?

	When filtering the commits based on log message (`--grep`)
	or people (`--author` and `--committer`), show commits
	that do not match the criteria.
