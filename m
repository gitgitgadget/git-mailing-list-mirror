From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Mon,  5 Nov 2007 01:29:29 +0100
Message-ID: <1194222569-13948-1-git-send-email-jnareb@gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
Cc: git list <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 01:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iopqf-0006xb-9W
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 01:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXKEA3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 19:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXKEA3e
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 19:29:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33376 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbXKEA3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 19:29:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so830449ugc
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hMugwUf1FnuGj/vadDUcdD3IclaIolUjXCRN/T3Ptaw=;
        b=rOWtCQnVuB0zuNN8FJZM8Bst7OMxn9XKkalJtZnQnmJyAry9nIwXZDENXXtqmCHq1Sx0iWkwJ2dPQxPvxfUP5BsBEA1XdLgv3MjAeFXnlJ2NU/8KrZ2OYHb33Xue2c2a6KOIMKpEIlzyaKMi/Cxg3un8hXNCC5dhg4f8HvJcEKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GHmOyRLMARjEtSDxswrsSxp5i85ixILVfE8dckS5S7UhAVeL8iIjZeQ3jk8XFGbAYUy90Mc8BdSQ+tmuyLEB0brj6p3pY5wyOJwM+2XToAhh8aiQVrru2BbH+GuYf8iLV0TF9zutEDAXSq/YVgYiMBnCwNKfd4oSQ2iUnSMObL4=
Received: by 10.66.249.16 with SMTP id w16mr3350395ugh.1194222572268;
        Sun, 04 Nov 2007 16:29:32 -0800 (PST)
Received: from roke.D-201 ( [83.8.200.241])
        by mx.google.com with ESMTPS id h4sm5875017nfh.2007.11.04.16.29.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 16:29:31 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA50TUON013964;
	Mon, 5 Nov 2007 01:29:31 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA50TT3P013962;
	Mon, 5 Nov 2007 01:29:29 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63463>

Lars Hjemli wrote:

> cgit v0.7 (a fast webinterface for git) is now available at
> 
>      git://hjemli.net/pub/git/cgit
> 
> This release includes better search capabilities, better diff,
> filtered and sorted branch/tag lists on the summary page, a simple way
> to switch between branches and finally a much needed restructuring of
> the user interface. There is even a brand new logo, and a number of
> bugfixes.
> 
> The latest version can be seen in action on http://hjemli.net/git/
> (disclaimer: I'm not a web/user interface designer, and should not be
> held responsible for any eyeball-related damages).

A few comments about new cgit:

 * Very nice cgit logo, but no favicon. Perhaps pacman head and G,
   or pacman head (like in logo) and +/-...

 * Providing reference with full sha1 of referenced object for tags
   list is not IMVHO a good design: what is interesting is type of
   tag, if it is signed it's first line, and if it is lightweight
   pointing to tag then perhaps commit subject.

 * Nice diffstat in commit view; the diff view is better, although I
   wouldn't lump from-file / to-file diff header together with git
   diff header and extended git diff header.

 * I like the sidebar very much, although I'm not sure how it would
   work for larger projects (more branches, much more tags). Also the
   search textbox is not very visible; I'd rather it have "groove"
   view.

 * I like separate 'mirrors' section, although I think it rather
   clashes badly with notion of forks (alternates).

 * I'm not sure if it wouln't be beter to provide -n/+m lines changed
   instead of nn likes changed column.

 * Nice submodule support!

By the way, Freedesktop provides besides standard gitweb interface
also cgit interface at
  http://cgit.freedesktop.org/
Take a look at how such site looks like with large number of projects
(perhaps sidebar is noot such a good idea then?), and with large
projects.

-- 
Jakub Narebski
Poland
