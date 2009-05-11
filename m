From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] bisect: make "git bisect" use new "--next-all" bisect-helper function
Date: Sun, 10 May 2009 17:44:02 -0700
Message-ID: <7v8wl4tqnh.fsf@alter.siamese.dyndns.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
	<20090509155548.5387.83292.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 11 02:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Jf5-0001dq-05
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 02:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbZEKAoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 20:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZEKAoE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 20:44:04 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50679 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZEKAoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 20:44:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511004402.EFBQ20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 May 2009 20:44:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id q0k21b0054aMwMQ030k2e7; Sun, 10 May 2009 20:44:02 -0400
X-Authority-Analysis: v=1.0 c=1 a=MDXuuuku1n8A:10 a=MPbockrkyBgA:10
 a=dIu3SnmMAAAA:8 a=5_JqO3WM4SLAExXBvCoA:9 a=Eh4_wYqezawq5xKTfLtr0RcKAUAA:4
 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118763>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch replace the "--next-exit" option of "git bisect--helper"
> with a "--next-all" option that does merge base checking using
> the "check_good_are_ancestors_of_bad" function implemented in
> "bisect.c" in a former patch.
>
> The new "--next-all" option is then used in "git-bisect.sh" instead
> of the "--next-exit" option, and all the shell functions in
> "git-bisect.sh" that are now unused are removed.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  bisect.c                 |    4 +-
>  bisect.h                 |    2 +-
>  builtin-bisect--helper.c |   14 +++---
>  git-bisect.sh            |  127 +---------------------------------------------
>  4 files changed, 13 insertions(+), 134 deletions(-)

Nice.

All patches looked sensible; will queue.

Thanks.
