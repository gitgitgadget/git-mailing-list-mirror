From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Fri, 29 Sep 2006 16:30:36 -0700 (PDT)
Message-ID: <20060929233037.42926.qmail@web31808.mail.mud.yahoo.com>
References: <200609292235.27478.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 01:30:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTRoY-0008V6-Qe
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWI2Xaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 19:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWI2Xaj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 19:30:39 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:39277 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932283AbWI2Xah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 19:30:37 -0400
Received: (qmail 42928 invoked by uid 60001); 29 Sep 2006 23:30:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0/4wXgl5cmabvpGohLkHZuLVwaiZKQjiz9l+lv+sRcwFvI6mgORVpEFhb2SiQY/TDw0WQ11WhYFr2mHjYbqD7mf5oc3zdEZlLm8BeiIiK30JjWejIRjs1cgN4Snu/lVRPQzoZ8G7zvUAVt2K6cJqYdazFdAYX/KObpA66kdLBmI=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Fri, 29 Sep 2006 16:30:36 PDT
To: Jakub Narebski <jnareb@gmail.com>, Junio Hamano <junkio@cox.net>
In-Reply-To: <200609292235.27478.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28136>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> As a interim solution it is a good idea, moreover with using $hash_base
> defaulting to HEAD instead of using HEAD literaly.
> 
> The correct solution would be to make "html" page (i.e. "blob" not 
> "blob_plain" view) also for binary files. <img> element for image/*
> mimetype, perhaps <embed> or <object>, or just plain link for other
> binary (not text/* or some application/*) types

We already do have a hash_base context. It is what allows us to
"select" a revision from shortlog and ask "tree", "history", etc
from there on, having set "h" and/or "hb".

What this patch does is simply set "h" and/or "hb" to
the string "HEAD" instead of the string "<SHA1 of HEAD>" when
h/hb is not defined.

    Luben


> 
> I was AFK for few days.
> -- 
> Jakub Narebski
> Poland
> 
