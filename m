From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cvs-migration.txt
Date: Mon, 16 Jan 2006 14:31:49 +1300
Message-ID: <46a038f90601151731vc72835dja390b7934a6b575f@mail.gmail.com>
References: <20060115195804.GD3985@fieldses.org>
	 <7vy81h2o3a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 02:32:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyJDx-0007Vx-IK
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 02:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWAPBbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 20:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWAPBbu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 20:31:50 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:7687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932156AbWAPBbu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 20:31:50 -0500
Received: by wproxy.gmail.com with SMTP id i34so964452wra
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 17:31:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EkJRjl4CP3AuuJKfX3+EqILRg0pMHpQb6dQKOVzrF7T404ccYm+BXoGH6V9GVp/gzDJicrtB/rEXgu4lx0X3N/JxTwjld5uEqu1xHC8wS3eBmGhVuFxfV8sBm+ABWtZhOySdRdvtSesAxoPBNG0Q2l+L6OHnC2Eq/l7h7wQ0dG4=
Received: by 10.54.113.17 with SMTP id l17mr6369531wrc;
        Sun, 15 Jan 2006 17:31:49 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Sun, 15 Jan 2006 17:31:49 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy81h2o3a.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14718>

On 1/16/06, Junio C Hamano <junkio@cox.net> wrote:
> what we are
> saying here is that you should never commit into these branches
> yourself and let cvsimport be the only one that touch them, so
> using commiter date and author date would not make a difference.

Exactly. You should make a new head off the one imported from cvs, and
work there. This supports continued use of cvsimport if the cvs repo
is still active. To bring in those changes you will have to merge them
into your branch.

If you are 200% certain that the cvs repo is going to be removed
immediately, you can ignore this advice. Run the cvsimport once, and
then start developing on top. If you do this, however, don't run that
cvsimport ever again, for it will mess up things royally ;)

But it's a bad idea to keep using the same branches in any case. Life
is saner if you work on new heads.


martin
