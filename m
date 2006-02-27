From: "Nicolas Vilz 'niv'" <niv@iaglans.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch 
     directly
Date: Mon, 27 Feb 2006 21:47:14 +0100 (CET)
Message-ID: <62402.84.163.87.135.1141073234.squirrel@mail.geht-ab-wie-schnitzel.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
    <20060227184641.GA21684@hand.yhbt.net>
    <62354.84.163.87.135.1141068867.squirrel@mail.geht-ab-wie-schnitzel.de>
    <20060227202713.GB21684@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 21:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDpHN-00082n-5c
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 21:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWB0UrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWB0UrV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 15:47:21 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:35592 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S964806AbWB0UrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 15:47:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id E00C83FA9
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 21:47:18 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25731-06 for <git@vger.kernel.org>;
	Mon, 27 Feb 2006 21:47:15 +0100 (CET)
Received: from mail.geht-ab-wie-schnitzel.de (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 7AB3E3F7F
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 21:47:14 +0100 (CET)
Received: from 84.163.87.135
        (SquirrelMail authenticated user niv@geht-ab-wie-schnitzel.de)
        by mail.geht-ab-wie-schnitzel.de with HTTP;
        Mon, 27 Feb 2006 21:47:14 +0100 (CET)
In-Reply-To: <20060227202713.GB21684@hand.yhbt.net>
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16883>

Eric Wong wrote:
> [1] - See the 'Additional Fetch Arguments' section of the manpage for
> more info on this.  I'll freely admit that the UI for this was an
> accident, but it works fairly well for me.

btw, i think you have a typo in your man-page:
---
# Commit only the git commits you want to SVN::
        git-svn commit <tree-ish> [<tree-ish_2> ...]
# Commit all the git commits from my-branch that don't exist in SVN::
        git commit git-svn-HEAD..my-branch
---
i think the second one is intended to be "git-svn commit
git-svn-HEAD..my-branch", because you want to sync the SVN tree again, not
another git-tree i think...

Nicolas
