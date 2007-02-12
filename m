From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Why a _full_ diff? (was: [PATCH] Char: serial167, cleanup (fwd))
Date: Mon, 12 Feb 2007 09:39:46 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 09:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGWj3-0002YB-KU
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 09:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbXBLIjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 03:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933124AbXBLIjt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 03:39:49 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:52979 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S933120AbXBLIjs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Feb 2007 03:39:48 -0500
Received: from chinchilla.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 41A3258ADF
	for <git@vger.kernel.org>; Mon, 12 Feb 2007 09:39:46 +0100 (MET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39384>

	Hi,

I received the email below, showing a _full_ (i.e. every single line) diff
between the old and the new version:

| Date: Sun, 11 Feb 2007 20:00:54 GMT
| From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
| To: git-commits-head@vger.kernel.org
| Subject: [PATCH] Char: serial167, cleanup
| 
| Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=44bafdf37b30234671d4e2fb595dea4c3717d089
| Commit:     44bafdf37b30234671d4e2fb595dea4c3717d089
| Parent:     30a063a900518926966f4d75333c1bfbde1658fa
| Author:     Jiri Slaby <jirislaby@gmail.com>
| AuthorDate: Sat Feb 10 01:45:08 2007 -0800
| Committer:  Linus Torvalds <torvalds@woody.linux-foundation.org>
| CommitDate: Sun Feb 11 10:51:28 2007 -0800
| 
|     [PATCH] Char: serial167, cleanup
|     
|     serial167, cleanup
|     
|     - Lindent the code
|     - remove 3 pointers from paranoia_check
|     
|     Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
|     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
|     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
| ---
|  drivers/char/serial167.c | 5616 +++++++++++++++++++++++-----------------------
|  1 files changed, 2792 insertions(+), 2824 deletions(-)
| 
| diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
| dissimilarity index 67%
| index af50d32..5fd314a 100644
| --- a/drivers/char/serial167.c
| +++ b/drivers/char/serial167.c
| @@ -1,2824 +1,2792 @@
| -/*
| - * linux/drivers/char/serial167.c
| - *

    [...]

| -#endif
| -
| -MODULE_LICENSE("GPL");
| +/*
| + * linux/drivers/char/serial167.c
| + *

    [...]

| +#endif
| +
| +MODULE_LICENSE("GPL");
| -
| To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html

At first I thought the new version had CR/LF line endings or so, but that
isn't the case.

Just using

| anakin$ git show 44bafdf37b30234671d4e2fb595dea4c3717d089 | diffstat
|  serial167.c | 3322 +++++++++++++++++++++++++++++-------------------------------
|  1 file changed, 1645 insertions(+), 1677 deletions(-)
| anakin$

shows that far from all lines were changed.

Gr{oetje,eeting}s,

						Geert

P.S. I'm not subscribed to git@vger.kernel.org, please CC me on replies
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
