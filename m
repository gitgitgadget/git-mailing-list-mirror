From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] docs: mention "-k" for both forms of "git mv"
Date: Mon, 12 Dec 2011 11:52:08 -0800
Message-ID: <7v1us94lg7.fsf@alter.siamese.dyndns.org>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075031.GA17532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:52:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBv6-0002Qg-GG
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab1LLTwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:52:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab1LLTwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:52:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9D785F2B;
	Mon, 12 Dec 2011 14:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j7L26AjhbgHeivged+o8u2XkzB8=; b=ABj9uX
	QFSv1OnQXSvmcTt2htrs+UTedHb9Z8/eRvIZK9T3rWF+2bI/yg+Z3va9lCeakx2G
	z9LMgR0kX00Ox369PJzroxtOrEOzoRLa201TP/eHDlMXUijkbwGxxFhHdQHnWWal
	4+xaTaNwSAwuke1yz0rIySYNl+NCi/PhCOTUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YWJYKEJZ281M65lxAKkJLf8KzrkIOhst
	Y5lXnLmw3BpclZrXZMArWcNVGzXYrTwLYFob61NLIU0IGHvtuCM0aih6JPiYpbJj
	P6aB/YQKwmb1LJY7aq9E0xcgwoEmCT8Wc/mye/dPMR1e3bu1t0KFnbmLNLGnkutd
	BChl933yB5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B152E5F2A;
	Mon, 12 Dec 2011 14:52:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47B935F27; Mon, 12 Dec 2011
 14:52:10 -0500 (EST)
In-Reply-To: <20111212075031.GA17532@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 02:50:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C75DA196-24FA-11E1-A989-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186939>

Jeff King <peff@peff.net> writes:

> I actually would rather just see:
>
>   git mv [options] <source> <destination>
>   git mv [options] <source>... <destination>
>
> but if we are going to go that route, we should probably decide on a
> style and convert all of the descriptions at the same time.

Also most commands when they use these multi-line synopsis style to
differenciate different invocation contexts do take different set of
options for different contexts, so we would need to update the option
descriptions to say "this option only makes sense in this context", etc.

>  Documentation/git-mv.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
> index b8db373..4be7a71 100644
> --- a/Documentation/git-mv.txt
> +++ b/Documentation/git-mv.txt
> @@ -15,7 +15,7 @@ DESCRIPTION
>  -----------
>  This script is used to move or rename a file, directory or symlink.
>  
> - git mv [-f] [-n] <source> <destination>
> + git mv [-f] [-n] [-k] <source> <destination>
>   git mv [-f] [-n] [-k] <source> ... <destination directory>
>  
>  In the first form, it renames <source>, which must exist and be either
