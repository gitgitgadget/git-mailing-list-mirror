From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] replace: add option to edit a Git object
Date: Mon, 19 May 2014 13:39:19 -0700
Message-ID: <xmqqr43py03s.fsf@gitster.dls.corp.google.com>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 19 22:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmUYq-0007fL-TV
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 22:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaESUjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 16:39:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59249 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaESUjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 16:39:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CDAB17AAE;
	Mon, 19 May 2014 16:39:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5COzMp+UNWemBxoKcw0mJg9A1aM=; b=Ac4cLx
	pp3srva4CxtDj3WB64aUjaLCLyYTFcnItDuAZAt6cHUQYjoNxfTndSA6totbI16T
	wcIycJJku0g+80j+YkVl0//gjeBQj40HUHa132LiS29EhIFqqu8Z0vhWlEWgnJEr
	Yfy0O3zNz0IQv3pZg+EEVhN7n446bxBzVTYk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzvFR0ja2ROivsaDl/Mm7nOnIKfZ2Ail
	MJBI/GEBso0d6zhYMn91EaawDfaLg3LHD1n2CNxj+AlovCHlRoMNjDYgPOZNOtTU
	WKkTaP6Ih/9oKHVJpHkQBQuxGGLuHMYrsDY/rtISnecVeiqiRay51zqfwzWnnxQ1
	/13gCtwweFo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33A2717AAD;
	Mon, 19 May 2014 16:39:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2761F17AA7;
	Mon, 19 May 2014 16:39:21 -0400 (EDT)
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 17 May 2014 14:16:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7ED5B96-DF95-11E3-838E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249620>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch series comes from what Peff sent in the following thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528
>
> The only changes compared to v2 are in the test (8/10) and documentation
> patches (10/10). Thanks to Peff.
>
> Christian Couder (6):
>   replace: make sure --edit results in a different object
>   replace: refactor checking ref validity
>   replace: die early if replace ref already exists
>   replace: add tests for --edit
>   replace: add --edit to usage string
>   Documentation: replace: describe new --edit option
>
> Jeff King (4):
>   replace: refactor command-mode determination
>   replace: use OPT_CMDMODE to handle modes
>   replace: factor object resolution out of replace_object
>   replace: add --edit option

Part of this is already in 'next'; I'd assume that the first four
can be discarded and it is safe to queue only the remaining six on
top of what we already have.

Thanks.
