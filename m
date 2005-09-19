From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after GIT 0.99.7
Date: Sun, 18 Sep 2005 19:02:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181902210.9106@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 04:03:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHAze-0001yA-5A
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 04:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVISCCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 22:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVISCCv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 22:02:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932289AbVISCCv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 22:02:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8J22jBo001413
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 19:02:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8J22iJx006743;
	Sun, 18 Sep 2005 19:02:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8827>



On Sun, 18 Sep 2005, Linus Torvalds wrote:
> +++ b/compat/strcasestr.c
> @@ -0,0 +1,22 @@
> +#include <string.h>

That should be <ctype.h> of course.

		Linus
