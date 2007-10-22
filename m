From: "Scott R Parish" <srp@srparish.net>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Mon, 22 Oct 2007 14:59:01 -0500 (CDT)
Message-ID: <1193083141.v2.fusewebmail-240137@f>
Reply-To: srp@srparish.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 21:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik3Ql-0002VT-1A
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXJVT7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXJVT7F
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:59:05 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:56384 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbXJVT7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:59:04 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtpa (MailAnyone extSMTP srp)
	id 1Ik3QV-0000ef-4I; Mon, 22 Oct 2007 14:59:03 -0500
Received: from 127.0.0.1
        (FuseMail web AccountID 240137)
        by webmail.fusemail.com with HTTP;
        Mon, 22 Oct 2007 14:59:01 -0500 (CDT)
User-Agent: FuseMail W
X-Priority: 3
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62042>


> Alex Reisen, Mon, Oct 22, 2007 12:01:
> > +                strbuf_addch(out, ':');
>
> Shouldn't it break MingW32 native port?
>

<snip>

> > +        if (old_path)
> > +                strbuf_addstr(&amp;new_path, old_path);
> > +        else
> > +                strbuf_addstr(&amp;new_path,
"/usr/local/bin:/usr/bin:/bin");
>
> the default PATH is platform-dependent. Git is multi-platform.
> You should consider putting the path list somewhere in Makefile,
> config.mak or configure.
>

The original code was already doing both of these things (see git.c's
prepend_to_path())

sRp
