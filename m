From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Specified the expected formats of dates and timestamps
 in rev-list-options.
Date: Mon, 10 Mar 2008 23:48:22 -0700
Message-ID: <7v1w6heoy1.fsf@gitster.siamese.dyndns.org>
References: <FC7C7E68-1D91-4719-9D11-8F65DEA43AFB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 07:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyIV-0004IU-Ih
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 07:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbYCKGsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 02:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYCKGsg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 02:48:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbYCKGsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 02:48:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 474A92DB1;
	Tue, 11 Mar 2008 02:48:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 984AA2DB0; Tue, 11 Mar 2008 02:48:31 -0400 (EDT)
In-Reply-To: <FC7C7E68-1D91-4719-9D11-8F65DEA43AFB@gmail.com> (Kate Rhodes's
 message of "Mon, 10 Mar 2008 23:41:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76801>

"Rhodes, Kate" <masukomi@gmail.com> writes:

> The docs didn't give users any indication of the expected format of
> dates or timestamps. Now they do.
>
> ---

Please look at other commits and follow the examples.  Even though you are
describing what you did in the past, the title line do not use past tense
(e.g. "Distimmed doshes"), but imperative mood (e.g. "Distim doshes").

Sign your patch.

> --since='date', --after='date'::
>
> -	Show commits more recent than a specific date.
> +	Show commits more recent than a date specified relatively
> +	(e.g. "2 hours ago") or with any ISO 8601 or RFC 2822
> +	date syntax.
>
> --until='date', --before='date'::
>
> -	Show commits older than a specific date.
> +	Show commits older than a date specified relatively (e.g.
> +	"2 hours ago") or with any ISO 8601 or RFC 2822 date syntax.
>

s/any //;

How about giving a few examples after this entry instead?

> --max-age='timestamp', --min-age='timestamp'::
>
> 	Limit the commits output to specified time range.
> +	The 'timestamp' should be the interger seconds since the epoch.

"the number of seconds since the epoch".

> --author='pattern', --committer='pattern'::
>
> --
> 1.5.4.1.1278.gc75be
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
