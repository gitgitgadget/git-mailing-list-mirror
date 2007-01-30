From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: How to enhance merge commit message ?
Date: Tue, 30 Jan 2007 11:23:59 +0600
Message-ID: <200701301123.59687.litvinov2004@gmail.com>
References: <200701301032.24917.litvinov2004@gmail.com> <7v8xfl6s27.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 06:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBlTd-00045g-45
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 06:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965406AbXA3FYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 30 Jan 2007 00:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965410AbXA3FYK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 00:24:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:43598 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965406AbXA3FYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jan 2007 00:24:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1442181uga
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 21:24:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L2vFJyH4/nfoscyKYQ/jxt1ybBRkFJp88WoYRg6NONQBKjsUvp6BHRfq7tXyjsuNJuvEpAWHPXDhf8C3s5JPITj1WxGMXaFhZ0DJxjbb+K46yFByK44wBwHY5dMvCKFUu5Ap8kUSOw0ncqUl5nZKLZywPXOJcS7bFdJ6FQO9gXg=
Received: by 10.66.252.4 with SMTP id z4mr9261346ugh.1170134646794;
        Mon, 29 Jan 2007 21:24:06 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id e1sm9783933ugf.2007.01.29.21.24.04;
        Mon, 29 Jan 2007 21:24:05 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <7v8xfl6s27.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38122>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 30 January 2007 10:45 Junio C Hamano =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(a):
> $ grep -A2 '^merge\.summary' Documentation/config.txt
> merge.summary::
> 	Whether to include summaries of merged commits in newly created
> 	merge commit messages. False by default.
Thanks !

> This is a good option if you are doing the top-level "bundling
> of others' work -- people will base their further work on this"
> merges.  On the other hand, if you are merging from your uplevel
> because your work depends on something that was updated recently,
> having the merge summary is often pointless (because the merge
> would bring in many mostly unrelated commits, in addition to that
> something your work depends on).  I think Linus has explicitly
> asked this option not enabled by people he pulls from for this
> reason.
I understand your point.
