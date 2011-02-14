From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] commit,tag: use same wording for -F
Date: Mon, 14 Feb 2011 11:49:24 -0800
Message-ID: <7vr5bas8fv.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <bf5f004bd55e91e5491b0ac68237d8b98ef0c691.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4QT-0006zd-NE
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab1BNTtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:49:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1BNTtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EB6B453E;
	Mon, 14 Feb 2011 14:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PPprWvm8TDOgYgrhRWAoCWpy9Ig=; b=xjvTTS
	4Hr5gj6a5qCMgODbNscy2O4J/EaQad/he9mvN6c/qhNj5R1wd3KZZM34E+YJjxXN
	cY1bop44TDAhUgrgajDIBNYAQKpaphjf1gFHvIBeCOgQcxhEACeHolbgsGfmt6zS
	UqHKmCNqrzNcv1OT/+oX9NNlJGITW536tQhaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EX97F7AuX5+hOcVQ0reRvVq/otn0HpWD
	B0yXymt1f8hUD8am2OelLMa0i22w9t8jwlMEKE+ZieX284qZ+6rQZc2gMAEX86xL
	LJ7L90NvKm/zqbBsmoQyiLqBLgmLOyeOEI8vwTbczD27Lc0tgRzM1YzZtwBb7VVK
	oLSbVm4oH2k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52A0D453D;
	Mon, 14 Feb 2011 14:50:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77540453C; Mon, 14 Feb 2011
 14:50:30 -0500 (EST)
In-Reply-To: <bf5f004bd55e91e5491b0ac68237d8b98ef0c691.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF351906-3873-11E0-A10B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166758>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 03cff5a..8a534de 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -118,7 +118,7 @@ static struct option builtin_commit_options[] = {
> ...
> -	OPT_FILENAME('F', "file", &logfile, "read log from file"),
> +	OPT_FILENAME('F', "file", &logfile, "read message from file"),
> diff --git a/builtin/tag.c b/builtin/tag.c
> index aa1f87d..6408171 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -378,7 +378,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> ...
> -		OPT_FILENAME('F', NULL, &msgfile, "message in a file"),
> +		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),

Makes sense, thanks.
