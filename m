From: Steven Michalske <smichalske@gmail.com>
Subject: Re: git-svn: What is --follow-parent / --no-follow-parent for?
Date: Wed, 28 Nov 2012 02:18:17 -0800
Message-ID: <E58261F3-F7E6-4F5B-A2D7-71E808EC6071@gmail.com>
References: <20121120073153.GA340@localhost>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Wed Nov 28 11:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdej3-0005FO-4H
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 11:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab2K1KS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 05:18:26 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63390 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab2K1KSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2012 05:18:25 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so9617964pbc.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 02:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=a6o+6aHT9QG4E++ioQ13C3zh3Q5lz14aidHhdpBi7EM=;
        b=oOBvl7tJylVuW2umR5U9AvOR/jRMh8QJLjftBeBOrfN2xG94l91upGO0w0dGCt9tpS
         cfm8tJZKeS7G9ZQrStONL7AR3HXVdct16t2qNOqSHconqy9gUf8h3kB1lqENjkorhdZF
         f+/jonU8zNM/in48rc+yk65ost1EWSlOQnJzgNW1x7kRnrYRO+4aSPE2WwTbtKl2TN1y
         XjD+n6dhgsZMri5HfAJ8anSgZfu8cQszB0ewhwiTiKTytz6+yjRHI11RVYaHj45VxTbj
         Y7nlaPtu6JZ0Ntpd7NtyrLJ+Fqw2De8gLQSsag6M23dL6zPVUPlZZh89nPYDw9UguYrg
         Uxzw==
Received: by 10.66.87.167 with SMTP id az7mr50875742pab.69.1354097902579;
        Wed, 28 Nov 2012 02:18:22 -0800 (PST)
Received: from [172.17.60.120] ([12.180.101.194])
        by mx.google.com with ESMTPS id qt3sm12238593pbb.32.2012.11.28.02.18.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 02:18:19 -0800 (PST)
In-Reply-To: <20121120073153.GA340@localhost>
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210727>


On Nov 19, 2012, at 11:31 PM, Sebastian Leske <Sebastian.Leske@sleske.name> wrote:
> 
> Commit graph of git-svn result:
> 
> --follow-parent:               --no-follow-parent:
> 
> 
>       |                               |
>      /|                             | |
>     / |                             | |
>     | |                             | |
>     | |                             | |
>     | |                             | |
>     \ |                             | |
>      \|                             | |
>       |                               | 
> 
> 
> (please excuse cheap ASCII art)
> 
> Is that the only effect of --no-follow-parent? And again, why would I
> want that?

I suppose that you would want this for a SVN repo that holds many different and possibly loosely related projects.
The you can apply git filter branch then to split them up cleanly.

e.g. Imagine that the two root commits of the branches do not have true common history.

Steve
