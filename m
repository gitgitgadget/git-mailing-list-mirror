From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_[PATCH]_commit-tree:_remove_unused_#define?=
Date: Mon, 25 Jan 2010 10:17:50 +0100
Message-ID: <3b96b7e4.67f13727.4b5d61be.1391c@o2.pl>
References: <1264403143-11320-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?Q?Junio_C_Hamano?= <gitster@pobox.com>
To: git@vger.kernel.org, =?UTF-8?Q?Stephen_Boyd?= <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:18:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZL5C-00045o-8T
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 10:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab0AYJR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 04:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AYJR7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 04:17:59 -0500
Received: from mailout1.go2.pl ([193.17.41.11]:40774 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab0AYJR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 04:17:59 -0500
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id 9959A5D517D;
	Mon, 25 Jan 2010 10:17:50 +0100 (CET)
Received: from o2.pl (unknown [10.0.0.67])
	by mailout1.go2.pl (Postfix) with SMTP;
	Mon, 25 Jan 2010 10:17:50 +0100 (CET)
In-Reply-To: <1264403143-11320-1-git-send-email-bebarino@gmail.com>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137942>

> ---
> 
> The fixme looks very suspicious too...

According to git blame it belongs to the same revision as BLOCKING
 -- initial commit. So probably it can be removed with BLOCKING.

> 
>  builtin-commit-tree.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
> index ddcb7a4..90dac34 100644
> --- a/builtin-commit-tree.c
> +++ b/builtin-commit-tree.c
> @@ -9,8 +9,6 @@
>  #include "builtin.h"
>  #include "utf8.h"
>  
> -#define BLOCKING (1ul << 14)
> -
>  /*
>   * FIXME! Share the code with "write-tree.c"
>   */
> -- 
> 1.6.6.1.436.gaba7d
> 

-- Daniel
