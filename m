From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 14:07:47 -0800
Message-ID: <7vy6jszaz0.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
 <20100120205452.GA8843@coredump.intra.peff.net>
 <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
 <20100120213137.GA9107@coredump.intra.peff.net>
 <20100120214152.GC9107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:08:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiiW-0006O3-FZ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab0ATWH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851Ab0ATWH4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:07:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab0ATWHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:07:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6904892C22;
	Wed, 20 Jan 2010 17:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XvQMKcaCymWKk5UnOlAuTtbmqeU=; b=nGCdr4
	rbbqKii/9yKy+GCIAK8gCDa3mhcs8aDuu2cALhyTr9dAc0yxVpu3zUn0CpICH+gC
	bKE3l2cg+curbbite6OktWGayO/cqPnmKMxHu2O6Xl/3qA3Y56ofbrJ0+EI4hWQl
	1eOpD6N0vAIQVYOzfn1/MG6kp4ngTE2ZMZCII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pK8Xnuhfe/FEf1EnvWiG09T2XFdzCdYn
	2rSuZHr1opet1nUPJaBtuGqnTwf/nkedi5uNRJj/E1ipjNK8csxV2jE+vefdxazS
	sYK374+sIEtKSYptQA7bFj/+zZwu1avT9i7cLSMdCNsZum/1fcVleHG8sK8a6v4V
	SuscxP6cb0I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A7C92C21;
	Wed, 20 Jan 2010 17:07:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CB3B92C20; Wed, 20 Jan
 2010 17:07:48 -0500 (EST)
In-Reply-To: <20100120214152.GC9107@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 20 Jan 2010 16\:41\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40D847D0-0610-11DF-912D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137591>

Jeff King <peff@peff.net> writes:

> diff --git a/pretty.c b/pretty.c
> index 0674027..95fe39a 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1094,7 +1094,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
>  	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
>  		strbuf_addch(sb, '\n');
>  
> -	if (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW)
> +	if (context->show_notes ||
> +	    (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW))
>  		get_commit_notes(commit, sb, encoding,
>  				 NOTES_SHOW_HEADER | NOTES_INDENT);

Heh, without this hunk I would have thought Peff and Gitster were the same
person ;-).

Once you introduce --no-notes, the above condition would not work well.
