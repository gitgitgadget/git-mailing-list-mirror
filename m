From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] clone,init: describe --template using the same
 wording
Date: Mon, 14 Feb 2011 11:54:01 -0800
Message-ID: <7vipwms886.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <4f337165179d071d7c54b442b7d3dd72406239b2.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:54:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4V7-0001mU-BU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab1BNTyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:54:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab1BNTyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:54:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0FE845D5;
	Mon, 14 Feb 2011 14:55:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEj4r4SLIe4gRZZko5PyLFjSKSw=; b=N9MyrO
	z02DExVLjpe3pSw8IrsAEH2v9WOmIBDqwy7Eyhp6aPYLEODZqtCdTTALPJz/fNLE
	tlQzjEUIIBFgwWH52zuuydUFQx76M4dQexcLoQ6i2hVQutrtbl8H6JbTnbK4LImX
	P6kgxAcM3OO/AeQQhxJMMiES04JaIB8xHb8ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cyJqV2mD+8ic547TtYIOvLq3VKfTeeL1
	CttgzbN/2bZY9OjPpFMNgZ9SdObDz+frD4lqVZeayoCzFy47/vPWfk9sDsxLSQPc
	P7DWchbD0mWnGEY+6sN0Au/yBAfKjsFToO+++DVN9c5DKbOJaorTMBHg1ozLC4QU
	3tmVrnuBX3s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDA3C45D4;
	Mon, 14 Feb 2011 14:55:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FD6E45D3; Mon, 14 Feb 2011
 14:55:07 -0500 (EST)
In-Reply-To: <4f337165179d071d7c54b442b7d3dd72406239b2.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 549B11A2-3874-11E0-8345-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166761>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This also corrects a wrong description for clone.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 82a6938..60d9a64 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -68,8 +68,8 @@ static struct option builtin_clone_options[] = {
> ...
> -	OPT_STRING(0, "template", &option_template, "path",
> -		   "path the template repository"),
> +	OPT_STRING(0, "template", &option_template, "template-directory",
> +		   "directory from which templates will be used"),
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index e3af9ea..4f5348e 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -419,7 +419,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
> ...
> -				"provide the directory from which templates will be used"),
> +				"directory from which templates will be used"),

Makes perfect sense; thanks.
