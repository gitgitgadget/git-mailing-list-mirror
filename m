From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull.txt: Mention branch.autosetuprebase
Date: Fri, 03 Dec 2010 11:36:57 -0800
Message-ID: <7v1v5yps12.fsf@alter.siamese.dyndns.org>
References: <1291364454-9849-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Fri Dec 03 20:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObRR-0007ed-Ud
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0LCThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:37:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0LCThF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:37:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45B8A2837;
	Fri,  3 Dec 2010 14:37:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGr67WeL84W/nAI96KzAvrmMNE0=; b=w9L9p2
	I/KebA0ShvsNC6CrJpp1voPB/ZhGtTahEICBiWjek3prIUQzqcMhFSKF5CoDhFKw
	QwucdzMVaKY9rouYPGXkKbRfZZ57XvfOfBKeZOvv68aDVHugWElbXtfrKyA09i1y
	RcVdL4+rAsPlhDd0nlRI1jvmnYQHGlQgAd2nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngTroNETls8GwCrs5zbxbtTQHk1YcNff
	UaC3vhii4IuiTHbOlt3vXcNVNlTasGh+8RRHf/6ft7SZz5S6Goe+VwoFSf7ZwJDT
	WiDU39I8MBfRj//EcCzRn09371e7bfjhkZ6j13i3qlxswxSbpJ96S8neyTRyFo8A
	yvXlnMctil8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2283C2835;
	Fri,  3 Dec 2010 14:37:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1400D2833; Fri,  3 Dec 2010
 14:37:18 -0500 (EST)
In-Reply-To: <1291364454-9849-1-git-send-email-jari.aalto@cante.net> (jari
 aalto's message of "Fri\,  3 Dec 2010 10\:20\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF670BA6-FF14-11DF-BC91-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162838>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
>
> In "Options related to merging" mention also related option
> branch.autosetuprebase in git-config(1).
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-pull.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index e47361f..7b4caac 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -98,8 +98,9 @@ include::merge-options.txt[]
>  	fetched, the rebase uses that information to avoid rebasing
>  	non-local changes.
>  +
> -See `branch.<name>.rebase` in linkgit:git-config[1] if you want to make
> -`git pull` always use `{litdd}rebase` instead of merging.
> +See `branch.<name>.rebase` and `branch.autosetuprebase` in
> +linkgit:git-config[1] if you want to make `git pull` always use
> +`{litdd}rebase` instead of merging.

Thanks; will queue.
