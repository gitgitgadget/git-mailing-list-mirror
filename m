From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] The name of the hash function is "SHA-1", not
 "SHA1"
Date: Mon, 15 Apr 2013 11:15:39 -0700
Message-ID: <7vtxn7slro.fsf@alter.siamese.dyndns.org>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
 <1781595479.996520.1366048144788.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnwQ-0005X9-KY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3DOSPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237Ab3DOSPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:15:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B106D16FA7;
	Mon, 15 Apr 2013 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=X1YMJxknZcPewY1pvxOKI5KbeCo=; b=s6SG81DseH/6LBwQ+rYi
	+i8L2qbGOEQI1W+tvn4/LtVNKnUacr8WDJc07olAzNhiWwtxLD7Af1Wur/riN2uO
	wUN86eadENB84bd5qVi3Wl7HeT7XiI40IZE20SAK8XBMmPu/sch6UlbhTsUt7qK7
	Kkt2oo7Eu+xAmVcCL+j84bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rflCdbelK5dKGFHhF88hBcqdeqUB8SY5r6THR3ngxlD5tW
	RF4HYCvV3k6SyOh9Xak/eIK1Ept0wi9m2FnA0pm/zjFB6sr7uGeqm2qSsaJekUyB
	bi4MThrOaQRTdITIdrrLQsihWu7qaAqjNkjp6mesNeVWrQR38x/48vOi/23Xo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A53DD16FA4;
	Mon, 15 Apr 2013 18:15:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 279F716FA2; Mon, 15 Apr
 2013 18:15:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B2F2828-A5F8-11E2-AF4C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221281>

Thomas Ackermann <th.acker@arcor.de> writes:

> Use "SHA-1" instead of "SHA1" whenever we talk about the hash function.
> When used as a programming symbol, we keep "SHA1".
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

Thanks.  Will queue as-is for now, but I wonder if we want to fix
them to more official "object name", if we are going to the trouble
of fixing all of these.  It depends on how many places already
correctly spell SHA-1, I guess.

>  Documentation/config.txt                              |  2 +-
>  Documentation/git-cat-file.txt                        |  6 +++---
>  Documentation/git-describe.txt                        |  2 +-
>  Documentation/git-fsck.txt                            |  4 ++--
>  Documentation/git-index-pack.txt                      |  2 +-
>  Documentation/git-ls-files.txt                        |  2 +-
>  Documentation/git-merge-index.txt                     |  2 +-
>  Documentation/git-pack-objects.txt                    |  2 +-
>  Documentation/git-patch-id.txt                        |  2 +-
>  Documentation/git-replace.txt                         |  4 ++--
>  Documentation/git-rev-parse.txt                       |  4 ++--
>  Documentation/git-show-branch.txt                     |  4 ++--
>  Documentation/git-show-index.txt                      |  2 +-
>  Documentation/git-show-ref.txt                        |  4 ++--
>  Documentation/git-tag.txt                             |  2 +-
>  Documentation/git-update-index.txt                    |  2 +-
>  Documentation/git-verify-pack.txt                     |  4 ++--
>  Documentation/git-verify-tag.txt                      |  2 +-
>  Documentation/git.txt                                 | 10 +++++-----
>  Documentation/gitcore-tutorial.txt                    |  8 ++++----
>  Documentation/gitdiffcore.txt                         |  2 +-
>  Documentation/githooks.txt                            | 10 +++++-----
>  Documentation/gitrepository-layout.txt                |  2 +-
>  Documentation/gittutorial-2.txt                       | 16 ++++++++--------
>  Documentation/howto/recover-corrupted-blob-object.txt |  6 +++---
>  Documentation/pretty-formats.txt                      |  2 +-
>  Documentation/revisions.txt                           |  4 ++--
>  Documentation/technical/api-sha1-array.txt            |  4 ++--
>  Documentation/technical/pack-format.txt               | 14 +++++++-------
>  Documentation/technical/pack-heuristics.txt           |  2 +-
>  Documentation/technical/shallow.txt                   |  4 ++--
>  31 files changed, 68 insertions(+), 68 deletions(-)
