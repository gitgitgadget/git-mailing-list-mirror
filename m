From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: Re: [PATCH 0/2] Add MAINTAINERS file and clarify gui workflows
Date: Mon, 31 Dec 2012 13:22:29 -0500
Message-ID: <20121231182229.GA8665@gmail.com>
References: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
 <7va9svffr4.fsf@alter.siamese.dyndns.org>
 <loom.20121231T103639-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpk0j-0000Hz-1Q
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2LaSWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 13:22:33 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:41274 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2LaSWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 13:22:33 -0500
X-Greylist: delayed 86568 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2012 13:22:32 EST
Received: by mail-vc0-f180.google.com with SMTP id p16so12921998vcq.39
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q2JYZMt9uNhtCgzT7mAbvkuXd6E2qLiYsDMjTdgngpQ=;
        b=MCE0FyAKHtqMBw6T9dEcQPt9X/oTMUMkjiyD0ozFL85Q6P9ljDeD7LLtN9csgWdrCZ
         xWvgsrGDAgE1AK380KqSDc8NqZx+GVljW9/Hlt3exU/GsUqkgR9tb3smdfyr8L91DQNe
         iguxxvzJJt01FDc1zf6AFTtMGtJ2K8T9Vyn15LdcVdQ7M6+jiDO57rHMFbjQVupx6pY4
         t4Qhs3+J6K8DZLqnN6HhpEkWpMDS+HZejuZeszxAqvncmcdDvGWKrlHhRuBiiBg7EIbg
         E8TrUmasi8Xyd+Y+khKN+KWqk4Uz4l+anwetT37xiOYv47I7n4TchKC+e02UREE8CFQY
         W70g==
X-Received: by 10.52.156.67 with SMTP id wc3mr56921775vdb.19.1356978152343;
        Mon, 31 Dec 2012 10:22:32 -0800 (PST)
Received: from gmail.com (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id ly6sm32562462veb.3.2012.12.31.10.22.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 10:22:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20121231T103639-635@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212356>

On Mon, Dec 31, 2012 at 09:40:19AM +0000, Thomas Ackermann wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> > 
> > Thanks; I just realized that nothing in Documentation/ hierarchy
> > mentions these; they are only mentioned in "A Note from the
> > Maintainer" I send out every once in a while (kept in MaintNotes of
> > 'todo' branch):
> > 
> 
> Wouldn't it be a good idea to put MaintNotes somewhere below ./Documentation?
> 
> ---
> Thomas

Putting it in Documentation/ would add one more outlier file (Along w/
SubmittingPatches and CodingGuidelines).  Documentation/technical seems
too deep.  I've got a patch that incorporates the content into the
existing README, but that seems a bit out of place, as the previous content of
README was primarily pointers to other docs.

What about a README.developers at the toplevel?
