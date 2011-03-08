From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rev-list-options.txt: typo fix
Date: Tue, 08 Mar 2011 11:56:28 -0800
Message-ID: <7vei6he68j.fsf@alter.siamese.dyndns.org>
References: <4D75E92C.1090506@drmicha.warpmail.net>
 <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px31T-0000f2-KM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab1CHT4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:56:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab1CHT4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:56:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83FC134DE;
	Tue,  8 Mar 2011 14:58:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MfOwv8K3sQTiTdGzuC8JuZo558o=; b=Y4wgo/
	b/lOZcGY3aZuk/H0y98jju4QQjzWDHylIRGGYTH4BBqyDMeZgzNfxyFDovdBZkq5
	/CsuNwJkbedBuvmwWNJsCs8Ptzx+Gjqtjj44OB4kob/6VLUBDJ/K9Qt/W8BVjM0X
	HHCBbZDiOuT8143h/RzYgUoI/mjxP2yQfMRH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdmDkkihja6VdWGt9mYVxkEzpCykCQ7T
	OW4LvMtY+0eVuP/WShDCgf/ZrlvM/xDt6MJBqt1fVJV4vD2vQkPKW2FUNErjy8Kd
	DubTIxZVql7xom9mD+qi190hv4tbC04OpiRNC9OBvcslnrki41sr6yeB8+fmygHc
	fRYesluFagM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F20334DD;
	Tue,  8 Mar 2011 14:58:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37E4334DC; Tue,  8 Mar 2011
 14:57:56 -0500 (EST)
In-Reply-To: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 8 Mar 2011 09:31:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F485E56-49BE-11E0-8926-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168683>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/rev-list-options.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 95d209c..76add13 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -165,7 +165,7 @@ limiting may be applied.
>  -n 'number'::
>  --max-count=<number>::
>  
> -	Limit the number of commits output.
> +	Limit the number of commits to output.
>  
>  --skip=<number>::

IIRC, the original was written using "output" as past particle of verb
"output" (as "output" in "the commits are output"), so strictly speaking I
don't think it is a typo.

But I like the new text better, so will apply ;-).
