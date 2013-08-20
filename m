From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] gitweb: vertically centre contents of page footer
Date: Tue, 20 Aug 2013 12:53:59 -0700
Message-ID: <xmqq1u5ow33c.fsf@gitster.dls.corp.google.com>
References: <cover.1377019362.git.dot@dotat.at>
	<5c4afd189553d0f1e83b0c2b9758643deba5a671.1377019362.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBs0H-0004Cf-1N
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab3HTTyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:54:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab3HTTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:54:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CF993A9CA;
	Tue, 20 Aug 2013 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHEX02YPIpmRDFnP43N2D07sagQ=; b=nxYgzl
	i/XwQFvpoFnEPaQ3zGnzESKtoZSENbVOX6sjGOyrX7t9dVO0AjonylhLLT3lq6wi
	TF+MNIB9ehBMtyRPOZ4SOJBVulggJdlYcTdQ0XMHoDhSTUYRGr0pDjVTWGy932Yz
	lvFy2qq9bqRU5m3ZLYbdhQkqwCLk9jPIFKuGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHrwkI0g3xVOdT4D96V5mbxH7l1pABML
	6ncVNK7ags52Qe4y9siWTtwL8qjgx/M6+Xs05q4LnR5TCcx8Dh6QgHtS5OwC0xj/
	P+UKKsw/y7tTguiFCYUM+1cBWRkunT9Jsn3Ob2O7eSDbaT2StzyajaagQJQIsu9n
	oBMicDNQKYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F30D3A9C9;
	Tue, 20 Aug 2013 19:54:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53FB33A9C6;
	Tue, 20 Aug 2013 19:54:01 +0000 (UTC)
In-Reply-To: <5c4afd189553d0f1e83b0c2b9758643deba5a671.1377019362.git.dot@dotat.at>
	(Tony Finch's message of "Tue, 20 Aug 2013 17:59:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 426E0944-09D2-11E3-8A6E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232642>

Tony Finch <dot@dotat.at> writes:

> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  gitweb/static/gitweb.css | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index a869be1..3b4d833 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -68,12 +68,13 @@ div.page_path {
>  }
>  
>  div.page_footer {
> -	height: 17px;
> +	height: 22px;
>  	padding: 4px 8px;
>  	background-color: #d9d8d1;
>  }
>  
>  div.page_footer_text {
> +	line-height: 22px;
>  	float: left;
>  	color: #555555;
>  	font-style: italic;

Hmmm, is it a good idea to do "px" here, or are they ways to do
relative to x-height or something to make sure the text fits?
