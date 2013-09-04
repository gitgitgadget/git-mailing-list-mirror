From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/11] Documentation/replace: list long option names
Date: Wed, 04 Sep 2013 13:45:54 -0700
Message-ID: <xmqqvc2gl3i5.fsf@gitster.dls.corp.google.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.46822.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJxm-0007Ci-IP
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759378Ab3IDUqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:46:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066Ab3IDUqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:46:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221513EA08;
	Wed,  4 Sep 2013 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKDul9dxMskDFj4E6SQaxM8IOF4=; b=mkpqX3
	cY1RVbaN/pFLfmK+npJ/nD5/xxxe3FKHXhra8t94Tj4xAY+iXgD94S/YZiMz7y6l
	CvwGjfeJ/SC4OnwOuN6RrmokYBqk9ZgxFn0UjQAxAB3MdTzRmPBdpoaOdup1PdNj
	KBHYDmuxHsDXENgZ8MPRlkAGnsZG8vihi76Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQ4lUUXTcRsafyLaL8XI//kMnJ3YMwBl
	J3nlrUfltwHrmKGbhlqk0jmavX1GeqdARdrkGPmq0YD5MkBIPHLH/YYOs9IJpQVB
	QfwtH5qFSPQCpTZOroZbb8X/K3QUczcRpk5gCA8RmUZrk6lGD7ZZ7nHWKepfkkOj
	CZkf7kPlGHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 623AF3EA02;
	Wed,  4 Sep 2013 20:45:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7E6F3E9F5;
	Wed,  4 Sep 2013 20:45:56 +0000 (UTC)
In-Reply-To: <20130903071026.29838.46822.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 03 Sep 2013 09:10:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFD95E12-15A2-11E3-8DEC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233874>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-replace.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index a2bd2ee..414000e 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -54,13 +54,16 @@ achieve the same effect as the `--no-replace-objects` option.
>  OPTIONS
>  -------
>  -f::
> +--force::
>  	If an existing replace ref for the same object exists, it will
>  	be overwritten (instead of failing).
>  
>  -d::
> +--delete::
>  	Delete existing replace refs for the given objects.
>  
>  -l <pattern>::
> +--list <pattern>::
>  	List replace refs for objects that match the given pattern (or
>  	all if no pattern is given).
>  	Typing "git replace" without arguments, also lists all replace

This should be in the same commit as what adds them.
