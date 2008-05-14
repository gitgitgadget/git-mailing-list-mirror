From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 11:46:45 -0700
Message-ID: <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
References: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Ian Hilt <ian.hilt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwM0z-0006aB-3o
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbYENSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbYENSqz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:46:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbYENSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:46:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 84EBF5926;
	Wed, 14 May 2008 14:46:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 81A2D5922; Wed, 14 May 2008 14:46:48 -0400 (EDT)
In-Reply-To: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com> (Ian
 Hilt's message of "Wed, 14 May 2008 14:30:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E49278A-21E6-11DD-8668-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82133>

Ian Hilt <ian.hilt@gmail.com> writes:

> git-describe: Make description more readable.

Thanks, both.  I think the above is meant to be on the Subject: line, and
the text certainly is more readable.

> Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
> ---
>  Documentation/git-describe.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index d9aa2f2..69e1ab7 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -13,9 +13,10 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  The command finds the most recent tag that is reachable from a
> -commit, and if the commit itself is pointed at by the tag, shows
> -the tag.  Otherwise, it suffixes the tag name with the number of
> -additional commits and the abbreviated object name of the commit.
> +commit.  If the tag points to the commit, then only the tag is
> +shown.  Otherwise, it suffixes the tag name with the number of
> +additional commits on top of the tagged object and the
> +abbreviated object name of the most recent commit.
