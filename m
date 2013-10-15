From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: Fix asciidoc syntax of --*-pathspecs
Date: Tue, 15 Oct 2013 15:45:33 -0700
Message-ID: <xmqqli1ub1bm.fsf@gitster.dls.corp.google.com>
References: <1379962475-6880-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDMy-0001fP-GY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933805Ab3JOWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:45:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933522Ab3JOWpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:45:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E7D4A4A6;
	Tue, 15 Oct 2013 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LcPjFBXeFkTvtG6wukYVVn5fK5A=; b=i8fwps
	2hbUD+xgIzP1oFQvJ79LOVqH5c7JAOXDFEGIGK3MdeRI8CMrKiY2BI8mjCC8P4Fa
	4Y5lKMZ8U8A3Mfnx+WmnydKjQQ4TqFy9XJYAqgKq0q4ZbJ6rm3D3K3ni5dvPDkYx
	7bGUxwizIHlvQ8GjWbD8aTwLbzKiTGAIANpAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EPVS14uQCW0Jo9lcv237XLfSEyfHX7b6
	SRGZMJlY7qVCBWAmbIg/IBEqE0kr3R2TgAR05oJfYfDDzWV9stEU7RNzEvLndsNo
	LRJpit+j0JSNW9hSwJn35OToa8lK8AyVI3I4ZHg2ixCDmv7nh1/LzG5Ceqo6xMy/
	2QZ233tfv9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 775FE4A4A5;
	Tue, 15 Oct 2013 22:45:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C43CF4A49D;
	Tue, 15 Oct 2013 22:45:34 +0000 (UTC)
In-Reply-To: <1379962475-6880-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Mon, 23 Sep 2013 20:54:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80F14042-35EB-11E3-94D3-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236211>

Steffen Prohaska <prohaska@zib.de> writes:

> Labeled lists require a double colon.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---

Looks sensible; it would have been nicer if the log message said
something like

    I eyeballed the output from

        git grep '[^:]:$' Documentation/\*.txt

    and these are the only breakages of this kind

(which I did just now).

>  Documentation/git.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 5d68d33..4c2757e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -475,19 +475,19 @@ example the following invocations are equivalent:
>  	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
>  	variable to `1`.
>  
> ---glob-pathspecs:
> +--glob-pathspecs::
>  	Add "glob" magic to all pathspec. This is equivalent to setting
>  	the `GIT_GLOB_PATHSPECS` environment variable to `1`. Disabling
>  	globbing on individual pathspecs can be done using pathspec
>  	magic ":(literal)"
>  
> ---noglob-pathspecs:
> +--noglob-pathspecs::
>  	Add "literal" magic to all pathspec. This is equivalent to setting
>  	the `GIT_NOGLOB_PATHSPECS` environment variable to `1`. Enabling
>  	globbing on individual pathspecs can be done using pathspec
>  	magic ":(glob)"
>  
> ---icase-pathspecs:
> +--icase-pathspecs::
>  	Add "icase" magic to all pathspec. This is equivalent to setting
>  	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
