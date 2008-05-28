From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 13:46:10 -0700
Message-ID: <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed May 28 22:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1SYF-0003Yb-Tq
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 22:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYE1UqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYE1UqY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 16:46:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYE1UqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 16:46:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98EDD69F5;
	Wed, 28 May 2008 16:46:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DB90969EF; Wed, 28 May 2008 16:46:17 -0400 (EDT)
In-Reply-To: <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
 (Geoffrey Irving's message of "Wed, 28 May 2008 12:42:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21C5B9F2-2CF7-11DD-B629-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83134>

"Geoffrey Irving" <irving@naml.us> writes:

> commit a1bac5e1aa52f9a78733aa35a0a7e820df618301
> Author: Geoffrey Irving <irving@naml.us>
> Date:   Wed May 28 12:38:11 2008 -0700
>
>     doc: mention git-patch-id in git-cherry documentation
>
> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
> index b0468aa..9817fb5 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -41,6 +41,8 @@ has been applied <upstream> under a different commit
> id.  For example,
>  this will happen if you're feeding patches <upstream> via email rather
>  than pushing or pulling commits directly.
>
> +For details about how patches are compared, see git-patch-id.
> +

Thanks.

In manual pages, "SEE ALSO" section is a more appropriate place to do this
kind of thing.
