From: Chris Wilson <cwilson@vigilantsw.com>
Subject: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 14:45:14 -0400
Message-ID: <20110525184514.GA20005@localhost>
References: <20110524210758.GH16052@localhost>
 <20110524224525.GI16052@localhost>
 <vpqfwo3ush3.fsf@bauges.imag.fr>
 <20110525150631.GA29161@localhost>
 <4DDD3A01.6040407@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJ5D-0004np-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab1EYSpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:45:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42005 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1EYSpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:45:19 -0400
Received: by iwn34 with SMTP id 34so6676946iwn.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 11:45:18 -0700 (PDT)
Received: by 10.231.11.68 with SMTP id s4mr4739956ibs.152.1306349118452;
        Wed, 25 May 2011 11:45:18 -0700 (PDT)
Received: from localhost (c-76-126-142-103.hsd1.ca.comcast.net [76.126.142.103])
        by mx.google.com with ESMTPS id 4sm3854189ibc.32.2011.05.25.11.45.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 11:45:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DDD3A01.6040407@elegosoft.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174446>

The assignment to fmt is dead and is also useless.

Signed-off-by: Chris Wilson <cwilson@vigilantsw.com>
---

On Wed, May 25, 2011 at 07:18:57PM +0200, Michael Schubert wrote:
> There already is a patch on its way:
> 
> http://article.gmane.org/gmane.comp.version-control.git/174378

Thanks! Well, I wasn't going to report this dead assignment since
it wasn't done recently, but now I want to figure out how to properly
submit a patch. :) Am I there yet? and thanks for the help.

Thanks,
CHris

 pretty.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index dff5c8d..5667c7f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1082,7 +1082,6 @@ void userformat_find_requirements(const char *fmt, struct userformat_
        if (!fmt) {
                if (!user_format)
                        return;
-               fmt = user_format;
        }
        strbuf_expand(&dummy, user_format, userformat_want_item, w);
        strbuf_release(&dummy);
-- 
1.7.5.2.354.g19aea
