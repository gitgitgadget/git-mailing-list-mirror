From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Fri, 28 Mar 2014 10:20:19 -0700
Message-ID: <xmqqvbuyb5po.fsf@gitster.dls.corp.google.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
	<5330196A.3030101@ramsay1.demon.co.uk> <53306910.3090807@gmail.com>
	<xmqqior2mbtx.fsf@gitster.dls.corp.google.com>
	<5333F1E6.5060009@gmail.com>
	<xmqqd2h7fvkw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:20:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaSD-0006Pm-S2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaC1RUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaC1RUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:20:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D02E177D55;
	Fri, 28 Mar 2014 13:20:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mPkpL8z15tgFkzob5FxnX6utQv0=; b=slizBH
	Gho3RLwUh216wrUfYH3Vh4LnFfbgbia8rZ2aX7h579Odj0pXGKJwWq3QreeumYiW
	Rd+l5fiW+ybsHj4vaMxr9AVtALWaQVqtFLV6yioVVOLUiElibZrxxEw1/8uiLIZX
	0vyTXX+5f+HZ6XOkQX97SWQbvA3Z2O11fhUCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cGTnSgXO5gv6iQw7cp83tQGHe+g5K8IM
	SjCelDQCK3o0tm02784juF1PSLZPQ+15rPdJCTiyF7K2c3LyrcBSm0lsFIesf4tI
	5WLqej948ZuXa4/4Jk0OAfQfIPsVBK0dxtK4H1CthY2esrFWkhnrCbl9Lkof17CJ
	I80x39Dp8e4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B83A277D54;
	Fri, 28 Mar 2014 13:20:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B6B77D51;
	Fri, 28 Mar 2014 13:20:20 -0400 (EDT)
In-Reply-To: <xmqqd2h7fvkw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 27 Mar 2014 09:35:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3D683BFE-B69D-11E3-B61E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245401>

Junio C Hamano <gitster@pobox.com> writes:

> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> If there is decision on how shortening should work for all the
>> options, maybe I could add a paragraph on that and make existing
>> options more consistent.
>
> We should strive to make the following from gitcli.txt apply
> throughout the system:
>
>  * many commands allow a long option `--option` to be abbreviated
>    only to their unique prefix (e.g. if there is no other option
>    whose name begins with `opt`, you may be able to spell `--opt` to
>    invoke the `--option` flag), but you should fully spell them out
>    when writing your scripts; later versions of Git may introduce a
>    new option whose name shares the same prefix, e.g. `--optimize`,
>    to make a short prefix that used to be unique no longer unique.
>
>> If so, '--valgrind' becomes impossible to shorten because there
>> is '--valgrind-only' that is a separate option.  Same for
>> '--verbose'  and '--verbose-only'.
>
> Correct.  If you really cared, --valgrind={yes,no,only} would be (or
> have been) a better possibility, though.

Also, these existing bits are simply being lazy.  You do not have to
emulate and spread the laziness.

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87f327f..f37973a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -209,10 +209,10 @@ do
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
 		valgrind=memcheck
 		shift ;;
-	--valgrind=*)
+	--va=*|--val=*|--valg=*|--valgr=*|--valgri=*|--valgrin=*|--valgrind=*)
 		valgrind=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
-	--valgrind-only=*)
+  	--valgrind-o=*|--valgrind-on=*|--valgrind-onl=*|--valgrind-only=*)
 		valgrind_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
 	--tee)
